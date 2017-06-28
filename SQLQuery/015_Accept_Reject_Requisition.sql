
GO

-- drop proc spRejectRequisition
Create proc spRejectRequisition
@RequisitionID nvarchar(50),
@ApproverRemarks nvarchar(500),
@EntryBy nvarchar(50)
as
begin

begin tran
	
	Update tblRequisition Set IsRejected=1,RejectedBy=@EntryBy,RejectionDate=getdate(),Status='Rejected',
	ApproverRemarks=@ApproverRemarks
	Where RequisitionID=@RequisitionID
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

-- exec spAcceptRequisition 'REQ-00000010','WH-00000001','ITM-00000004',2,'Accepted','admin'

-- Select * from tblWarehouseItems

-- drop proc spAcceptRequisition
Create proc spAcceptRequisition
@RequisitionID nvarchar(50),
@WarehouseID nvarchar(50),
@ItemID nvarchar(50),
@ApprovedQuantity int,
@ApproverRemarks nvarchar(500),
@EntryBy nvarchar(50)
as
begin

	Declare @AvailableBalance int
	Set @AvailableBalance = 0

	Declare @WarehItemtbl table(
	WarehouseItemID nvarchar(50),
	ItmBalRemaining int,
	IsTaken bit default 0
	);

	Declare @QuantityApproved as int
	Declare @WarehouseItemID nvarchar(50)
	Declare @ItmBalRemaining int
	Declare @ItemBalAfterAdjustment as int 
	Set @ItemBalAfterAdjustment = 0

	Declare @UniqueUserID as nvarchar(50)
	Declare @ReqQuantity as int
	Declare @Remarks as nvarchar(500)
	Declare @EntryPoint as nvarchar(50)
	Declare @SupervisorID as nvarchar(50)
	Declare @DepartmentID as nvarchar(50)
	Declare @BranchID as nvarchar(50)
	Declare @RequestedBy as nvarchar(50)
	Declare @BalanceDiff as int
	Set @BalanceDiff = 0

begin tran

	Set @WarehouseItemID = ''
	Set @ItmBalRemaining = 0
	Set @QuantityApproved = @ApprovedQuantity

	-- If Approved Quantity < Requested Quantity Then Iniate Another Requisition
	Select @UniqueUserID=UniqueUserID,@ReqQuantity=Quantity,@Remarks=Remarks,@EntryPoint=EntryPoint,@SupervisorID=SupervisorID,
	@DepartmentID=DepartmentID,@BranchID=BranchID,@RequestedBy=EntryBy From tblRequisition Where @RequisitionID=RequisitionID

	If @QuantityApproved < @ReqQuantity 
	begin
		Set @BalanceDiff = @ReqQuantity-@QuantityApproved
		exec spInsertUserRequisition @UniqueUserID,@ItemID,@BalanceDiff,@Remarks,@EntryPoint,@SupervisorID,@DepartmentID,@BranchID,@RequestedBy 
		IF (@@ERROR <> 0) GOTO ERR_HANDLER
	end

	Insert Into @WarehItemtbl(WarehouseItemID,ItmBalRemaining)
	Select WarehouseItemID,(ItemBalance-AdjustedBalance) from tblWarehouseItems 
	Where WarehouseID=@WarehouseID And ItemID=@ItemID And IsAdjusted=0
	Order By (2) desc
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Select @AvailableBalance = dbo.fnGetWareHItemBalByItemID(@WarehouseID,@ItemID)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	If @AvailableBalance >= @ApprovedQuantity
	begin
		While @ApprovedQuantity > 0 
		begin
			Select top 1 @WarehouseItemID=WarehouseItemID, @ItmBalRemaining=ItmBalRemaining 
			From @WarehItemtbl Where IsTaken=0
			
			If @ApprovedQuantity < @ItmBalRemaining
			begin
				-- Insert Adjustment History
				exec spInsertWarehouseAdjHistory @RequisitionID,@WarehouseItemID,@ApprovedQuantity
				IF (@@ERROR <> 0) GOTO ERR_HANDLER

				-- Update Warehouse
				Update tblWarehouseItems Set AdjustedBalance= isnull(AdjustedBalance,0)+ @ApprovedQuantity
				Where WarehouseItemID=@WarehouseItemID
				IF (@@ERROR <> 0) GOTO ERR_HANDLER

				Set @ApprovedQuantity = 0
			end
			else
			begin
				-- Insert Adjustment History
				exec spInsertWarehouseAdjHistory @RequisitionID,@WarehouseItemID,@ItmBalRemaining
				IF (@@ERROR <> 0) GOTO ERR_HANDLER

				-- Update Warehouse
				Update tblWarehouseItems Set AdjustedBalance= isnull(AdjustedBalance,0)+ @ItmBalRemaining
				Where WarehouseItemID=@WarehouseItemID
				IF (@@ERROR <> 0) GOTO ERR_HANDLER

				Set @ApprovedQuantity = @ApprovedQuantity - @ItmBalRemaining
			end

			-- Chq. For Balance Adjusted..
			Select @ItemBalAfterAdjustment = (ItemBalance-AdjustedBalance) from tblWarehouseItems Where WarehouseItemID=@WarehouseItemID
			IF (@@ERROR <> 0) GOTO ERR_HANDLER

			if @ItemBalAfterAdjustment = 0
			begin
				Update tblWarehouseItems Set IsAdjusted=1, AdjustmentDate=getdate()
				Where WarehouseItemID=@WarehouseItemID
				IF (@@ERROR <> 0) GOTO ERR_HANDLER
			end
			
			Update @WarehItemtbl Set IsTaken=1
			Where WarehouseItemID=@WarehouseItemID
			IF (@@ERROR <> 0) GOTO ERR_HANDLER

			Set @WarehouseItemID = ''
			Set @ItmBalRemaining = 0
			Set @ItemBalAfterAdjustment = 0
		end
	end

	-- Update Requisition
	If @ApprovedQuantity=0
	begin
		Update tblRequisition Set IsApproved=1,ApprovedBy=@EntryBy,ApprovalDate=getdate(),
		Status='Approved',ApproverRemarks=@ApproverRemarks,ApprovedQuantity=@QuantityApproved
		Where RequisitionID=@RequisitionID
		IF (@@ERROR <> 0) GOTO ERR_HANDLER
	end
	
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create proc spAdvAcceptRequisition
@RequisitionIDList nvarchar(50),
@WarehouseID nvarchar(50),
@ApproverRemarks nvarchar(500),
@EntryBy nvarchar(50)
as
begin
	Declare @Index as int
	Declare @CurrentData as nvarchar(4000)
	Declare @RestData as nvarchar(4000)
	Declare @RestPortion as nvarchar(4000)

	Declare @RequisitionID as nvarchar(50)
	Declare @ItemID as nvarchar(50)
	Declare @ApprovedQuantity as int
	
	Set @RequisitionID = ''
	Set @ItemID = ''
	Set @ApprovedQuantity = 0

begin tran

	set @RestData=@RequisitionIDList
	while @RestData<>''
	begin
		set @Index=CHARINDEX('|',@RestData)
		set @CurrentData=substring(@RestData,1,@Index-1)
		set @RestData=substring(@RestData,@Index+1,len(@RestData))		
		
		set @RestPortion=@CurrentData
		
		set @Index=CHARINDEX('~',@RestPortion)		
		set @RequisitionID=substring(@RestPortion,1,@Index-1)
		set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	
		
		Select @ItemID=ItemID,@ApprovedQuantity=Quantity from tblRequisition Where RequisitionID=@RequisitionID
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		exec spAcceptRequisition @RequisitionID,@WarehouseID,@ItemID,@ApprovedQuantity,@ApproverRemarks,@EntryBy
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		Set @ItemID=''
		Set @ApprovedQuantity=0
		Set @RequisitionID=''
						
	end
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end
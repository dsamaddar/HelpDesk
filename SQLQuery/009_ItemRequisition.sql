
insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentRequisitionID',0)

GO

insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentRequisitionEntryPoint',9000)

GO

-- drop table tblRequisition
Create table tblRequisition(
RequisitionID nvarchar(50) primary key,
EmployeeID nvarchar(50) foreign key references tblEmployeeInfo(EmployeeID),
ItemID nvarchar(50) foreign key references tblInventoryItems(ItemID),
Quantity int,
Remarks nvarchar(500),
EntryPoint nvarchar(50),
SupervisorID nvarchar(50)  foreign key references tblEmployeeInfo(EmployeeID),
DepartmentID nvarchar(50) foreign key references tblDepartment(DepartmentID),
BranchID nvarchar(50) foreign key references tblULCBranch(ULCBranchID),
IsDeptApproved bit default 0,
DeptApprovedBy nvarchar(50),
DeptApprovalDate datetime,
IsOnDemandRequisition bit default 0,
OnDemandRequisitionFor nvarchar(50) foreign key references tblEmployeeInfo(EmployeeID),
IsApproved bit default 0,
ApprovedBy nvarchar(50),
ApprovalDate datetime,
ApprovedQuantity int default 0,
IsRejected bit default 0,
RejectedBy nvarchar(50) ,
RejectionDate datetime,
IsDelivered bit default 0,
DeliveredBy nvarchar(50),
DeliveryDate datetime,
DeliveryEntryPoint nvarchar(50),
Status nvarchar(50),
MailStatus nvarchar(50),
ApproverRemarks nvarchar(500),
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO

-- drop view vwRequisition
alter view vwRequisition
as
Select R.RequisitionID,R.EmployeeID,R.ItemID,
(Select I.ItemName+ ' ( '+ (Select UNT.UnitType from tblUnitType UNT Where UNT.UnitTypeID= I. UnitTypeID) +' )'from tblInventoryItems I Where I.ItemID=R.ItemID) as 'ItemName',
R.Quantity,R.Remarks,R.EntryPoint,isnull(R.SuperVisorID,'N\A') as 'SuperVisorID',isnull((Select UserName from tblUsers U Where U.UniqueUserID = R.SuperVisorID) ,'N\A') as 'Supervisor',
isnull(R.DepartmentID,'N\A') as 'DepartmentID',isnull( (Select DeptName from tblDepartment D Where D.DepartmentID = R.DepartmentID) ,'N\A' ) as 'Department',
isnull(R.BranchID,'N\A') as 'BranchID',isnull((Select ULCBranchName  from tblULCBranch B Where B.ULCBranchID=R.BranchID),'N\A') as 'BranchName',
R.IsApproved,
ApprovalStatus = 
Case R.IsApproved 
	When 1 Then 'Approved'
	Else 'Pending/Rejected' 
End, 
IsDelivered = 
Case R.IsDelivered
	When 1 Then 'Delivered'
	Else 'Not Delivered Yet'
End, isnull(DeliveredBy,'N\A') as 'DeliveredBy', isnull(Convert(nvarchar,DeliveryDate,106),'N\A' ) as 'DeliveryDate',
isnull(Convert(nvarchar,R.ApprovalDate,106),'N\A') as 'ApprovalDate',R.IsDeptApproved,R.IsRejected,
R.ApprovedQuantity,ApproverRemarks,Status, Convert(nvarchar,EntryDate,106) as 'RequisitionDate'
from tblRequisition R

-- Select * from vwRequisition

GO

-- drop proc spGetReqHistoryByUserID
alter proc spGetReqHistoryByUserID
@EmployeeID nvarchar(50)
as
begin
	Select RequisitionID,EmployeeID,ItemID,ItemName,Remarks,EntryPoint,SuperVisorID,Supervisor,DepartmentID,
	Department,BranchID,BranchName,IsApproved,ApprovalDate,
	IsDelivered,DeliveredBy,DeliveryDate,ApprovedQuantity,ApproverRemarks,RequisitionDate
	From vwRequisition Where EmployeeID=@EmployeeID
	Order by Convert(datetime,RequisitionDate) desc
end

-- exec spGetReqHistoryByUserID 'USR-00000001'

GO

-- drop proc spItmReqForDeptApproval
alter proc spItmReqForDeptApproval
@DateFrom datetime,
@DateTo datetime,
@BranchID nvarchar(50),
@DepartmentID nvarchar(50),
@SupervisorID nvarchar(50)
as
begin
	Declare @BranchIDParam as nvarchar(50)
	Declare @DepartmentIDParam as nvarchar(50)
	Declare @SupervisorIDParam as nvarchar(50)
	Set  @BranchIDParam = ''
	Set @DepartmentIDParam=''

	If @SupervisorID='N\A'
		Set @SupervisorIDParam = '%'
	Else
		Set @SupervisorIDParam = '%' + @SupervisorID + '%'

	If @DepartmentID = 'N\A'
		Set @DepartmentIDParam = '%'
	Else
		Set @DepartmentIDParam = '%' + @DepartmentID + '%'

	If @DateTo = '1/1/1900'
		Set @DateTo = '1/1/2099'

	If @BranchID = 'N\A'
		Set @BranchIDParam = '%'
	Else
		Set @BranchIDParam = '%' + @BranchID + '%'
	
	Select R.RequisitionID,EmployeeID,(Select EmployeeName from tblEmployeeInfo E Where E.EmployeeID=R.EmployeeID) as 'EmployeeName',
	R.ItemID,R.ItemName,R.Quantity,R.Remarks,
	isnull(R.DepartmentID,'N\A') as 'DepartmentID',R.Department as 'DepartmentName'
	,isnull(R.BranchID,'N\A') as 'BranchID',R.BranchName as 'BranchName'
	from vwRequisition R
	Where (R.SuperVisorID like @SupervisorIDParam)
	And R.IsDeptApproved=0 
	And R.IsRejected=0
	And R.DepartmentID like @DepartmentIDParam
	And R.RequisitionDate between @DateFrom And @DateTo
	And (R.BranchID like @BranchIDParam or R.BranchID is null )
	
end

-- Select * from vwRequisition
-- exec spItmReqForDeptApproval  '1/1/1900','1/1/1900','N\A','N\A','EMP-00000009'

GO

-- drop proc spReqDeptApproval
Create proc spReqDeptApproval
@RequisitionIDList nvarchar(4000),
@EntryBy nvarchar(50)
as
begin
	Declare @ReqItmTbl table(
	RequisitionID nvarchar(50)
	);

begin tran

	Insert into @ReqItmTbl(RequisitionID)
	Select * from dbo.Split(',',@RequisitionIDList)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Update tblRequisition Set IsDeptApproved=1,DeptApprovedBy=@EntryBy,DeptApprovalDate=getdate(),
	Status='DeptApproved'
	Where RequisitionID in (Select Distinct RequisitionID from @ReqItmTbl)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

-- exec spReqDeptApproval 'REQ-00000013,REQ-00000014,REQ-00000015','dsamaddar'

GO

-- drop proc spReqDeptRejection
Create proc spReqDeptRejection
@RequisitionIDList nvarchar(4000),
@ApproverRemarks nvarchar(50),
@EntryBy nvarchar(50)
as
begin

	Declare @ReqItmTbl table(
	RequisitionID nvarchar(50)
	);

begin tran

	Insert into @ReqItmTbl(RequisitionID)
	Select * from dbo.Split(',',@RequisitionIDList)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Update tblRequisition Set IsRejected=1,RejectedBy=@EntryBy,RejectionDate=getdate(),
	Status='Rejected',ApproverRemarks=@ApproverRemarks
	Where RequisitionID in (Select Distinct RequisitionID from @ReqItmTbl)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create View vwReqAdjHistory
As
Select WAH.RequisitionID,WI.WarehouseID,(Select WarehouseName from tblWarehouse W Where W.WarehouseID=WI.WarehouseID) as 'WarehouseName',
WAH.WarehouseAdjID
from tblWarehouseItems WI Left Join tblWarehouseAdjHistory WAH On WI.WarehouseItemID=WAH.WarehouseItemID

-- Select * from vwReqAdjHistory

GO
-- drop proc spGetPendingReqListToDeliver
alter proc spGetPendingReqListToDeliver
@DateFrom datetime,
@DateTo datetime,
@BranchID nvarchar(50),
@DepartmentID nvarchar(50)
as
begin
	Declare @BranchIDParam as nvarchar(50)
	Declare @DepartmentIDParam as nvarchar(50)
	Set  @BranchIDParam = ''
	Set @DepartmentIDParam=''

	If @DepartmentID = 'N\A'
		Set @DepartmentIDParam = '%'
	Else
		Set @DepartmentIDParam = '%' + @DepartmentID + '%'

	If @DateTo = '1/1/1900'
		Set @DateTo = '1/1/2099'

	If @BranchID = 'N\A'
		Set @BranchIDParam = '%'
	Else
		Set @BranchIDParam = '%' + @BranchID + '%'
	
	Select R.RequisitionID,EmployeeID,(Select EmployeeName from tblEmployeeInfo E Where E.EmployeeID=R.EmployeeID) as 'EmployeeName',
	R.ItemID,(Select ItemName+ ' ( '+ (Select UnitType from tblUnitType UNT Where UNT.UnitTypeID= I. UnitTypeID) +' )'from tblInventoryItems I Where I.ItemID=R.ItemID) as 'ItemName',
	R.Quantity,R.ApprovedQuantity,R.ApproverRemarks,
	isnull(R.DepartmentID,'N\A') as 'DepartmentID',isnull((Select DepartmentName from tblDepartment D Where D.DepartmentID=R.DepartmentID),'N\A') as 'DepartmentName'
	,isnull(R.BranchID,'N\A') as 'BranchID',isnull((Select BranchName from tblBranchInfo B Where B.BranchID=R.BranchID),'N\A') as 'BranchName',
	vRAH.WarehouseID,vRAH.WarehouseName,Convert(nvarchar,R.EntryDate,106) as 'RequisitionDate',Convert(nvarchar,R.ApprovalDate,106) as 'ApprovalDate'
	from tblRequisition R Left Join vwReqAdjHistory vRAH On  R.RequisitionID=vRAH.RequisitionID
	Where R.IsDeptApproved=1 And R.IsApproved=1 And R.IsRejected=0 And R.IsDelivered=0
	And R.DepartmentID like '' + @DepartmentIDParam + ''
	And R.EntryDate between @DateFrom And @DateTo
	And (R.BranchID like '' + @BranchIDParam + '' or R.BranchID is null )
	
end

-- exec spGetPendingReqListToDeliver  '1/1/1900','1/1/1900','N\A','N\A'

GO
-- drop proc spDeliverRequisition
Create proc spDeliverRequisition
@RequisitionIDList nvarchar(4000),
@DeliveredBy nvarchar(50)
as
begin
	Declare @ReqItmTbl table(
	RequisitionID nvarchar(50)
	);

	Declare @DeliveryEntryPoint as nvarchar(50)

begin tran
	
	Set @DeliveryEntryPoint = convert(nvarchar,getdate(),102)+'.'+convert(nvarchar,getdate(),114)

	Insert into @ReqItmTbl(RequisitionID)
	Select * from dbo.Split(',',@RequisitionIDList)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Update tblRequisition Set IsDelivered=1,DeliveredBy=@DeliveredBy,DeliveryDate=getdate(),
	Status='Delivered',DeliveryEntryPoint = @DeliveryEntryPoint
	Where RequisitionID in (Select Distinct RequisitionID from @ReqItmTbl)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	
COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create proc spGetDeliveryEntryPoint
as
begin
	Select Distinct DeliveryEntryPoint from tblRequisition Where DeliveryEntryPoint is not null
end

-- exec spGetDeliveryEntryPoint

GO

alter proc spGetReqByDeliveryEntryPoint
@DeliveryEntryPoint nvarchar(50)
as
begin
	Select R.RequisitionID,EmployeeID,(Select EmployeeName from tblEmployeeInfo E Where E.EmployeeID=R.EmployeeID) as 'EmployeeName',
	R.ItemID,(Select ItemName+ ' ( '+ (Select UnitType from tblUnitType UNT Where UNT.UnitTypeID= I. UnitTypeID) +' )'from tblInventoryItems I Where I.ItemID=R.ItemID) as 'ItemName',
	R.Quantity,R.ApprovedQuantity,R.ApproverRemarks,
	isnull(R.DepartmentID,'N\A') as 'DepartmentID',isnull((Select DepartmentName from tblDepartment D Where D.DepartmentID=R.DepartmentID),'N\A') as 'DepartmentName'
	,isnull(R.BranchID,'N\A') as 'BranchID',isnull((Select BranchName from tblBranchInfo B Where B.BranchID=R.BranchID),'N\A') as 'BranchName',
	vRAH.WarehouseID,vRAH.WarehouseName
	from tblRequisition R Left Join vwReqAdjHistory vRAH On  R.RequisitionID=vRAH.RequisitionID
	Where DeliveryEntryPoint=@DeliveryEntryPoint
end

-- exec spGetReqByDeliveryEntryPoint ''
GO

-- drop proc spSearchItemRequisition
Alter proc spSearchItemRequisition
@DateFrom datetime,
@DateTo datetime,
@WarehouseID nvarchar(50),
@BranchID nvarchar(50),
@DepartmentID nvarchar(50),
@EmployeeID nvarchar(50),
@ItemID nvarchar(50)
as
begin
	
	Declare @BranchIDParam as nvarchar(50)
	Declare @DepartmentIDParam as nvarchar(50)
	Declare @EmployeeIDParam as nvarchar(50)
	Declare @ItemIDParam as nvarchar(50)
	
	If @BranchID = 'N\A'
		Set @BranchIDParam = '%'
	Else
		Set @BranchIDParam = '%'+ @BranchID +'%'

	If @DepartmentID = 'N\A'
		Set @DepartmentIDParam = '%'
	else
		Set @DepartmentIDParam = '%' + @DepartmentID + '%'

	if @EmployeeID = 'N\A'
		Set @EmployeeIDParam = '%'
	Else
		Set @EmployeeIDParam = '%'+ @EmployeeID +'%'

	If @ItemID = 'N\A'
		Set @ItemIDParam = '%'
	Else
		Set @ItemIDParam = '%'+ @ItemID +'%'
	

	Select R.RequisitionID,EmployeeID,(Select EmployeeName from tblEmployeeInfo E Where E.EmployeeID=R.EmployeeID) as 'EmployeeName',
	R.ItemID,R.ItemName,Convert(nvarchar,R.RequisitionDate,106) as 'RequisitionDate',
	R.Quantity,dbo.fnGetWareHItemBalByItemID(@WarehouseID,R.ItemID) as 'Balance',R.Remarks,isnull(R.BranchID,'N\A') as 'BranchID',isnull((Select BranchName from tblBranchInfo B Where B.BranchID=R.BranchID),'N\A') as 'BranchName'
	from vwRequisition R
	Where @DepartmentID like @DepartmentIDParam
	And R.RequisitionDate between @DateFrom And @DateTo
	And ( R.BranchID like @BranchIDParam or R.BranchID is null )
	And ( R.DepartmentID like @DepartmentIDParam or R.DepartmentID is null )
	And R.EmployeeID like @EmployeeIDParam
	And R.ItemID like @ItemIDParam
	And IsDeptApproved=1 And IsApproved=0 And IsRejected=0
	Order by R.RequisitionDate 
end

-- Select * from vwRequisition
-- exec spSearchItemRequisition '1/1/1900','1/1/2099','WH-00000005','N\A','N\A','N\A','N\A'

GO

-- drop proc spInsertRequisition
alter proc spInsertUserRequisition
@EmployeeID nvarchar(50),
@ItemID nvarchar(50),
@Quantity int,
@Remarks nvarchar(500),
@EntryPoint nvarchar(50),
@SupervisorID nvarchar(50),
@DepartmentID nvarchar(50),
@BranchID nvarchar(50),
@EntryBy nvarchar(50)
as
begin
	Declare @RequisitionID nvarchar(50)
	Declare @CurrentRequisitionID numeric(18,0)
	Declare @RequisitionIDPrefix as nvarchar(4)

	set @RequisitionIDPrefix='REQ-'

begin tran

	If @SupervisorID='N\A'
	begin
		Set @SupervisorID = null
	end

	if @DepartmentID='N\A'
	begin
		Set @DepartmentID = null
	end

	if @BranchID = 'N\A'
	begin
		Set @BranchID = null
	end

	select @CurrentRequisitionID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentRequisitionID'
	
	set @CurrentRequisitionID=isnull(@CurrentRequisitionID,0)+1
	Select @RequisitionID=dbo.generateID(@RequisitionIDPrefix,@CurrentRequisitionID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert Into tblRequisition(RequisitionID,EmployeeID,ItemID,Quantity,Remarks,EntryPoint,SupervisorID,DepartmentID,BranchID,Status,MailStatus,EntryBy)
	Values(@RequisitionID,@EmployeeID,@ItemID,@Quantity,@Remarks,@EntryPoint,@SupervisorID,@DepartmentID,@BranchID,'','Waiting',@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	if @SupervisorID = 'N\A' or @SupervisorID is null
	begin
		Update tblRequisition Set IsDeptApproved=1,DeptApprovedBy=@EntryBy,DeptApprovalDate=getdate()
		Where RequisitionID=@RequisitionID
	end

	update tblAppSettings set PropertyValue=@CurrentRequisitionID where PropertyName='CurrentRequisitionID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

-- exec spInsertMultipleRequisition 'USR-00000001','ITM-00000004~2~N\A~|ITM-00000002~5~na~|ITM-00000001~9~N\A~|','admin'

-- drop proc spInsertMultipleRequisition
Alter proc spInsertMultipleRequisition
@EmployeeID nvarchar(50),
@RequisitionItemList nvarchar(4000),
@EntryBy nvarchar(50)
as
begin
	Declare @Index as int
	Declare @CurrentData as nvarchar(4000)
	Declare @RestData as nvarchar(4000)
	Declare @RestPortion as nvarchar(4000)

	Declare @SupervisorID as nvarchar(50)
	Declare @DepartmentID as nvarchar(50)
	Declare @BranchID as nvarchar(50)

	Declare @ItemID as nvarchar(50)
	Declare @Quantity as int
	Declare @Remarks as nvarchar(500)

	Declare @EntryPoint nvarchar(50)
	Declare @CurrentEntryPoint numeric(18,0)
	Declare @EntryPointPrefix as nvarchar(4)

	set @EntryPointPrefix='ENT-'

	Select @SupervisorID=CurrentSupervisor,@DepartmentID=DepartmentID,@BranchID=ULCBranchID from tblEmployeeInfo
	Where EmployeeID=@EmployeeID

	
begin tran

	select @CurrentEntryPoint = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentRequisitionEntryPoint'
	
	print convert(nvarchar,@CurrentEntryPoint)
	set @CurrentEntryPoint=isnull(@CurrentEntryPoint,0)+1
	Select @EntryPoint=dbo.generateID(@EntryPointPrefix,@CurrentEntryPoint,8)	

	Print @EntryPoint
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	set @RestData=@RequisitionItemList
	while @RestData<>''
	begin
		set @Index=CHARINDEX('|',@RestData)
		set @CurrentData=substring(@RestData,1,@Index-1)
		set @RestData=substring(@RestData,@Index+1,len(@RestData))		
		
		set @RestPortion=@CurrentData
		
		set @Index=CHARINDEX('~',@RestPortion)		
		set @ItemID=substring(@RestPortion,1,@Index-1)
		set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	
		
		set @Index=CHARINDEX('~',@RestPortion)		
		set @Quantity=convert(int,substring(@RestPortion,1,@Index-1))
		set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))
		
		set @Index=CHARINDEX('~',@RestPortion)		
		set @Remarks=substring(@RestPortion,1,@Index-1)
		set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	
		
		exec spInsertUserRequisition @EmployeeID,@ItemID,@Quantity,@Remarks,@EntryPoint,@SupervisorID,@DepartmentID,@BranchID,@EntryBy
		IF (@@ERROR <> 0) GOTO ERR_HANDLER
		
		Set @ItemID=''
		Set @Quantity=''
		Set @Remarks=''
						
	end

	update tblAppSettings set PropertyValue=@CurrentEntryPoint where PropertyName='CurrentRequisitionEntryPoint'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

-- drop proc spInsertOnDemandRequisition
alter proc spInsertOnDemandRequisition
@EmployeeID nvarchar(50),
@ItemID nvarchar(50),
@Quantity int,
@Remarks nvarchar(500),
@EntryPoint nvarchar(50),
@SupervisorID nvarchar(50),
@DepartmentID nvarchar(50),
@BranchID nvarchar(50),
@EntryBy nvarchar(50)
as
begin
	Declare @RequisitionID nvarchar(50)
	Declare @CurrentRequisitionID numeric(18,0)
	Declare @RequisitionIDPrefix as nvarchar(4)

	set @RequisitionIDPrefix='REQ-'

begin tran

	If @SupervisorID='N\A'
	begin
		Set @SupervisorID = null
	end

	if @DepartmentID='N\A'
	begin
		Set @DepartmentID = null
	end

	if @BranchID = 'N\A'
	begin
		Set @BranchID = null
	end

	select @CurrentRequisitionID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentRequisitionID'
	
	set @CurrentRequisitionID=isnull(@CurrentRequisitionID,0)+1
	Select @RequisitionID=dbo.generateID(@RequisitionIDPrefix,@CurrentRequisitionID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert Into tblRequisition(RequisitionID,EmployeeID,ItemID,Quantity,Remarks,EntryPoint,SupervisorID,DepartmentID,BranchID,
	IsDeptApproved,DeptApprovedBy,DeptApprovalDate,IsOnDemandRequisition,OnDemandRequisitionFor,Status,MailStatus,EntryBy)
	Values(@RequisitionID,@EmployeeID,@ItemID,@Quantity,@Remarks,@EntryPoint,@SupervisorID,@DepartmentID,@BranchID,
	1,@EntryBy,getdate(),1,@EmployeeID,'','Waiting',@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	if @SupervisorID = 'N\A' or @SupervisorID is null
	begin
		Update tblRequisition Set IsDeptApproved=1,DeptApprovedBy=@EntryBy,DeptApprovalDate=getdate()
		Where RequisitionID=@RequisitionID
	end

	update tblAppSettings set PropertyValue=@CurrentRequisitionID where PropertyName='CurrentRequisitionID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

-- drop proc spInsertMultipleOnDemandReq
alter proc spInsertMultipleOnDemandReq
@RequisitionItemList nvarchar(4000),
@EntryBy nvarchar(50)
as
begin
	Declare @Index as int
	Declare @CurrentData as nvarchar(4000)
	Declare @RestData as nvarchar(4000)
	Declare @RestPortion as nvarchar(4000)

	Declare @SupervisorID as nvarchar(50)
	Declare @DepartmentID as nvarchar(50)
	Declare @BranchID as nvarchar(50)

	Declare @ItemID as nvarchar(50)
	Declare @Quantity as int
	Declare @Remarks as nvarchar(500)
	Declare @EmployeeID as nvarchar(50)

	Declare @EntryPoint nvarchar(50)
	Declare @CurrentEntryPoint numeric(18,0)
	Declare @EntryPointPrefix as nvarchar(4)

	set @EntryPointPrefix='ENT-'
begin tran

	select @CurrentEntryPoint = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentRequisitionEntryPoint'
	
	print convert(nvarchar,@CurrentEntryPoint)
	set @CurrentEntryPoint=isnull(@CurrentEntryPoint,0)+1
	Select @EntryPoint=dbo.generateID(@EntryPointPrefix,@CurrentEntryPoint,8)	

	Print @EntryPoint
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	set @RestData=@RequisitionItemList
	while @RestData<>''
	begin
		set @Index=CHARINDEX('|',@RestData)
		set @CurrentData=substring(@RestData,1,@Index-1)
		set @RestData=substring(@RestData,@Index+1,len(@RestData))		
		
		set @RestPortion=@CurrentData
		
		set @Index=CHARINDEX('~',@RestPortion)		
		set @ItemID=substring(@RestPortion,1,@Index-1)
		set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	
		
		set @Index=CHARINDEX('~',@RestPortion)		
		set @Quantity=convert(int,substring(@RestPortion,1,@Index-1))
		set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))
		
		set @Index=CHARINDEX('~',@RestPortion)		
		set @Remarks=substring(@RestPortion,1,@Index-1)
		set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	

		set @Index=CHARINDEX('~',@RestPortion)		
		set @EmployeeID=substring(@RestPortion,1,@Index-1)
		set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))

		Select @SupervisorID=CurrentSupervisor,@DepartmentID=DepartmentID,@BranchID=ULCBranchID from tblEmployeeInfo
		Where EmployeeID=@EmployeeID
		
		exec spInsertOnDemandRequisition @EmployeeID,@ItemID,@Quantity,@Remarks,@EntryPoint,@SupervisorID,@DepartmentID,@BranchID,@EntryBy
		IF (@@ERROR <> 0) GOTO ERR_HANDLER
		
		Set @ItemID=''
		Set @Quantity=''
		Set @Remarks=''
		Set @EmployeeID = ''
		Set @SupervisorID = ''
		Set @DepartmentID = ''
		Set @BranchID = ''
	end

	update tblAppSettings set PropertyValue=@CurrentEntryPoint where PropertyName='CurrentRequisitionEntryPoint'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

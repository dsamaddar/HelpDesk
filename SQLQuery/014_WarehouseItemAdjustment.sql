

GO

-- drop function fnGetWareHItemBalByItemID
Create function fnGetWareHItemBalByItemID(@WarehouseID nvarchar(50),@ItemID nvarchar(50))
returns int
as
begin
	Declare @AvailableBalance int
	Set @AvailableBalance = 0

	Select @AvailableBalance = isnull( Sum(ItemBalance-AdjustedBalance),0)
	from  tblWarehouseItems WI Where WarehouseID=@WarehouseID And ItemID=@ItemID
	group by ItemID 

	Set @AvailableBalance = isnull(@AvailableBalance,0)

	return @AvailableBalance
end

GO


insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentWarehouseAdjID',0)

GO

-- drop table tblWarehouseAdjHistory
Create table tblWarehouseAdjHistory(
WarehouseAdjID nvarchar(50) primary key,
RequisitionID nvarchar(50) foreign key references tblRequisition(RequisitionID),
WarehouseItemID nvarchar(50) foreign key references tblWarehouseItems(WarehouseItemID),
AdjustedBalance int,
AdjustmentDate datetime default getdate()
);

-- Select * from tblWarehouseAdjHistory

GO

-- drop proc spInsertWarehouseAdjHistory
Create proc spInsertWarehouseAdjHistory
@RequisitionID nvarchar(50),
@WarehouseItemID nvarchar(50),
@AdjustedBalance int
as
begin
	Declare @WarehouseAdjID nvarchar(50)
	Declare @CurrentWarehouseAdjID numeric(18,0)
	Declare @WarehouseAdjIDPrefix as nvarchar(7)

	set @WarehouseAdjIDPrefix='WH-ADJ-'
begin tran

	select @CurrentWarehouseAdjID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentWarehouseAdjID'
	
	set @CurrentWarehouseAdjID=isnull(@CurrentWarehouseAdjID,0)+1
	Select @WarehouseAdjID=dbo.generateID(@WarehouseAdjIDPrefix,@CurrentWarehouseAdjID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
	Insert Into tblWarehouseAdjHistory(WarehouseAdjID,RequisitionID,WarehouseItemID,AdjustedBalance)
	Values(@WarehouseAdjID,@RequisitionID,@WarehouseItemID,@AdjustedBalance)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=convert(nvarchar,@CurrentWarehouseAdjID) where PropertyName='CurrentWarehouseAdjID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end


GO


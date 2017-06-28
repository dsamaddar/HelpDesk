

insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentWarehouseID',0)

GO

-- drop table tblWarehouse
Create table tblWarehouse(
WarehouseID nvarchar(50) primary key,
WarehouseName nvarchar(200) unique(WarehouseName),
WarehouseCode nvarchar(50) unique(WarehouseCode),
BranchID nvarchar(50) foreign key references tblULCBranch(ULCBranchID),
Location nvarchar(500),
Details nvarchar(500),
IsActive bit default 1,
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO

-- drop proc spInsertWarehouse
CREATE proc spInsertWarehouse
@WarehouseName nvarchar(200),
@WarehouseCode nvarchar(50),
@BranchID nvarchar(50),
@Location nvarchar(500),
@Details nvarchar(500),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @WarehouseID nvarchar(50)
	Declare @CurrentWarehouseID numeric(18,0)
	Declare @WarehouseIDPrefix as nvarchar(3)

	set @WarehouseIDPrefix='WH-'

	if @BranchID = 'N\A'
	begin
		Set @BranchID = null
	End

begin tran

	select @CurrentWarehouseID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentWarehouseID'
	
	set @CurrentWarehouseID=isnull(@CurrentWarehouseID,0)+1
	Select @WarehouseID=dbo.generateID(@WarehouseIDPrefix,@CurrentWarehouseID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert Into tblWarehouse(WarehouseID,WarehouseName,WarehouseCode,BranchID,Location,Details,IsActive,EntryBy)
	Values(@WarehouseID,@WarehouseName,@WarehouseCode,@BranchID,@Location,@Details,@IsActive,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentWarehouseID where PropertyName='CurrentWarehouseID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create proc spGetWarehouseList
as
begin
	Select distinct WarehouseID,WarehouseName from tblWarehouse Where IsActive=1
	Order by WarehouseName
end

GO

-- drop proc spGetDetailsWarehouseList
Create proc spGetDetailsWarehouseList
as
begin
	Select WarehouseID,WarehouseName,WarehouseCode,isnull(BranchID,'N\A') as 'BranchID',
	isnull((Select BranchName from tblBranchInfo B Where B.BranchID= W.BranchID),'N\A') as 'BranchName',
	Location,Details,
	IsActive=Case IsActive When 1 then 'Active' Else 'InActive' End,
	EntryBy,
	Convert(nvarchar,EntryDate,106) as 'EntryDate' from tblWarehouse W
	Order by WarehouseName
end

-- exec spGetDetailsWarehouseList

GO

-- drop proc spUpdateWarehouse
Create proc spUpdateWarehouse
@WarehouseID nvarchar(50),
@WarehouseName nvarchar(200),
@WarehouseCode nvarchar(50),
@BranchID nvarchar(50),
@Location nvarchar(500),
@Details nvarchar(500),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin

begin tran

	Update tblWarehouse Set WarehouseName=@WarehouseName,WarehouseCode=@WarehouseCode,BranchID=@BranchID,
	Location=@Location,Details=@Details,IsActive=@IsActive,EntryBy=@EntryBy
	Where WarehouseID=@WarehouseID
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end
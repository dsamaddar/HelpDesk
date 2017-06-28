
GO

insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentItemID',0)

GO

-- drop table tblInventoryItems
Create table tblInventoryItems(
ItemID nvarchar(50) primary key,
ItemName nvarchar(200) unique(ItemName),
ItemCode nvarchar(200) unique(ItemCode),
UnitTypeID nvarchar(50) foreign key references tblUnitType(UnitTypeID),
LowBalanceReport int,
MaxAllowableRequisition int,
IsActive bit default 1,
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO

-- drop proc spGetItemList
Create proc spGetItemList
as
begin
	Select Distinct I.ItemID,( ItemName + ' ( ' +isnull((Select UnitType from tblUnitType U Where U.UnitTypeID=I.UnitTypeID),'N\A')  + ' ) ' ) as 'ItemName'
	from tblInventoryItems I Where IsActive=1
	Order by ItemName
end

GO

Create proc spGetReqRemItemList
as
begin
	Select Distinct I.ItemID,( ItemName + ' ( ' +isnull((Select UnitType from tblUnitType U Where U.UnitTypeID=I.UnitTypeID),'N\A')  + ' ) ' ) as 'ItemName'
	from tblInventoryItems I Where IsActive=1 
	And I.ItemID in (Select Distinct ItemID from tblRequisition Where  IsApproved=0 And IsRejected=0 And IsDeptApproved=1)
	Order by ItemName
end

-- exec spGetReqRemItemList

-- exec spGetItemList

GO

-- drop proc spGetItemListDetails
alter proc spGetItemListDetails
as
begin
	Select ItemID,ItemName,ItemCode,UnitTypeID,
	(Select UnitType from tblUnitType U Where U.UnitTypeID=I.UnitTypeID) as 'UnitType',
	LowBalanceReport,MaxAllowableRequisition,
	IsActive=Case IsActive When 1 Then 'Active' Else 'InActive' End,
	EntryBy,Convert(nvarchar,EntryDate,106) as 'EntryDate' From tblInventoryItems I
	order by ItemName
end

-- exec spGetItemListDetails

GO

-- drop proc spGetLowBalanceItemList
Create proc spGetLowBalanceItemList
as
begin
	Select ItemID,( ItemName + ' ( ' +isnull((Select UnitType from tblUnitType U Where U.UnitTypeID=I.UnitTypeID),'N\A')  + ' ) ' ) as 'ItemName',
	LowBalanceReport,dbo.fnGetItemBalanceByItem(I.ItemID) as 'Balance'
	From tblInventoryItems I Where I.IsActive=1 And dbo.fnGetItemBalanceByItem(I.ItemID) <= LowBalanceReport
end

-- exec spGetLowBalanceItemList

GO

-- drop proc spInsertInventoryItems
CREATE proc spInsertInventoryItems
@ItemName nvarchar(200),
@ItemCode nvarchar(200),
@UnitTypeID nvarchar(50),
@LowBalanceReport int,
@MaxAllowableRequisition int,
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @ItemID nvarchar(50)
	Declare @CurrentItemID numeric(18,0)
	Declare @ItemIDPrefix as nvarchar(4)

	set @ItemIDPrefix='ITM-'

begin tran
	
	select @CurrentItemID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentItemID'
	
	set @CurrentItemID=isnull(@CurrentItemID,0)+1
	Select @ItemID=dbo.generateID(@ItemIDPrefix,@CurrentItemID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblInventoryItems(ItemID,ItemName,ItemCode,UnitTypeID,LowBalanceReport,MaxAllowableRequisition,IsActive,EntryBy)
	Values(@ItemID,@ItemName,@ItemCode,@UnitTypeID,@LowBalanceReport,@MaxAllowableRequisition,@IsActive,@EntryBy)

	update tblAppSettings set PropertyValue=@CurrentItemID where PropertyName='CurrentItemID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create proc spUpdateInventoryItems
@ItemID nvarchar(50),
@ItemName nvarchar(200),
@ItemCode nvarchar(200),
@UnitTypeID nvarchar(50),
@LowBalanceReport int,
@MaxAllowableRequisition int,
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	
begin tran

	Update tblInventoryItems Set ItemName=@ItemName,ItemCode=@ItemCode,UnitTypeID=@UnitTypeID,
	LowBalanceReport=@LowBalanceReport,MaxAllowableRequisition=@MaxAllowableRequisition,IsActive=@IsActive,
	EntryBy=@EntryBy
	Where ItemID=@ItemID
	
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

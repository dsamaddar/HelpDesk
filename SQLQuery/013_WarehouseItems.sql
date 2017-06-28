

insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentBalTransferID',0)

GO

-- drop table tblBalanceTransferHistory
Create table tblBalanceTransferHistory(
BalTransferID nvarchar(50) primary  key,
SourceRef nvarchar(50),
DestinationRef nvarchar(50),
ItemID nvarchar(50) foreign key references tblInventoryItems(ItemID),
TransferedBalance int,
TransferType nvarchar(50),
TransferedBy nvarchar(50),
TransferedDate datetime default getdate()
); 

GO

-- drop proc spInsertBalTransferHistory
Create proc spInsertBalTransferHistory
@SourceRef nvarchar(50),
@DestinationRef nvarchar(50),
@ItemID nvarchar(50),
@TransferedBalance int,
@TransferType nvarchar(50),
@TransferedBy nvarchar(50)
as
begin
	Declare @BalTransferID nvarchar(50)
	Declare @CurrentBalTransferID numeric(18,0)
	Declare @BalTransferIDPrefix as nvarchar(8)

	set @BalTransferIDPrefix='BAL-TRF-'
begin tran

	select @CurrentBalTransferID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentBalTransferID'
	
	set @CurrentBalTransferID=isnull(@CurrentBalTransferID,0)+1
	Select @BalTransferID=dbo.generateID(@BalTransferIDPrefix,@CurrentBalTransferID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert Into tblBalanceTransferHistory(BalTransferID,SourceRef,DestinationRef,ItemID,TransferedBalance,TransferType,TransferedBy)
	Values(@BalTransferID,@SourceRef,@DestinationRef,@ItemID,@TransferedBalance,@TransferType,@TransferedBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=convert(nvarchar,@CurrentBalTransferID) where PropertyName='CurrentBalTransferID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end


GO

insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentWarehouseItemID',0)

GO

-- drop table tblWarehouseItems
Create table tblWarehouseItems(
WarehouseItemID nvarchar(50) primary key,
InvoiceID nvarchar(50) foreign key references tblInvoices(InvoiceID),
WarehouseID nvarchar(50) foreign key references tblWarehouse(WarehouseID),
ItemID nvarchar(50)  foreign key references tblInventoryItems(ItemID),
ItemBalance int,
AdjustedBalance int default 0,
IsAdjusted bit default 0,
AdjustmentDate datetime,
TransferType nvarchar(50),
TransferedRef nvarchar(50),
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO

-- drop proc spGetWarehouseItemBalance
Create proc spGetWarehouseItemBalance
@WarehouseID nvarchar(50) 
as
begin
	Select ItemID,(Select ItemName from tblInventoryItems I Where I.ItemID=WI.ItemID) as 'ItemName',
	Sum(ItemBalance-AdjustedBalance) as 'Balance'
	from  tblWarehouseItems WI Where WarehouseID=@WarehouseID
	group by ItemID 
end

-- Select * from tblWarehouseItems
-- exec spGetWarehouseItemBalance 'WH-00000002'

GO

-- drop proc spGetWarehouseItemBalByItem
Create proc spGetWarehouseItemBalByItem
@WarehouseID nvarchar(50),
@ItemID nvarchar(50)
as
begin
	Select Sum(ItemBalance-AdjustedBalance) as 'Balance'
	from  tblWarehouseItems WI Where WarehouseID=@WarehouseID And ItemID=@ItemID
	group by ItemID 
end

-- exec spGetWarehouseItemBalByItem 'WH-00000002','ITM-00000004'

GO

-- drop proc spInsertWarehouseItems
Create proc spInsertWarehouseItems
@InvoiceID nvarchar(50),
@WarehouseID nvarchar(50),
@ItemID nvarchar(50),
@ItemBalance int,
@TransferType nvarchar(50),
@TransferedRef nvarchar(50),
@EntryBy nvarchar(50)
as
begin
	Declare @WarehouseItemID nvarchar(50)
	Declare @CurrentWarehouseItemID numeric(18,0)
	Declare @WarehouseItemIDPrefix as nvarchar(7)

	set @WarehouseItemIDPrefix='WH-ITM-'
begin tran

	select @CurrentWarehouseItemID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentWarehouseItemID'
	
	set @CurrentWarehouseItemID=isnull(@CurrentWarehouseItemID,0)+1
	Select @WarehouseItemID=dbo.generateID(@WarehouseItemIDPrefix,@CurrentWarehouseItemID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert Into tblWarehouseItems(WarehouseItemID,InvoiceID,WarehouseID,ItemID,ItemBalance,TransferType,TransferedRef,EntryBy)
	Values(@WarehouseItemID,@InvoiceID,@WarehouseID,@ItemID,@ItemBalance,@TransferType,@TransferedRef,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	exec spInsertBalTransferHistory @InvoiceID,@WarehouseID,@ItemID,@ItemBalance,'Procurement',@EntryBy
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=convert(nvarchar,@CurrentWarehouseItemID) where PropertyName='CurrentWarehouseItemID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

Go

--drop proc spInsertMultipleWareHItems
Create proc spInsertMultipleWareHItems
@InvoiceID nvarchar(50),
@WarehouseItemList nvarchar(4000),
@EntryBy nvarchar(50)
as
begin

	Declare @Index as int
	Declare @CurrentData as nvarchar(4000)
	Declare @RestData as nvarchar(4000)
	Declare @RestPortion as nvarchar(4000)

	Declare @WarehouseID as nvarchar(50)
	Declare @ItemID as nvarchar(50)
	Declare @ItemBalance as int

begin tran

	set @RestData=@WarehouseItemList
	while @RestData<>''
	begin
		set @Index=CHARINDEX('|',@RestData)
		set @CurrentData=substring(@RestData,1,@Index-1)
		set @RestData=substring(@RestData,@Index+1,len(@RestData))		
		
		set @RestPortion=@CurrentData
		
		set @Index=CHARINDEX('~',@RestPortion)		
		set @WarehouseID=substring(@RestPortion,1,@Index-1)
		set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	
		
		set @Index=CHARINDEX('~',@RestPortion)		
		set @ItemID=substring(@RestPortion,1,@Index-1)
		set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))
		
		set @Index=CHARINDEX('~',@RestPortion)		
		set @ItemBalance=convert(int,substring(@RestPortion,1,@Index-1))
		set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	

		exec spInsertWarehouseItems @InvoiceID,@WarehouseID,@ItemID,@ItemBalance,'Invoice',@InvoiceID,@EntryBy
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		exec spInsertBalTransferHistory @InvoiceID,@WarehouseID,@ItemID,@ItemBalance,'Invoice',@EntryBy
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		Set @WarehouseID=''
		Set @ItemID = ''
		Set @ItemBalance = 0
						
	end

	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO
-- drop proc spGetItemBalanceByItem
Create proc spGetItemBalanceByItem
@ItemID nvarchar(50)
as
begin
	Select isnull(sum(ItemBalance-AdjustedBalance),0) as 'Balance' from tblWarehouseItems  
	Where ItemID=@ItemID And IsAdjusted=0
end

-- exec spGetItemBalanceByItem 'ITM-00000004'

GO

-- drop function fnGetItemBalanceByItem
Create function fnGetItemBalanceByItem(@ItemID nvarchar(50))
returns int
as
begin
	Declare @Balance as int
	Set @Balance = 0

	Select @Balance = isnull(sum(ItemBalance-AdjustedBalance),0) from tblWarehouseItems  
	Where ItemID=@ItemID And IsAdjusted=0

	return @Balance
end



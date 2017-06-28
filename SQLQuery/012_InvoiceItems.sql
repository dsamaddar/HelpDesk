

insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentInvoiceItemID',0)

GO

-- drop table tblInvoiceItems
Create table tblInvoiceItems(
InvoiceItemID nvarchar(50) primary key,
InvoiceID nvarchar(50) foreign key references tblInvoices(InvoiceID),
ItemID nvarchar(50) foreign key references tblInventoryItems(ItemID),
Quantity int,
UnitPrice numeric(18,2),
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO

-- drop proc spInsertInvoiceItems
Create proc spInsertInvoiceItems
@InvoiceID nvarchar(50),
@ItemID nvarchar(50),
@Quantity int,
@UnitPrice numeric(18,2),
@EntryBy nvarchar(50)
as
begin
	Declare @InvoiceItemID nvarchar(50)
	Declare @CurrentInvoiceItemID numeric(18,0)
	Declare @InvoiceItemIDPrefix as nvarchar(8)

	set @InvoiceItemIDPrefix='INV-ITM-'
begin tran

	select @CurrentInvoiceItemID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentInvoiceItemID'
	
	set @CurrentInvoiceItemID=isnull(@CurrentInvoiceItemID,0)+1
	Select @InvoiceItemID=dbo.generateID(@InvoiceItemIDPrefix,@CurrentInvoiceItemID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
	--PRint Convert(nvarchar, @CurrentInvoiceItemID)
	Insert Into tblInvoiceItems(InvoiceItemID,InvoiceID,ItemID,Quantity,UnitPrice,EntryBy)
	Values(@InvoiceItemID,@InvoiceID,@ItemID,@Quantity,@UnitPrice,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=convert(nvarchar,@CurrentInvoiceItemID) where PropertyName='CurrentInvoiceItemID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

-- exec spInsertMultipleInvoiceItems 'INV-00000001','ITM-00000004~10~400.00~|ITM-00000002~10~100.00~|','admin'

-- drop proc spInsertMultipleInvoiceItems
Create proc spInsertMultipleInvoiceItems
@InvoiceID nvarchar(50),
@InvoiceItemList nvarchar(4000),
@EntryBy nvarchar(50)
as
begin

	Declare @Index as int
	Declare @CurrentData as nvarchar(4000)
	Declare @RestData as nvarchar(4000)
	Declare @RestPortion as nvarchar(4000)

	Declare	@ItemID as nvarchar(50)
	Declare @Quantity as int
	Declare @UnitPrice as numeric(18,2)

begin tran

	set @RestData=@InvoiceItemList
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
		set @UnitPrice=convert(numeric(18,2),substring(@RestPortion,1,@Index-1))
		set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	

		--Print @ItemID+'-'+convert(nvarchar,@Quantity)+'-' + convert(nvarchar,@UnitPrice)
		exec spInsertInvoiceItems @InvoiceID,@ItemID,@Quantity,@UnitPrice,@EntryBy
		IF (@@ERROR <> 0) GOTO ERR_HANDLER
		
		Set @ItemID=''
		Set @Quantity = 0
		Set @UnitPrice= 0
						
	end

	Update tblInvoices Set IsSubmitted=1, SubmittedBy=@EntryBy, SubmissionDate=getdate()
	Where @InvoiceID=@InvoiceID
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create proc spGetItemsByInvoiceAtApp
@InvoiceID nvarchar(50)
as
begin
	Select INV.ItemID,(Select ItemName from tblInventoryItems I Where I.ItemID=INV.ItemID) as 'ItemName',
	INV.Quantity,INV.UnitPrice,(INV.Quantity*INV.UnitPrice) as 'TotalPrice'
	from tblInvoiceItems INV Left Join tblInvoices IV On INV.InvoiceID=IV.InvoiceID
	Where INV.InvoiceID = @InvoiceID And IV.IsSubmitted=1 And IV.IsApproved=0 And IV.IsRejected=0
	Order by ItemName
end

GO

-- exec spGetItemsByInvoiceAtApp 'INV-00000001'

-- drop proc spGetItemsByInvoice
Create proc spGetItemsByInvoice
@InvoiceID nvarchar(50)
as
begin
	Select INV.ItemID,(Select ItemName from tblInventoryItems I Where I.ItemID=INV.ItemID) as 'ItemName'
	from tblInvoiceItems INV 
	Where INV.InvoiceID = @InvoiceID
	Order by ItemName
end

-- exec spGetItemsByInvoice 'INV-00000001'

GO

Create proc spGetItemInvoiceQuantity
@InvoiceID nvarchar(50),
@ItemID nvarchar(50)
as
begin
	Select Quantity from tblInvoiceItems Where InvoiceID = @InvoiceID And ItemID=@ItemID
end

GO


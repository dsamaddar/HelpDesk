
-- drop proc spWareToWareBalTransferList
Create proc spWareToWareBalTransferList
@WareToWareBalTransList nvarchar(4000),
@EntryBy nvarchar(50)
as
begin

	Declare @Index as int
	Declare @CurrentData as nvarchar(4000)
	Declare @RestData as nvarchar(4000)
	Declare @RestPortion as nvarchar(4000)

	Declare @SourceWarehouseID as nvarchar(50)
	Declare @DestWarehouseID as nvarchar(50)
	Declare @ItemID as nvarchar(50)
	Declare @TransferQuantity as int

begin tran
	
	set @RestData=@WareToWareBalTransList
	while @RestData<>''
	begin
		set @Index=CHARINDEX('|',@RestData)
		set @CurrentData=substring(@RestData,1,@Index-1)
		set @RestData=substring(@RestData,@Index+1,len(@RestData))		
		
		set @RestPortion=@CurrentData
		
		set @Index=CHARINDEX('~',@RestPortion)		
		set @SourceWarehouseID=substring(@RestPortion,1,@Index-1)
		set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	
		
		set @Index=CHARINDEX('~',@RestPortion)		
		set @DestWarehouseID=substring(@RestPortion,1,@Index-1)
		set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))
		
		set @Index=CHARINDEX('~',@RestPortion)		
		set @ItemID=substring(@RestPortion,1,@Index-1)
		set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	
		
		set @Index=CHARINDEX('~',@RestPortion)		
		set @TransferQuantity=Convert(int,substring(@RestPortion,1,@Index-1))
		set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	
		
		exec spWToWBalTrans @SourceWarehouseID,@DestWarehouseID,@ItemID,@TransferQuantity,@EntryBy
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		Set @SourceWarehouseID = ''
		Set @DestWarehouseID = ''
		Set @ItemID=''
		Set @TransferQuantity=0
	end
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

-- drop proc spWToWBalTrans
Create proc spWToWBalTrans
@SourceWarehouseID nvarchar(50),
@DestWarehouseID nvarchar(50),
@ItemID nvarchar(50),
@TransferQuantity int,
@EntryBy nvarchar(50)
as
begin

	Declare @WarehItemtbl table(
	WarehouseItemID nvarchar(50),
	InvoiceID nvarchar(50),
	ItmBalRemaining int,
	IsTaken bit default 0
	);

	Declare @WarehouseItemID as nvarchar(50)
	Declare @ItmBalRemaining as int
	Declare @InvoiceID as nvarchar(50)
	Set @ItmBalRemaining = 0

begin tran

	Insert Into @WarehItemtbl(WarehouseItemID,InvoiceID,ItmBalRemaining)
	Select WarehouseItemID,InvoiceID,(ItemBalance-AdjustedBalance) from tblWarehouseItems 
	Where WarehouseID=@SourceWarehouseID And ItemID=@ItemID And IsAdjusted=0
	Order By (2) desc
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Declare @SumOfItemQuantity as int
	Set @SumOfItemQuantity = 0

	Select @SumOfItemQuantity = sum(ItmBalRemaining) from @WarehItemtbl

	if @SumOfItemQuantity >= @TransferQuantity
	begin
		While @TransferQuantity > 0 
		begin
			Select top 1 @WarehouseItemID=WarehouseItemID,@InvoiceID=InvoiceID,@ItmBalRemaining=ItmBalRemaining from @WarehItemtbl
			Where IsTaken=0
	
			If @ItmBalRemaining >= @TransferQuantity
			begin
				Update tblWarehouseItems Set AdjustedBalance= isnull(AdjustedBalance,0) + isnull(@TransferQuantity,0)
				Where  WarehouseItemID=@WarehouseItemID
	
				-- Inserting Warehouse Items
				Exec spInsertWarehouseItems @InvoiceID,@DestWarehouseID,@ItemID,@TransferQuantity,'WareToWare',@SourceWarehouseID,@EntryBy
				IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
				-- Maintain Balance Transfer History
				exec spInsertBalTransferHistory @InvoiceID,@DestWarehouseID,@ItemID,@TransferQuantity,'WareToWare',@EntryBy
				IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
				Set @TransferQuantity = 0
			end
			Else
			begin
				Update tblWarehouseItems Set AdjustedBalance= isnull(AdjustedBalance,0) + isnull(@ItmBalRemaining,0),
				IsAdjusted=1, AdjustmentDate=getdate()
				Where  WarehouseItemID=@WarehouseItemID
	
				-- Inserting Warehouse Items
				Exec spInsertWarehouseItems @InvoiceID,@DestWarehouseID,@ItemID,@ItmBalRemaining,'WareToWare',@SourceWarehouseID,@EntryBy
				IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
				-- Maintain Balance Transfer History
				exec spInsertBalTransferHistory @InvoiceID,@DestWarehouseID,@ItemID,@ItmBalRemaining,'WareToWare',@EntryBy
				IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
				Set @TransferQuantity = @TransferQuantity - @ItmBalRemaining
			end
	
			Update @WarehItemtbl Set IsTaken=1
			Where WarehouseItemID = @WarehouseItemID
		end 
	end

	
	
COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

-- exec spWToWBalTrans 'WH-00000002','','ITM-00000004','dsamaddar'

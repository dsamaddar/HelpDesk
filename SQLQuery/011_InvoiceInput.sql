

insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentInvoiceID',0)

GO

-- drop table tblInvoices
Create table tblInvoices(
InvoiceID nvarchar(50) primary key,
InvoiceNo nvarchar(200) unique(InvoiceNo),
SupplierID nvarchar(50) foreign key references tblSupplier(SupplierID),
InvoiceDate datetime,
InvoiceCost numeric(18,2),
IsSubmitted bit default 0,
SubmittedBy nvarchar(50),
SubmissionDate datetime,
ApproverID nvarchar(50) foreign key references tblUsers(UniqueUserID),
IsApproved bit default 0,
ApprovedBy nvarchar(50),
ApprovalDate datetime,
IsRejected bit default 0,
RejectedBy nvarchar(50),
RejectionDate datetime,
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

-- Select * from tblInvoices

GO

-- drop proc spInsertInvoice
Create proc spInsertInvoice
@InvoiceNo nvarchar(200),
@SupplierID nvarchar(50),
@InvoiceDate datetime,
@InvoiceCost numeric(18,2),
@ApproverID nvarchar(50),
@EntryBy nvarchar(50)
as
begin
	Declare @InvoiceID nvarchar(50)
	Declare @CurrentInvoiceID numeric(18,0)
	Declare @InvoiceIDPrefix as nvarchar(4)

	set @InvoiceIDPrefix='INV-'

	if @ApproverID='N\A'
	begin
		Set @ApproverID = null
	end
begin tran

	select @CurrentInvoiceID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentInvoiceID'
	
	set @CurrentInvoiceID=isnull(@CurrentInvoiceID,0)+1
	Select @InvoiceID=dbo.generateID(@InvoiceIDPrefix,@CurrentInvoiceID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert Into tblInvoices(InvoiceID,InvoiceNo,SupplierID,InvoiceDate,InvoiceCost,ApproverID,EntryBy)
	Values(@InvoiceID,@InvoiceNo,@SupplierID,@InvoiceDate,@InvoiceCost,@ApproverID,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentInvoiceID where PropertyName='CurrentInvoiceID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

-- drop proc spGetDetailsInvoiceList
Create proc spGetDetailsInvoiceList
as
begin
	Select I.InvoiceID,I.InvoiceNo,I.SupplierID,
	(Select SupplierName from tblSupplier S Where S.SupplierID=I.SupplierID) as 'SupplierName',
	Convert(nvarchar,I.InvoiceDate,106) as 'InvoiceDate',I.InvoiceCost
	from tblInvoices I Where IsSubmitted=0
end

GO

-- drop proc spGetDetailsInvLstToApprove
Create proc spGetDetailsInvLstToApprove
@ApproverID nvarchar(50)
as
begin
	Select I.InvoiceID,I.InvoiceNo,I.SupplierID,
	(Select SupplierName from tblSupplier S Where S.SupplierID=I.SupplierID) as 'SupplierName',
	Convert(nvarchar,I.InvoiceDate,106) as 'InvoiceDate',I.InvoiceCost,SubmittedBy,Convert(nvarchar,SubmissionDate,106) as 'SubmissionDate'
	from tblInvoices I Where IsSubmitted=1 And IsApproved=0 And IsRejected=0
	And (I.ApproverID=@ApproverID or I.ApproverID is null )
end

GO

-- drop proc spApproveInvoice
Create proc spApproveInvoice
@InvoiceID nvarchar(50),
@ApprovedBy nvarchar(50)
as
begin
	Update tblInvoices Set IsApproved=1, ApprovedBy=@ApprovedBy,ApprovalDate = getdate()
	Where InvoiceID=@InvoiceID
end

GO

Create proc spRejectInvoice
@InvoiceID nvarchar(50),
@RejectedBy nvarchar(50)
as
begin
	Update tblInvoices Set IsRejected=1, RejectedBy=@RejectedBy,RejectionDate = getdate()
	Where InvoiceID=@InvoiceID
end

Go

-- drop proc spGetApprovedInvoiceUnAllocated
Create proc spGetApprovedInvoiceUnAllocated
as
begin
	Select I.InvoiceID,I.InvoiceNo,I.SupplierID,
	(Select SupplierName from tblSupplier S Where S.SupplierID=I.SupplierID) as 'SupplierName',
	Convert(nvarchar,I.InvoiceDate,106) as 'InvoiceDate',I.InvoiceCost,SubmittedBy,Convert(nvarchar,SubmissionDate,106) as 'SubmissionDate'
	from tblInvoices I Where IsApproved=1
	And I.InvoiceID not In (Select Distinct InvoiceID from tblWarehouseItems)
end

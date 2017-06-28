
GO

insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentSupplierID',0)

GO

Create table tblSupplier(
SupplierID nvarchar(50) primary key,
SupplierName nvarchar(200) unique(SupplierName),
Address nvarchar(1000),
ContactPerson nvarchar(500),
ContactNumber nvarchar(50),
AboutSupplier nvarchar(1000),
Company_Phone_Mobile nvarchar(200),
Fax nvarchar(200),
Email nvarchar(200),
IsBlackListed bit default 0,
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO

Create proc spGetSupplier
as
begin
	Select Distinct SupplierID,SupplierName from tblSupplier Where IsBlackListed=0
	Order by SupplierName
end

-- exec spGetSupplier

GO

-- drop proc spGetSupplierDetails
Create proc spGetSupplierDetails
as
begin
	Select SupplierID,SupplierName,Address,ContactPerson,ContactNumber,AboutSupplier,
	isnull(Company_Phone_Mobile,'') as 'CompanyContactNumber',isnull(Fax,'') as 'Fax',isnull(Email,'') as 'Email',
	IsBlackListed = Case IsBlackListed When 1 Then 'YES' Else 'NO' End,
	EntryBy,Convert(nvarchar,EntryDate,106) as 'EntryDate'
	From tblSupplier order by SupplierName
end

-- exec spGetSupplierDetails

GO

-- drop proc spInsertSupplier
CREATE proc spInsertSupplier
@SupplierName nvarchar(200),
@Address nvarchar(1000),
@ContactPerson nvarchar(500),
@ContactNumber nvarchar(50),
@AboutSupplier nvarchar(1000),
@Company_Phone_Mobile nvarchar(200),
@Fax nvarchar(200),
@Email nvarchar(200),
@IsBlackListed bit,
@EntryBy nvarchar(50)
as
begin
	Declare @SupplierID nvarchar(50)
	Declare @CurrentSupplierID numeric(18,0)
	Declare @SupplierIDPrefix as nvarchar(4)

	set @SupplierIDPrefix='SUP-'

begin tran
	
	select @CurrentSupplierID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentSupplierID'
	
	set @CurrentSupplierID=isnull(@CurrentSupplierID,0)+1
	Select @SupplierID=dbo.generateID(@SupplierIDPrefix,@CurrentSupplierID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert Into tblSupplier(SupplierID,SupplierName,Address,ContactPerson,ContactNumber,AboutSupplier,Company_Phone_Mobile,Fax,Email,IsBlackListed,EntryBy)
	Values(@SupplierID,@SupplierName,@Address,@ContactPerson,@ContactNumber,@AboutSupplier,@Company_Phone_Mobile,@Fax,@Email,@IsBlackListed,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentSupplierID where PropertyName='CurrentSupplierID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

-- drop proc spUpdateSupplier
CREATE proc spUpdateSupplier
@SupplierID nvarchar(50),
@SupplierName nvarchar(200),
@Address nvarchar(1000),
@ContactPerson nvarchar(500),
@ContactNumber nvarchar(50),
@AboutSupplier nvarchar(1000),
@Company_Phone_Mobile nvarchar(200),
@Fax nvarchar(200),
@Email nvarchar(200),
@IsBlackListed bit,
@EntryBy nvarchar(50)
as
begin
	
begin tran
	
	Update tblSupplier Set SupplierName=@SupplierName,Address=@Address,ContactPerson=@ContactPerson,
	ContactNumber=@ContactNumber,AboutSupplier=@AboutSupplier,Company_Phone_Mobile=@Company_Phone_Mobile,
	Fax=@Fax,Email=@Email,IsBlackListed=@IsBlackListed,EntryBy=@EntryBy
	Where SupplierID=@SupplierID
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

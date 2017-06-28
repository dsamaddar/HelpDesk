
GO

Alter table tblBranchInfo
ADD HOBranch nvarchar(50) foreign key references tblUsers(UniqueUserID)

GO

Alter table tblBranchInfo
Add BranchMailAddress nvarchar(200)

-- Select * from tblBranchInfo

GO

Create proc spGetBranchList
as
begin
	Select Distinct BranchID,BranchName from tblBranchInfo Where IsActive=1
	Order by BranchName
end

-- exec spGetBranchList 

GO

-- drop proc spGetDetailsBranchList
Create proc spGetDetailsBranchList
as
begin
	Select BranchID,BranchName,BranchCode,isnull(HOBranch,'N\A') as 'HOBranch',
	isnull((Select UserName from tblUsers Where UniqueUserID = HOBranch),'N\A') as 'HOBr',
	Address,ContactNumber,BranchMailAddress,
	IsActive=Case IsActive When 1 Then 'Active' Else 'InActive' End,
	EntryBy,Convert(nvarchar,EntryDate,106) as 'EntryDate'
	From tblBranchInfo Order by BranchName
End

-- exec spGetDetailsBranchList

GO

-- drop proc spInsertBranchInfo
CREATE proc spInsertBranchInfo
@BranchName nvarchar(200),
@BranchCode nvarchar(50),
@HOBranch nvarchar(50),
@Address nvarchar(500),
@ContactNumber nvarchar(200),
@BranchMailAddress nvarchar(200),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @BranchID nvarchar(50)
	Declare @CurrentBranchID numeric(18,0)
	Declare @BranchIDPrefix as nvarchar(3)

	set @BranchIDPrefix='BR-'

begin tran

	if @HOBranch='N\A'
	begin
		Set @HOBranch= null
	end
	
	select @CurrentBranchID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentBranchID'
	
	set @CurrentBranchID=isnull(@CurrentBranchID,0)+1
	Select @BranchID=dbo.generateID(@BranchIDPrefix,@CurrentBranchID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert Into tblBranchInfo(BranchID,BranchName,BranchCode,Address,ContactNumber,BranchMailAddress,IsActive,EntryBy)
	Values(@BranchID,@BranchName,@BranchCode,@Address,@ContactNumber,@BranchMailAddress,@IsActive,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentBranchID where PropertyName='CurrentBranchID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

-- drop proc spUpdateBranchInfo
CREATE proc spUpdateBranchInfo
@BranchID nvarchar(50),
@BranchName nvarchar(200),
@BranchCode nvarchar(50),
@HOBranch nvarchar(50),
@Address nvarchar(500),
@ContactNumber nvarchar(200),
@BranchMailAddress nvarchar(200),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin

begin tran

	if @HOBranch='N\A'
	begin
		Set @HOBranch= null
	end
	
	Update tblBranchInfo Set BranchName=@BranchName,BranchCode=@BranchCode,HOBranch=@HOBranch,
	Address=@Address,ContactNumber=@ContactNumber,BranchMailAddress=@BranchMailAddress,IsActive=@IsActive
	Where BranchID=@BranchID

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

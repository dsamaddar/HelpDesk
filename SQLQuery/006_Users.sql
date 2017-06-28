
GO

insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentBranchID',0)

GO

-- drop table tblBranchInfo
Create table tblBranchInfo(
BranchID nvarchar(50) primary key,
BranchName nvarchar(200) unique(BranchName),
BranchCode nvarchar(50) unique(BranchCode),
Address nvarchar(500),
ContactNumber nvarchar(200),
IsActive bit default 1,
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO

insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentDepartmentID',0)

GO

-- drop table tblDepartment
Create table tblDepartment(
DepartmentID nvarchar(50) primary key,
DepartmentName nvarchar(200) Unique(DepartmentName),
IsActive bit default 1,
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO


insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentUniqueUserID',0)

GO

-- drop table tblUsers
Create table tblUsers(
UniqueUserID nvarchar(50) primary key,
UserName nvarchar(200),
UserID nvarchar(50) unique(UserID),
UserPassword nvarchar(50),
DateOfBirth datetime,
Email nvarchar(50),
UserType nvarchar(50),
Gender nvarchar(50),
ContactNumber nvarchar(50),
SupervisorID nvarchar(50) foreign key references tblUsers(UniqueUserID),
DepartmentID nvarchar(50) foreign key references tblDepartment(DepartmentID),
BranchID nvarchar(50) foreign key references tblBranchInfo(BranchID),
IsActive bit default 1,
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO

-- drop proc spShowUserList
Create proc spShowUserList
as
begin
	Select UniqueUserID,UserName from tblUsers Where IsActive=1
	Order By UserName
end

GO

-- drop proc spShowDetailsUsersList
Create proc spShowDetailsUsersList
as
begin 
	Select U.UniqueUserID,U.UserName,U.UserID,U.UserPassword,Convert(nvarchar,U.DateOfBirth,106) as 'DateOfBirth',U.Email,U.UserType,U.Gender,U.ContactNumber,
	Isnull(U.SupervisorID,'N\A') as 'SupervisorID',
	isnull((Select UserName from tblUsers SU Where SU.UniqueUserID=U.SupervisorID),'N\A') as 'Supervisor',
	isnull(U.DepartmentID,'N\A') as 'DepartmentID',
	isnull((Select DepartmentName from tblDepartment D Where D.DepartmentID= U.DepartmentID),'N\A') as 'Department',
	isnull(U.BranchID,'N\A') as 'BranchID',
	isnull((Select BranchName from tblBranchInfo B Where B.BranchID = U.BranchID),'N\A') as 'Branch',
	IsActive=CASE U.IsActive When 1 Then 'Active' Else 'InActive' End,
	EntryBy,Convert(nvarchar,EntryDate,106) as 'EntryDate'
	From tblUsers U
end

-- exec spShowDetailsUsersList

GO

-- drop proc spInsertUsers
CREATE proc spInsertUsers
@UserName nvarchar(200),
@UserID nvarchar(50),
@UserPassword nvarchar(50),
@DateOfBirth datetime,
@Email nvarchar(50),
@UserType nvarchar(50),
@Gender nvarchar(50),
@ContactNumber nvarchar(50),
@SupervisorID nvarchar(50),
@DepartmentID nvarchar(50),
@BranchID nvarchar(50),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @UniqueUserID nvarchar(50)
	Declare @CurrentUniqueUserID numeric(18,0)
	Declare @UniqueUserIDPrefix as nvarchar(4)

	set @UniqueUserIDPrefix='USR-'

	if @SupervisorID = 'N\A'
	begin
		Set @SupervisorID = null
	end

	if @DepartmentID = 'N\A'
	begin
		Set @DepartmentID = null
	end

	if @BranchID='N\A'
	begin
		Set @BranchID = null
	end

begin tran
	
	select @CurrentUniqueUserID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentUniqueUserID'
	
	set @CurrentUniqueUserID=isnull(@CurrentUniqueUserID,0)+1
	Select @UniqueUserID=dbo.generateID(@UniqueUserIDPrefix,@CurrentUniqueUserID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert Into tblUsers(UniqueUserID,UserName,UserID,UserPassword,DateOfBirth,Email,UserType,Gender,ContactNumber,SupervisorID,
	DepartmentID,BranchID,IsActive,EntryBy)
	Values(@UniqueUserID,@UserName,@UserID,@UserPassword,@DateOfBirth,@Email,@UserType,@Gender,@ContactNumber,@SupervisorID,
	@DepartmentID,@BranchID,@IsActive,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentUniqueUserID where PropertyName='CurrentUniqueUserID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

-- drop proc spUpdateUsers
CREATE proc spUpdateUsers
@UniqueUserID nvarchar(50),
@UserName nvarchar(200),
@UserID nvarchar(50),
@UserPassword nvarchar(50),
@DateOfBirth datetime,
@Email nvarchar(50),
@UserType nvarchar(50),
@Gender nvarchar(50),
@ContactNumber nvarchar(50),
@SupervisorID nvarchar(50),
@DepartmentID nvarchar(50),
@BranchID nvarchar(50),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	if @SupervisorID = 'N\A'
	begin
		Set @SupervisorID = null
	end

	if @DepartmentID = 'N\A'
	begin
		Set @DepartmentID = null
	end

	if @BranchID='N\A'
	begin
		Set @BranchID = null
	end
begin tran
	
	Update tblUsers Set UserName=@UserName,UserID=@UserID,UserPassword=@UserPassword,DateOfBirth=@DateOfBirth,
	Email=@Email,UserType=@UserType,ContactNumber=@ContactNumber,SupervisorID=@SupervisorID,DepartmentID=@DepartmentID,
	BranchID=@BranchID,IsActive=@IsActive,EntryBy=@EntryBy
	Where UniqueUserID=@UniqueUserID
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

-- drop proc spGetReqRemDeptWiseUser
alter proc spGetReqRemDeptWiseUser
@DepartmentID nvarchar(50)
as
begin
	if @DepartmentID='N\A'
	begin
		Set @DepartmentID = null
		Select distinct EmployeeID,EmployeeName + ' ('+EmpCode+')' as 'EmployeeName' from tblEmployeeInfo Where   DepartmentID is null And 
		EmployeeID In (Select distinct EmployeeID from tblRequisition Where IsApproved=0) 
	end
	else
	begin
		Select distinct EmployeeID,EmployeeName + ' ('+EmpCode+')' as 'EmployeeName' from tblEmployeeInfo Where   DepartmentID=@DepartmentID 
		And EmployeeID In (Select distinct EmployeeID from tblRequisition Where IsApproved=0) 
	end
end

-- exec spGetReqRemDeptWiseUser 'DEPT-00000001'
-- exec spGetReqRemDeptWiseUser 'N\A'

GO

-- drop proc spAuthenticateUser
Create proc spAuthenticateUser
@UserID nvarchar(50),
@UserPassword nvarchar(50)
as
begin
	Select isnull(UniqueUserID,'N\A') as 'UniqueUserID',Isnull(UserName,'N\A') as 'UserName',isnull(UserID,'N\A') as 'UserID',
	isnull(dbo.fnGetUserPermission(UniqueUserID),'') as 'PermittedMenus'
	from tblUsers Where UserID=@UserID And UserPassword=@UserPassword
end

-- exec spAuthenticateUser 'msrana','standard'

GO

-- drop proc spValidateOldPassword
Create proc spValidateOldPassword
@UniqueUserID nvarchar(50),
@UserPassword nvarchar(50)
as
begin
	if exists(Select * from tblUsers Where UniqueUserID=@UniqueUserID And UserPassword=@UserPassword)
		Select 1 as 'IsValid'
	else
		select 0 as 'IsValid'
end

-- exec spValidateOldPassword 'USR-00000001','stndard'

GO

-- drop proc spChangePassword
Create proc spChangePassword
@UniqueUserID nvarchar(50),
@ChangedPassword nvarchar(50)
as
begin
	Update tblUsers Set UserPassword=@ChangedPassword Where UniqueUserID=@UniqueUserID
end
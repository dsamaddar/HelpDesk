
GO

Alter table tblDepartment
ADD HODID nvarchar(50) foreign key references tblUsers(UniqueUserID);

GO

Alter table tblDepartment
ADD ShortCode nvarchar(50) unique(ShortCode);

GO

Alter table tblDepartment
ADD DeptMailAddress nvarchar(50);

-- Select * from tblDepartment

GO

-- drop proc spGetReqRemDepartmentList
alter proc spGetReqRemDepartmentList
as
begin
	Select Distinct DepartmentID,DeptName from tblDepartment Where IsActive=1
	And DepartmentID In ( Select DepartmentID from tblEmployeeInfo Where EmployeeID in 
	(Select EmployeeID from tblRequisition Where IsApproved=0 And IsRejected=0 And IsDeptApproved=1) )
	Order by DeptName
end

-- exec spGetReqRemDepartmentList

GO

Create proc spGetDepartmentList
as
begin
	Select Distinct DepartmentID,DepartmentName from tblDepartment Where IsActive=1
	Order by DepartmentName
end

-- exec spGetDepartmentList

GO

-- drop proc spGetDetailsDepartmentList
Create proc spGetDetailsDepartmentList
as
begin
	Select Distinct DepartmentID,DepartmentName,DeptCode,isnull(HODID,'N\A') as 'HODID',
	isnull((Select UserName from tblUsers Where UniqueUserID=HODID),'N\A') as 'HOD',
	DeptMailAddress,
	IsActive=Case IsActive When 1 Then 'Active' Else 'InActive' End,
	EntryBy,Convert(nvarchar,EntryDate,106) as 'EntryDate' from tblDepartment Where IsActive=1
	Order by DepartmentName
end

GO

-- drop proc spInsertDepartment
CREATE proc spInsertDepartment
@DepartmentName nvarchar(200),
@DeptCode nvarchar(50),
@HODID nvarchar(50),
@DeptMailAddress nvarchar(50),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @DepartmentID nvarchar(50)
	Declare @CurrentDepartmentID numeric(18,0)
	Declare @DepartmentIDPrefix as nvarchar(5)

	set @DepartmentIDPrefix='DEPT-'

begin tran

	if @HODID='N\A'
	begin
		Set @HODID= null
	end
	
	select @CurrentDepartmentID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentDepartmentID'
	
	set @CurrentDepartmentID=isnull(@CurrentDepartmentID,0)+1
	Select @DepartmentID=dbo.generateID(@DepartmentIDPrefix,@CurrentDepartmentID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert Into tblDepartment(DepartmentID,DepartmentName,DeptCode,HODID,DeptMailAddress,IsActive,EntryBy)
	Values(@DepartmentID,@DepartmentName,@DeptCode,@HODID,@DeptMailAddress,@IsActive,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentDepartmentID where PropertyName='CurrentDepartmentID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

-- drop proc spUpdateDepartment
Create proc spUpdateDepartment
@DepartmentID nvarchar(50),
@DepartmentName nvarchar(200),
@DeptCode nvarchar(50),
@HODID nvarchar(50),
@DeptMailAddress nvarchar(50),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin

begin tran

	if @HODID='N\A'
	begin
		Set @HODID= null
	end

	Update tblDepartment Set DepartmentName=@DepartmentName,DeptCode=@DeptCode,HODID=@HODID,DeptMailAddress=@DeptMailAddress,
	IsActive=@IsActive,EntryBy=@EntryBy
	Where DepartmentID=@DepartmentID

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end
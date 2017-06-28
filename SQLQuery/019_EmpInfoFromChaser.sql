

GO

Create proc spInsertEmployeeInfo
@UserID nvarchar(50),
@UserPassword nvarchar(50) ,
@UserType nvarchar(50) ,
@EmployeeName nvarchar(200) ,
@EmpCode nvarchar(50),
@DateOfBirth datetime,
@JoiningDate datetime ,
@DesignationID nvarchar(50),
@DepartmentID nvarchar(50),
@ULCBranchID nvarchar(50),
@CurrentSupervisor nvarchar(50),
@EmpStatus nvarchar(50),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @EmployeeID nvarchar(50)
	Declare @CurrentEmployeeID numeric(18,0)
	Declare @EmployeeIDPrefix as nvarchar(4)

	set @EmployeeIDPrefix='EMP-'

begin tran
	
	select @CurrentEmployeeID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentEmployeeID'
	
	set @CurrentEmployeeID=isnull(@CurrentEmployeeID,0)+1
	Select @EmployeeID=dbo.generateID(@EmployeeIDPrefix,@CurrentEmployeeID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblEmployeeInfo(EmployeeID,UserID,UserPassword,UserType,EmployeeName,EmpCode,DateOfBirth,
	JoiningDate,DesignationID,DepartmentID,ULCBranchID,CurrentSupervisor,EmpStatus,IsActive,EntryBy)
	Values(@EmployeeID,@UserID,@UserPassword,@UserType,@EmployeeName,@EmpCode,
	@DateOfBirth,@JoiningDate,@DesignationID,@DepartmentID,@ULCBranchID,@CurrentSupervisor,@EmpStatus,@IsActive,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentEmployeeID where PropertyName='CurrentEmployeeID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create proc spSyncEmpInfo
@EmployeeID nvarchar(50),
@UserID nvarchar(50),
@UserType nvarchar(50),
@EmployeeName nvarchar(200),
@EmpCode nvarchar(50),
@DateOfBirth datetime,
@JoiningDate datetime,
@DesignationID nvarchar(50),
@DepartmentID nvarchar(50),
@ULCBranchID nvarchar(50),
@CurrentSupervisor nvarchar(50),
@EmpStatus nvarchar(50),
@MailAddress nvarchar(50),
@MobileNo nvarchar(50),
@IsActive bit
as
begin
	
	if @DesignationID = 'N\A'
		Set @DesignationID = null

	if @DepartmentID = 'N\A'
		Set  @DepartmentID = null

	if @ULCBranchID = 'N\A'
		Set @ULCBranchID = null

	if @CurrentSupervisor = 'N\A'
		Set @CurrentSupervisor = null

	if @EmployeeID <> 'N\A'
	begin
		Update tblEmployeeInfo Set UserID=@UserID,EmployeeName=@EmployeeName,EmpCode=@EmpCode,
		DateOfBirth=@DateOfBirth,JoiningDate=@JoiningDate,DesignationID=@DesignationID,
		DepartmentID=@DepartmentID,ULCBranchID=@ULCBranchID,CurrentSupervisor=@CurrentSupervisor,
		EmpStatus=@EmpStatus,MailAddress=@MailAddress,MobileNo=@MobileNo,IsActive=@IsActive--,UserType=@UserType
		Where EmployeeID=@EmployeeID
	end
	
end

GO


Create proc spUpdateEmpInfo
@EmployeeID nvarchar(50),
@UserID nvarchar(50),
@UserPassword nvarchar(50) ,
@UserType nvarchar(50) ,
@EmployeeName nvarchar(200) ,
@EmpCode nvarchar(50),
@DateOfBirth datetime,
@JoiningDate datetime ,
@DesignationID nvarchar(50),
@DepartmentID nvarchar(50),
@ULCBranchID nvarchar(50),
@CurrentSupervisor nvarchar(50),
@EmpStatus nvarchar(50),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin

	if @DesignationID = 'N\A'
		Set @DesignationID = null

	if @DepartmentID = 'N\A'
		Set @DepartmentID = null

	if @ULCBranchID = 'N\A'
		Set @ULCBranchID = null

	if @CurrentSupervisor = 'N\A'
		Set @CurrentSupervisor = null
	
	Update tblEmployeeInfo Set UserID=@UserID,UserPassword=@UserPassword,UserType=@UserType,EmployeeName=@EmployeeName,
	EmpCode=@EmpCode,DateOfBirth=@DateOfBirth,JoiningDate=@JoiningDate,DesignationID=@DesignationID,
	DepartmentID=@DepartmentID,ULCBranchID=@ULCBranchID,CurrentSupervisor=@CurrentSupervisor,EmpStatus=@EmpStatus,
	IsActive=@IsActive,EntryBy=@EntryBy
	Where EmployeeID=@EmployeeID

end

GO

Create proc spGetActiveEmpList
as
begin
	Select EmployeeID, upper(EmployeeName)+ ' ('+isnull(EmpCode,'N\A')+')' as 'EmployeeName' from tblEmployeeInfo Where EmpStatus='Active'
	Order by EmployeeName
end

GO

Create proc spGetDeptList
as
begin
	Select distinct DepartmentID,DeptName from tblDepartment Where IsActive=1 order by DeptName 
end

GO


Create proc spGetEmployeeList
as
begin
	SELECT EmployeeID,EmployeeName + ' ( ' + isnull(EmpCode,'N\A') + ' )' as 'EmployeeName'
	FROM tblEmployeeInfo where IsActive =1
	order by EmployeeName
End

GO

Create proc spGetAllEmpDetails
as
begin
	Select EI.EmployeeID,EI.UserID,EI.UserPassword,EI.UserType,EI.EmployeeName,EI.EmpCode,
	Convert(nvarchar,Isnull(EI.DateOfBirth,'1/1/1900'),106) as 'DateOfBirth',Convert(nvarchar,isnull(EI.JoiningDate,'1/1/1900'),106) as 'JoiningDate',
	isnull(DesignationID,'N\A') as 'DesignationID',
	isnull((Select DesignationName from tblDesignation D Where D.DesignationID=EI.DesignationID) ,'N\A')as 'Designation',
	isnull(EI.DepartmentID,'N\A') as 'DepartmentID',
	isnull((Select DeptName from tblDepartment DD Where DD.DepartmentID=EI.DepartmentID),'N\A') as 'Department',
	isnull(EI.ULCBranchID,'N\A') as 'ULCBranchID',
	isnull((Select ULCBranchName from tblULCBranch UB Where UB.ULCBranchID=EI.ULCBranchID),'N\A') as 'Branch',
	isnull(EI.CurrentSupervisor,'N\A') as 'CurrentSupervisor',
	isnull((Select EmployeeName from tblEmployeeInfo E Where E.EmployeeID=EI.CurrentSupervisor),'N\A') as 'Supervisor',
	EmpStatus,isnull(EI.MailAddress,'') as 'MailAddress',isnull(EI.MobileNo,'N\A') as 'MobileNo',
	Case IsActive When 1 Then 'YES' Else 'No' end as 'IsActive'
	,EntryBy,EntryDate
	from tblEmployeeInfo EI Where IsActive=1 And EmpStatus <> 'NoEdit'
	order by EI.EmpCode
end

GO

Create proc spAddNewlyAddedEmp
@EmployeeID nvarchar(50),
@UserID nvarchar(50),
@UserPassword nvarchar(50),
@UserType nvarchar(50),
@EmployeeName nvarchar(200),
@EmpCode nvarchar(50),
@DateOfBirth datetime,
@JoiningDate datetime,
@DesignationID nvarchar(50),
@DepartmentID nvarchar(50),
@ULCBranchID nvarchar(50),
@CurrentSupervisor nvarchar(50),
@EmpStatus nvarchar(50),
@MailAddress nvarchar(50),
@MobileNo nvarchar(50),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin

	if not exists (Select * from tblDesignation Where DesignationID=@DesignationID)
		Set @DesignationID = null

	if not exists(Select * from tblDepartment Where DepartmentID=@DepartmentID)
		Set @DepartmentID = null

	if not exists (Select * from tblULCBranch Where ULCBranchID=@ULCBranchID)
		Set @ULCBranchID = null

	if not exists(Select * from tblEmployeeInfo Where EmployeeID=@CurrentSupervisor)
		Set @CurrentSupervisor = null

	
	Insert into tblEmployeeInfo(EmployeeID,UserID,UserPassword,UserType,EmployeeName,EmpCode,DateOfBirth,
	JoiningDate,DesignationID,DepartmentID,ULCBranchID,CurrentSupervisor,EmpStatus,MailAddress,MobileNo,
	IsActive,EntryBy)
	Values(@EmployeeID,@UserID,@UserPassword,@UserType,@EmployeeName,@EmpCode,@DateOfBirth,
	@JoiningDate,@DesignationID,@DepartmentID,@ULCBranchID,@CurrentSupervisor,@EmpStatus,@MailAddress,@MobileNo,
	@IsActive,@EntryBy)

end

GO

Create proc spGetAllEmpIDList
as
begin
	Declare @EmpIDList as nvarchar(4000) Set @EmpIDList = ''
	Select @EmpIDList = @EmpIDList + RIGHT(EmployeeID,4)+',' from tblEmployeeInfo

	Set @EmpIDList = SUBSTRING( @EmpIDList,0,len(@EmpIDList))

	Select @EmpIDList as 'EmpIDList'
end


GO

Create proc spGetBranchWiseEmpList
@ULCBranchID nvarchar(50)
as
begin
	Select EmployeeID,UPPER(EmployeeName) + ' ('+ isnull(EmpCode,'N\A') +')' as 'EmployeeName' from tblEmployeeInfo Where ULCBranchID=@ULCBranchID
	order by EmployeeName 
end



GO

Create proc spGetEmpDetailsByID
@EmployeeID nvarchar(50)
as
begin
	Select EmployeeName,UserID,EmpCode,EI.MailAddress,EI.MobileNo,
	Isnull((Select DesignationName from tblDesignation D Where D.DesignationID=EI.EmployeeID),'N\A') as 'Designation',
	Isnull((Select DeptName from tblDepartment DE Where DE.DepartmentID=EI.DepartmentID),'N\A') as 'Department',
	Isnull((Select ULCBranchName from tblULCBranch UB Where UB.ULCBranchID=EI.ULCBranchID),'N\A') as 'ULCBranchName',
	Isnull((Select EmployeeName from tblEmployeeInfo E Where E.EmployeeID=EI.CurrentSupervisor),'N\A') as 'Supervisor'
	from tblEmployeeInfo EI Where EmployeeID=@EmployeeID
end
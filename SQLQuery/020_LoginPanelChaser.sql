


Create proc spCheckUserLogin
@UserID nvarchar(50),
@UserPassword nvarchar(50)
as
begin
	Select EmployeeID,UserID,UserType,EmployeeName,isnull(dbo.fnGetUserPermission(EmployeeID),'') as 'PermittedMenus' from tblEmployeeInfo
	Where UserID=@UserID And EmpStatus='Active'
end

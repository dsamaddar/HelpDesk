

create table tblMenu(
MenuID nvarchar(50) primary key,
MenuName nvarchar(200) unique(MenuName),
MenuGroupID nvarchar(50),
ViewOrder int
);

GO

-- Select * from tblMenu


Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('DesigDef','Designation Definition','Admin',0)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('DeptDef','Create/Edit Department','Admin',1)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('SupplierDef','Create/Edit Supplier','Admin',2)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('MngItmUnit','Unit Type Management','Admin',4)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('MngItm','Item Management','Admin',3)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('MngBranch','Branch Management','Admin',4)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('MngWarehouse','Warehouse Management','Admin',5)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('MngUser','Create/Edit User','Admin',6)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('MngRole','Role Management','Admin',7)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('MngPermission','Role Wise Permission','Admin',8)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('UsrWiseRole','User Wise Role Management','Admin',9)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('EmpInfo','Employee Info','Admin',100)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('AddNewlyAddEmp','Add Newly Added Emp.','Admin',101)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('EmpSync','Employee Synchronization','Admin',102)


Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('ItmReq','Item Requisition','Requisition',10)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('ReqHistory','Requisition History','Requisition',11)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('AppReq','Approve Requisition','Requisition',12)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('OnDemandReq','On Demand Requisition','Requisition',13)

Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('GenInv','Generate Invoice','Procurement',20)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('ProcInput','Procurement Input','Procurement',21)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('ProcApproval','Procurement Approval','Procurement',22)

Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('AcptReq','Accept Requisition','AcceptRequisition',40)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('AdvAcptReq','Adv. Accept Requisition','AcceptRequisition',43)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('DelReq','Deliver Requisition','AcceptRequisition',41)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('DeliveredReq','Delivered Requisition','AcceptRequisition',42)

Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('ProcToWare','Procurement To Warehouse','BalanceTransfer',50)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('WareToWare','Warehouse To Warehouse','BalanceTransfer',51)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('WareBal','Warehouse Balance','BalanceTransfer',52)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('ItmBalStat','Item Balance Status','BalanceTransfer',53)

Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('RptProcurement','Procurement Report','Report',60)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('RptRequisition','Requisition Report','Report',61)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('RptlowBal','Low Balance Report','Report',62)


GO

Create proc spGetMenuListByGroup
@MenuGroupID nvarchar(50)
as
begin
	Select MenuID,MenuName from tblMenu
	Where MenuGroupID=@MenuGroupID
	Order by ViewOrder
end

GO

Create proc spGetMenuGroupList
as
begin
	Select Distinct MenuGroupID from tblMenu Order by MenuGroupID
end


GO

insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentRoleID',0)


GO

Create table tblRole(
RoleID nvarchar(50) primary key,
RoleName nvarchar(50),
isActive bit default 1,
MenuIDs nvarchar(4000),
ActivityIDs nvarchar(500),
CreatedBy nvarchar(50),
CreatedDate datetime default getdate(),
LastUpdatedBy nvarchar(50),
LastUpdatedDate datetime
);

-- Select * from tblRole

GO

-- drop proc spGetRoleList
Create proc spGetRoleList
as
begin
	Select Distinct RoleID,RoleName from tblRole Where isActive=1
	Order by RoleName
end

Go

Create proc spGetRoleWiseMenuIDs
@RoleID nvarchar(50)
as
begin
	Select MenuIDs from tblRole Where RoleID=@RoleID
end

GO

-- drop proc spInsertRole
Create proc spInsertRole
@RoleName nvarchar(50),
@isActive bit,
@CreatedBy nvarchar(50)
as
begin
	Declare @RoleID nvarchar(50)
	Declare @CurrentRoleID numeric(18,0)
	Declare @RoleIDPrefix as nvarchar(5)

	set @RoleIDPrefix='ROLE-'

begin tran

	select @CurrentRoleID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentRoleID'
	
	set @CurrentRoleID=isnull(@CurrentRoleID,0)+1
	Select @RoleID=dbo.generateID(@RoleIDPrefix,@CurrentRoleID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert Into tblRole(RoleID,RoleName,isActive,CreatedBy)Values(@RoleID,@RoleName,@isActive,@CreatedBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentRoleID where PropertyName='CurrentRoleID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

-- drop proc spUpdateRole
Create proc spUpdateRole
@RoleID nvarchar(50),
@RoleName nvarchar(50),
@isActive bit,
@LastUpdatedBy nvarchar(50)
as
begin
	Update tblRole Set RoleName=@RoleName,isActive=@isActive,LastUpdatedBy=@LastUpdatedBy,LastUpdatedDate=getdate()
	Where RoleID=@RoleID
end

GO

Create proc spUpdateRolePermission
@RoleID nvarchar(50),
@MenuIDList nvarchar(4000),
@LastUpdatedBy nvarchar(50)
as
begin
	Update tblRole Set MenuIDs=@MenuIDList,LastUpdatedBy=@LastUpdatedBy,LastUpdatedDate=getdate()
	Where RoleID=@RoleID
end

Go

Create proc spGetDetailsRoleList
as
begin
	Select RoleID,RoleName,isActive=Case isActive When 1 Then 'YES' Else 'NO' End,
	CreatedBy,Convert(nvarchar,CreatedDate,106) as 'CreatedDate'
	from tblRole Order by RoleName
end

-- exec spGetDetailsRoleList

GO


insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentUserWiseRoleID',0)

GO

-- drop table tblUserWiseRole
Create table tblUserWiseRole(
UserWiseRoleID nvarchar(50) primary key,
EmployeeID nvarchar(50) foreign key references tblEmployeeInfo(EmployeeID),
RoleID nvarchar(50) foreign key references tblRole(RoleID),
IsActive bit default 1,
EntryBy nvarchar(50),
EntryDate Datetime default getdate()
);

Go

-- drop proc spShowUserWiseRole
alter proc spShowUserWiseRole
@EmployeeID nvarchar(50)
as
begin
	Select UWR.UserWiseRoleID,R.RoleID,R.RoleName from tblUserWiseRole UWR Left Join tblRole R On UWR.RoleID=R.RoleID
	Where UWR.IsActive=1 And UWR.EmployeeID=@EmployeeID
end

GO

-- drop proc spGetUserPermission
alter proc spGetUserPermission
@EmployeeID nvarchar(50)
as
begin
	Declare @MenuIDs as nvarchar(4000)
	Set @MenuIDs = ''
	Select @MenuIDs = @MenuIDs + isnull(R.MenuIDs,'') from tblUserWiseRole UWR Left Join tblRole R On UWR.RoleID=R.RoleID
	Where UWR.IsActive=1 And UWR.EmployeeID=@EmployeeID

	Select @MenuIDs as 'MenuIDs'
end

-- exec spGetUserPermission 'USR-00000002'

GO

-- drop function fnGetUserPermission
alter function fnGetUserPermission(@EmployeeID nvarchar(50))
returns nvarchar(4000)
as
begin
	Declare @MenuIDs as nvarchar(4000)
	Set @MenuIDs = ''
	Select @MenuIDs = @MenuIDs + isnull(R.MenuIDs,'') from tblUserWiseRole UWR Left Join tblRole R On UWR.RoleID=R.RoleID
	Where UWR.IsActive=1 And UWR.EmployeeID=@EmployeeID
	
	return @MenuIDs
end

-- select dbo.fnGetUserPermission('USR-00000002')


GO

-- drop proc spInActiveUsrPermission
Create proc spInActiveUsrPermission
@UserWiseRoleID nvarchar(50)
as
begin
	Update tblUserWiseRole Set IsActive=0
	Where UserWiseRoleID=@UserWiseRoleID
end


GO

-- drop proc spInsertUserWiseRole
alter proc spInsertUserWiseRole
@EmployeeID nvarchar(50),
@RoleID nvarchar(50),
@EntryBy nvarchar(50)
as
begin
	Declare @UserWiseRoleID nvarchar(50)
	Declare @CurrentUserWiseRoleID numeric(18,0)
	Declare @UserWiseRoleIDPrefix as nvarchar(7)

	set @UserWiseRoleIDPrefix='USR-RL-'

begin tran

	select @CurrentUserWiseRoleID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentUserWiseRoleID'
	
	set @CurrentUserWiseRoleID=isnull(@CurrentUserWiseRoleID,0)+1
	Select @UserWiseRoleID=dbo.generateID(@UserWiseRoleIDPrefix,@CurrentUserWiseRoleID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert Into tblUserWiseRole(UserWiseRoleID,EmployeeID,RoleID,EntryBy)
	Values(@UserWiseRoleID,@EmployeeID,@RoleID,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentUserWiseRoleID where PropertyName='CurrentUserWiseRoleID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

Go



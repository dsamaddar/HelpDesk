

GO

insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentEmployeeTypeID',0)

GO

-- drop table tblEmployeeType
CREATE TABLE tblEmployeeType(
EmployeeTypeID nvarchar(50) primary key,
EmployeeTypeName nvarchar(200) unique(EmployeeTypeName),
isActive bit default 1,
EntryBy nvarchar(50) ,
EntryDate datetime default getdate()
)
GO

-- Select * from tblEmployeeType

-- drop proc spInsertEmployeeType
CREATE proc spInsertEmployeeType
@EmployeeTypeName nvarchar(200),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @EmployeeTypeID nvarchar(50)
	Declare @CurrentEmployeeTypeID numeric(18,0)
	Declare @EmployeeTypeIDPrefix as nvarchar(9)

	set @EmployeeTypeIDPrefix='EMP-TYPE-'

begin tran
	
	select @CurrentEmployeeTypeID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentEmployeeTypeID'
	
	set @CurrentEmployeeTypeID=isnull(@CurrentEmployeeTypeID,0)+1
	Select @EmployeeTypeID=dbo.generateID(@EmployeeTypeIDPrefix,@CurrentEmployeeTypeID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblEmployeeType(EmployeeTypeID,EmployeeTypeName,IsActive,EntryBy)
	Values(@EmployeeTypeID,@EmployeeTypeName,@IsActive,@EntryBy)

	update tblAppSettings set PropertyValue=@CurrentEmployeeTypeID where PropertyName='CurrentEmployeeTypeID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

exec spInsertEmployeeType 'Permanent',1,'admin'
exec spInsertEmployeeType 'Probationary',1,'admin'
exec spInsertEmployeeType 'Contractual',1,'admin'

GO

CREATE proc spGetEmployeeType
as
SELECT Distinct EmployeeTypeID,EmployeeTypeName FROM tblEmployeeType where isActive =1

-- exec spGetEmployeeType

GO

Create table tblHealthPlan(
HealthPlanID nvarchar(50) primary key,
HealthPlanName nvarchar(100) unique(HealthPlanName),
PremiumPercentage float,
IsActive bit default 1,
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

-- Select * from tblHealthPlan

GO


insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentHealthPlanID',0)

GO

CREATE proc spInsertHealthPlan
@HealthPlanName nvarchar(100),
@PremiumPercentage float,
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @HealthPlanID nvarchar(50)
	Declare @CurrentHealthPlanID numeric(18,0)
	Declare @HealthPlanIDPrefix as nvarchar(7)

	set @HealthPlanIDPrefix='H-PLAN-'

begin tran
	
	select @CurrentHealthPlanID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentHealthPlanID'
	
	set @CurrentHealthPlanID=isnull(@CurrentHealthPlanID,0)+1
	Select @HealthPlanID=dbo.generateID(@HealthPlanIDPrefix,@CurrentHealthPlanID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	INSERT INTO tblHealthPlan(HealthPlanID,HealthPlanName,PremiumPercentage,IsActive,EntryBy)
     	VALUES(@HealthPlanID,@HealthPlanName,@PremiumPercentage,@IsActive,@EntryBy)

	update tblAppSettings set PropertyValue=@CurrentHealthPlanID where PropertyName='CurrentHealthPlanID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

exec spInsertHealthPlan 'Basic',5,1,'admin'
exec spInsertHealthPlan 'Standard',5,1,'admin'
exec spInsertHealthPlan 'Executive',5,1,'admin'
exec spInsertHealthPlan 'Premier',5,1,'admin'

GO

create procedure spGetHealthPlanType
as
begin 
	select HealthPlanID,HealthPlanName from tblHealthPlan where IsActive=1 order by HealthPlanName
end

-- exec spGetHealthPlanType

GO

CREATE TABLE tblDesignation(
DesignationID nvarchar(50) Primary key,
DesignationName nvarchar(200) Unique(DesignationName),
DesignationLabel nvarchar(100),
DesignationType nvarchar(200),
HealthPlanID nvarchar(50) foreign key references tblHealthPlan(HealthPlanID),
intOrder int,
isActive bit default 0,
EntryBy nvarchar(50),
EntryDate datetime default getdate()
)

-- Select * from tblDesignation

GO

insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentDesignationID',0)

GO

--insert designation

-- drop proc spInsertDesignation
Create proc [dbo].[spInsertDesignation]
@DesignationName nvarchar(200),
@DesignationLabel nvarchar(100),
@DesignationType nvarchar(50),
@HealthPlanID nvarchar(50),
@intOrder integer,
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @DesignationID nvarchar(50)
	Declare @CurrentDesignationID numeric(18,0)
	Declare @DesignationIDPrefix as nvarchar(6)

	set @DesignationIDPrefix='DESIG-'

begin tran
	
	select @CurrentDesignationID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentDesignationID'
	
	set @CurrentDesignationID=isnull(@CurrentDesignationID,0)+1
	Select @DesignationID=dbo.generateID(@DesignationIDPrefix,@CurrentDesignationID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblDesignation(DesignationID,DesignationName,DesignationLabel,DesignationType,HealthPlanID  ,intOrder,IsActive,EntryBy)
	Values(@DesignationID,@DesignationName,@DesignationLabel,@DesignationType,@HealthPlanID,@intOrder ,@IsActive,@EntryBy)

	update tblAppSettings set PropertyValue=@CurrentDesignationID where PropertyName='CurrentDesignationID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

CREATE Proc spUpdateDesignation
@DesignationID nvarchar(50),
@DesignationName nvarchar(50),
@DesignationLabel nvarchar(100),
@DesignationType nvarchar(50),
@HealthPlanID nvarchar(50),
@intOrder int,
@IsActive bit
as

begin
	UPDATE tblDesignation
	SET [DesignationName] = @DesignationName,DesignationLabel = @DesignationLabel,DesignationType = @DesignationType
	,HealthPlanID =@HealthPlanID,intOrder = @intOrder,isActive = @IsActive
	WHERE DesignationID=@DesignationID
end


GO

/* Confusing.........................................
exec spInsertDesignation '','','Official',50,1,'admin'
exec spInsertDesignation '','','Functional',1,1,'admin'
*/



--get functional Designation

GO

CREATE proc [dbo].[spGetFunctionalDesignation]
as

SELECT [DesignationID]
      ,[DesignationName]
      ,DesignationLabel
  FROM [dbo].[tblDesignation]
where isActive =1 and [DesignationType]='Functional' order by [intOrder]

GO

--get official designation
CREATE proc [dbo].[spGetOfficialDesignation]
as

SELECT [DesignationID]
      ,[DesignationName]
      ,DesignationLabel
  FROM [dbo].[tblDesignation]
where isActive =1 and [DesignationType]='Official' order by [intOrder] desc

GO


Alter proc spGetDesignation
as
begin

select DesignationID,DesignationName,DesignationLabel,DesignationType,intOrder, HealthPlanID,
(select HealthPlanName  from tblHealthPlan where HealthPlanID =tblDesignation.HealthPlanID ) HealthPlanName,
case when isActive =0 then 'Active' else 'InActive' end as isActive from dbo.tblDesignation  
where DesignationName<>'' order by DesignationType,intOrder 

end

-- exec spGetDesignation

GO

--Create Branch Table

CREATE TABLE tblBranch(
BranchID nvarchar(50) Primary key,
BranchName nvarchar(200) unique(BranchName),
BranchLocation nvarchar(500) ,
isActive bit default 1,
EntryBy nvarchar(50) NULL,
EntryDate datetime default getdate()
)

GO

insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentULCBranchID',0)

GO

--insert ULC Branch 


CREATE proc spInsertULCBranch
@BranchName nvarchar(200),
@BranchLocation nvarchar(500),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @BranchID nvarchar(50)
	Declare @CurrentBranchID numeric(18,0)
	Declare @BranchIDPrefix as nvarchar(3)

	set @BranchIDPrefix='BR-'

begin tran
	
	select @CurrentBranchID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentULCBranchID'
	
	set @CurrentBranchID=isnull(@CurrentBranchID,0)+1
	Select @BranchID=dbo.generateID(@BranchIDPrefix,@CurrentBranchID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblULCBranch(BranchID,BranchName,BranchLocation,IsActive,EntryBy)
	Values(@BranchID,@BranchName,@BranchLocation,@IsActive,@EntryBy)

	update tblAppSettings set PropertyValue=@CurrentBranchID where PropertyName='CurrentULCBranchID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end


GO

/* Done Up To */

exec spInsertULCBranch '','',1,'tahmed1'
exec spInsertULCBranch 'Camellia House','',1,'tahmed1'
exec spInsertULCBranch 'ULX','',1,'tahmed1'
exec spInsertULCBranch 'Farmgate','',1,'tahmed1'


--get ULC Branch

GO

CREATE proc spGetULCBranch
as
SELECT  Distinct ULCBranchID,ULCBranchName  FROM [dbo].[tblULCBranch]
where isActive =1 order by ULCBranchName 

GO

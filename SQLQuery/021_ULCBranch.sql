

Create proc spGetULCBranch
as
begin
	SELECT ULCBranchID,ULCBranchName FROM tblULCBranch where isActive =1 order by ULCBranchName 
end

GO

Create proc spGetULCBranchList
as
begin
	Select distinct ULCBranchID,ULCBranchName from tblULCBranch Where IsActive=1 and ULCBranchName<>'' order by [ULCBranchName] 
end

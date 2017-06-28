

Create view vwProcurement
As
Select I.InvoiceID,I.InvoiceNo,Convert(nvarchar,I.InvoiceDate,106) as 'InvoiceDate',I.InvoiceCost,I.SupplierID,S.SupplierName,
II.ItemID,InI.ItemName+' ( '+ U.UnitType + ' )' as 'ItemName',II.Quantity,II.UnitPrice,II.EntryBy as 'PreparedBy',
IsApproved = Case I.IsApproved When 1 Then 'YES' Else 'NO' End,
I.ApprovedBy,Convert(nvarchar,I.ApprovalDate,106) as 'ApprovalDate'
from tblInvoices I Left join tblInvoiceItems II On I.InvoiceID=II.InvoiceID 
Left Join tblSupplier S On I.SupplierID=S.SupplierID
Left Join tblInventoryItems InI On II.ItemID=InI.ItemID
Left Join tblUnitType U On InI.UnitTypeID=U.UnitTypeID

GO

-- Select * from vwProcurement

-- drop proc spShowProcurementReport
Create proc spShowProcurementReport
@InvoiceNo nvarchar(200),
@PurchaseDateFrom datetime,
@PurchaseDateTo datetime,
@ItemID nvarchar(50),
@SupplierID nvarchar(50)
as
begin
	Declare @InvoiceNoParam as nvarchar(200)
	Declare @ItemIDParam as nvarchar(50)
	Declare @SupplierIDParam as nvarchar(50)

	If @InvoiceNo=''
		Set @InvoiceNoParam = '%'
	Else
		Set @InvoiceNoParam = '%' + @InvoiceNo + '%'

	if @ItemID = 'N\A'
		Set @ItemIDParam = '%'
	Else
		Set @ItemIDParam = '%' + @ItemID + '%'

	If @SupplierID = 'N\A'
		Set @SupplierIDParam = '%'
	Else
		Set @SupplierIDParam = '%'+ @SupplierID +'%'

	Select InvoiceID,InvoiceNo,InvoiceDate,InvoiceCost,SupplierID,SupplierName,ItemID,
	ItemName,Quantity,UnitPrice,PreparedBy,IsApproved,ApprovedBy,ApprovalDate
	from vwProcurement Where 
	InvoiceNo like ''+ @InvoiceNoParam +'' And ItemID like ''+ @ItemIDParam +'' And SupplierID like '' + @SupplierIDParam + ''
	And Convert(datetime,InvoiceDate) between @PurchaseDateFrom And @PurchaseDateTo
	
end

-- exec spShowProcurementReport '','3/1/2013','3/5/2013','N\A','N\A'

GO

Create proc spGetRequisitionStatus
as
begin
	Select Distinct Status from tblRequisition order by Status
end

GO

-- drop view vwRequisitionReport
alter view vwRequisitionReport
As
Select R.RequisitionID,R.EmployeeID,EI.EmployeeName,R.ItemID,InI.ItemName+' ( '+ U.UnitType + ' )' as 'ItemName',
R.Quantity,R.Remarks,isnull(R.DepartmentID,'N\A') as 'DepartmentID',isnull(D.DeptName,'N\A') as 'DepartmentName',
isnull(R.BranchID,'N\A') as 'BranchID',isnull(B.BranchName,'N\A') as 'BranchName',Convert(nvarchar,R.EntryDate,106) as 'RequisitionDate',
IsApproved = Case R.IsApproved When 1 Then 'YES' Else 'NO' End,
R.ApprovedBy,Convert(nvarchar,R.ApprovalDate,106) as 'ApprovalDate',R.ApprovedQuantity,
IsDelivered = Case R.IsDelivered When 1 Then 'YES' Else 'NO' End,
R.DeliveredBy,Convert(nvarchar,R.DeliveryDate,106) as 'DeliveryDate',R.Status,R.ApproverRemarks
From tblRequisition R Left Join tblEmployeeInfo EI On R.EmployeeID=EI.EmployeeID
Left Join tblDepartment D On EI.DepartmentID=D.DepartmentID
Left Join tblBranchInfo B On EI.ULCBranchID=B.BranchID
Left Join tblInventoryItems InI On R.ItemID=InI.ItemID
Left Join tblUnitType U On InI.UnitTypeID=U.UnitTypeID

GO


-- drop proc spShowRequisitionReport
alter proc spShowRequisitionReport
@DateFrom datetime,
@DateTo datetime,
@BranchID nvarchar(50),
@DepartmentID nvarchar(50),
@UniqueUserID nvarchar(50),
@Status nvarchar(50),
@ItemID nvarchar(50)
as
begin

	Declare @BranchIDParam as nvarchar(50)
	Declare @DepartmentIDParam as nvarchar(50)
	Declare @UniqueUserIDParam as nvarchar(50)
	Declare @StatusParam as nvarchar(50)
	Declare @ItemIDParam as nvarchar(50)

	If @BranchID = 'N\A'
		Set @BranchIDParam = '%'
	Else
		Set @BranchIDParam = '%'+ @BranchID +'%'

	If @DepartmentID = 'N\A'
		Set @DepartmentIDParam = '%'
	Else
		Set @DepartmentIDParam = '%'+ @DepartmentID +'%'

	If @UniqueUserID = 'N\A'
		Set @UniqueUserIDParam = '%'
	Else
		Set @UniqueUserIDParam = '%'+ @UniqueUserID +'%'
	
	If @Status = 'N\A'
		Set @StatusParam = '%'
	Else
		Set @StatusParam = '%'+ @Status +'%'

	If @ItemID = 'N\A'
		Set @ItemIDParam = '%'
	Else
		Set @ItemIDParam = '%'+ @ItemID +'%'

	Select RequisitionID,EmployeeID,EmployeeName,ItemID,ItemName,Quantity,Remarks,DepartmentID,DepartmentName,
	BranchID,BranchName,RequisitionDate,IsApproved,ApprovedBy,ApprovalDate,ApprovedQuantity,
	IsDelivered,DeliveredBy,DeliveryDate,Status,ApproverRemarks
	from vwRequisitionReport
	Where BranchID like @BranchIDParam And DepartmentID like @DepartmentIDParam
	And EmployeeID like @UniqueUserIDParam And Status like @StatusParam
	And ItemID like @ItemIDParam And Convert(datetime,RequisitionDate) between @DateFrom And @DateTo
end 

GO

-- drop proc spGetProcurementInfoByItem
Create proc spGetProcurementInfoByItem
@ItemID nvarchar(50)
as
begin
	Select InvoiceID,InvoiceNo,InvoiceDate,SupplierName,Quantity,UnitPrice,PreparedBy,ApprovedBy from vwProcurement
	Where ItemID=@ItemID
end

-- exec spGetProcurementInfoByItem 'ITM-00000002'

GO

-- drop proc spWarehouseItemBalanceByItem
Create proc spWarehouseItemBalanceByItem
@ItemID nvarchar(50)
as
begin
	Select WI.WarehouseID,W.WarehouseName,WI.ItemID,Sum( (WI.ItemBalance-WI.AdjustedBalance) ) as 'Balance'
	From tblWarehouseItems WI Left Join tblWarehouse W On WI.WarehouseID=W.WarehouseID
	Where WI.IsAdjusted=0 And WI.ItemID=@ItemID
	Group by WI.ItemID, WI.WarehouseID,W.WarehouseName
end


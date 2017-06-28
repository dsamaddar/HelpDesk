Imports Microsoft.VisualBasic

Public Class clsItemRequisition

    Dim _RequisitionID, _RequisitionIDList, _EmployeeID, _ItemID, _ItemName, _Remarks, _EntryPoint, _SupervisorID, _DepartmentID, _ULCBranchID, _OnDemandRequisitionFor, _ApprovedBy, _RejectedBy, _DeliveredBy, _Status, _MailStatus, _ApproverRemarks, _EntryBy, _RequisitionItemList, _WarehouseID, _DeliveryEntryPoint, _RequisitionFor As String

    Public Property RequisitionID() As String
        Get
            Return _RequisitionID
        End Get
        Set(ByVal value As String)
            _RequisitionID = value
        End Set
    End Property

    Public Property RequisitionIDList() As String
        Get
            Return _RequisitionIDList
        End Get
        Set(ByVal value As String)
            _RequisitionIDList = value
        End Set
    End Property

    Public Property EmployeeID() As String
        Get
            Return _EmployeeID
        End Get
        Set(ByVal value As String)
            _EmployeeID = value
        End Set
    End Property

    Public Property ItemID() As String
        Get
            Return _ItemID
        End Get
        Set(ByVal value As String)
            _ItemID = value
        End Set
    End Property

    Public Property ItemName() As String
        Get
            Return _ItemName
        End Get
        Set(ByVal value As String)
            _ItemName = value
        End Set
    End Property

    Public Property Remarks() As String
        Get
            Return _Remarks
        End Get
        Set(ByVal value As String)
            _Remarks = value
        End Set
    End Property

    Public Property EntryPoint() As String
        Get
            Return _EntryPoint
        End Get
        Set(ByVal value As String)
            _EntryPoint = value
        End Set
    End Property

    Public Property SupervisorID() As String
        Get
            Return _SupervisorID
        End Get
        Set(ByVal value As String)
            _SupervisorID = value
        End Set
    End Property

    Public Property DepartmentID() As String
        Get
            Return _DepartmentID
        End Get
        Set(ByVal value As String)
            _DepartmentID = value
        End Set
    End Property

    Public Property ULCBranchID() As String
        Get
            Return _ULCBranchID
        End Get
        Set(ByVal value As String)
            _ULCBranchID = value
        End Set
    End Property

    Public Property OnDemandRequisitionFor() As String
        Get
            Return _OnDemandRequisitionFor
        End Get
        Set(ByVal value As String)
            _OnDemandRequisitionFor = value
        End Set
    End Property

    Public Property ApprovedBy() As String
        Get
            Return _ApprovedBy
        End Get
        Set(ByVal value As String)
            _ApprovedBy = value
        End Set
    End Property

    Public Property RejectedBy() As String
        Get
            Return _RejectedBy
        End Get
        Set(ByVal value As String)
            _RejectedBy = value
        End Set
    End Property

    Public Property DeliveredBy() As String
        Get
            Return _DeliveredBy
        End Get
        Set(ByVal value As String)
            _DeliveredBy = value
        End Set
    End Property

    Public Property Status() As String
        Get
            Return _Status
        End Get
        Set(ByVal value As String)
            _Status = value
        End Set
    End Property

    Public Property MailStatus() As String
        Get
            Return _MailStatus
        End Get
        Set(ByVal value As String)
            _MailStatus = value
        End Set
    End Property

    Public Property ApproverRemarks() As String
        Get
            Return _ApproverRemarks
        End Get
        Set(ByVal value As String)
            _ApproverRemarks = value
        End Set
    End Property

    Public Property EntryBy() As String
        Get
            Return _EntryBy
        End Get
        Set(ByVal value As String)
            _EntryBy = value
        End Set
    End Property

    Public Property RequisitionItemList() As String
        Get
            Return _RequisitionItemList
        End Get
        Set(ByVal value As String)
            _RequisitionItemList = value
        End Set
    End Property

    Public Property WarehouseID() As String
        Get
            Return _WarehouseID
        End Get
        Set(ByVal value As String)
            _WarehouseID = value
        End Set
    End Property

    Public Property DeliveryEntryPoint() As String
        Get
            Return _DeliveryEntryPoint
        End Get
        Set(ByVal value As String)
            _DeliveryEntryPoint = value
        End Set
    End Property

    Public Property RequisitionFor() As String
        Get
            Return _RequisitionFor
        End Get
        Set(ByVal value As String)
            _RequisitionFor = value
        End Set
    End Property

    Dim _Quantity, _ApprovedQuantity As Integer

    Public Property Quantity() As Integer
        Get
            Return _Quantity
        End Get
        Set(ByVal value As Integer)
            _Quantity = value
        End Set
    End Property

    Public Property ApprovedQuantity() As Integer
        Get
            Return _ApprovedQuantity
        End Get
        Set(ByVal value As Integer)
            _ApprovedQuantity = value
        End Set
    End Property

    Dim _IsOnDemandRequisition, _IsApproved, _IsRejected, _IsDelivered As Boolean

    Public Property IsOnDemandRequisition() As Boolean
        Get
            Return _IsOnDemandRequisition
        End Get
        Set(ByVal value As Boolean)
            _IsOnDemandRequisition = value
        End Set
    End Property

    Public Property IsApproved() As Boolean
        Get
            Return _IsApproved
        End Get
        Set(ByVal value As Boolean)
            _IsApproved = value
        End Set
    End Property

    Public Property IsRejected() As Boolean
        Get
            Return _IsRejected
        End Get
        Set(ByVal value As Boolean)
            _IsRejected = value
        End Set
    End Property

    Public Property IsDelivered() As String
        Get
            Return _IsDelivered
        End Get
        Set(ByVal value As String)
            _IsDelivered = value
        End Set
    End Property

    Dim _ApprovalDate, _RejectionDate, _DeliveryDate, _EntryDate, _DateFrom, _DateTo As DateTime

    Public Property ApprovalDate() As String
        Get
            Return _ApprovalDate
        End Get
        Set(ByVal value As String)
            _ApprovalDate = value
        End Set
    End Property

    Public Property RejectionDate() As DateTime
        Get
            Return _RejectionDate
        End Get
        Set(ByVal value As DateTime)
            _RejectionDate = value
        End Set
    End Property

    Public Property DeliveryDate() As DateTime
        Get
            Return _DeliveryDate
        End Get
        Set(ByVal value As DateTime)
            _DeliveryDate = value
        End Set
    End Property

    Public Property EntryDate() As DateTime
        Get
            Return _EntryDate
        End Get
        Set(ByVal value As DateTime)
            _EntryDate = value
        End Set
    End Property

    Public Property DateFrom() As DateTime
        Get
            Return _DateFrom
        End Get
        Set(ByVal value As DateTime)
            _DateFrom = value
        End Set
    End Property

    Public Property DateTo() As DateTime
        Get
            Return _DateTo
        End Get
        Set(ByVal value As DateTime)
            _DateTo = value
        End Set
    End Property

End Class

Imports Microsoft.VisualBasic

Public Class clsInvoice

    Dim _InvoiceID, _InvoiceNo, _SupplierID, _SubmittedBy, _ApproverID, _ApprovedBy, _RejectedBy, _EntryBy, _ItemID As String

    Public Property InvoiceID() As String
        Get
            Return _InvoiceID
        End Get
        Set(ByVal value As String)
            _InvoiceID = value
        End Set
    End Property

    Public Property InvoiceNo() As String
        Get
            Return _InvoiceNo
        End Get
        Set(ByVal value As String)
            _InvoiceNo = value
        End Set
    End Property

    Public Property SupplierID() As String
        Get
            Return _SupplierID
        End Get
        Set(ByVal value As String)
            _SupplierID = value
        End Set
    End Property

    Public Property SubmittedBy() As String
        Get
            Return _SubmittedBy
        End Get
        Set(ByVal value As String)
            _SubmittedBy = value
        End Set
    End Property

    Public Property ApproverID() As String
        Get
            Return _ApproverID
        End Get
        Set(ByVal value As String)
            _ApproverID = value
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

    Public Property EntryBy() As String
        Get
            Return _EntryBy
        End Get
        Set(ByVal value As String)
            _EntryBy = value
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

    Dim _InvoiceDate, _SubmissionDate, _ApprovalDate, _RejectionDate, _EntryDate, _PurchaseDateFrom, _PurchaseDateTo As DateTime

    Public Property InvoiceDate() As DateTime
        Get
            Return _InvoiceDate
        End Get
        Set(ByVal value As DateTime)
            _InvoiceDate = value
        End Set
    End Property

    Public Property SubmissionDate() As DateTime
        Get
            Return _SubmissionDate
        End Get
        Set(ByVal value As DateTime)
            _SubmissionDate = value
        End Set
    End Property

    Public Property ApprovalDate() As DateTime
        Get
            Return _ApprovalDate
        End Get
        Set(ByVal value As DateTime)
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

    Public Property EntryDate() As DateTime
        Get
            Return _EntryDate
        End Get
        Set(ByVal value As DateTime)
            _EntryDate = value
        End Set
    End Property

    Public Property PurchaseDateFrom() As DateTime
        Get
            Return _PurchaseDateFrom
        End Get
        Set(ByVal value As DateTime)
            _PurchaseDateFrom = value
        End Set
    End Property

    Public Property PurchaseDateTo() As DateTime
        Get
            Return _PurchaseDateTo
        End Get
        Set(ByVal value As DateTime)
            _PurchaseDateTo = value
        End Set
    End Property

    Dim _IsSubmitted, _IsApproved, _IsRejected As Boolean

    Public Property IsSubmitted() As Boolean
        Get
            Return _IsSubmitted
        End Get
        Set(ByVal value As Boolean)
            _IsSubmitted = value
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

    Dim _InvoiceCost As Double

    Public Property InvoiceCost() As Double
        Get
            Return _InvoiceCost
        End Get
        Set(ByVal value As Double)
            _InvoiceCost = value
        End Set
    End Property

End Class

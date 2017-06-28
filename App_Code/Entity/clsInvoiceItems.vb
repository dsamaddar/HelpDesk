Imports Microsoft.VisualBasic

Public Class clsInvoiceItems

    Dim _InvoiceItemID, _InvoiceID, _ItemID, _ItemName, _InvoiceItemList, _EntryBy As String

    Public Property InvoiceItemID() As String
        Get
            Return _InvoiceItemID
        End Get
        Set(ByVal value As String)
            _InvoiceItemID = value
        End Set
    End Property

    Public Property InvoiceID() As String
        Get
            Return _InvoiceID
        End Get
        Set(ByVal value As String)
            _InvoiceID = value
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

    Public Property InvoiceItemList() As String
        Get
            Return _InvoiceItemList
        End Get
        Set(ByVal value As String)
            _InvoiceItemList = value
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

    Dim _Quantity As Integer

    Public Property Quantity() As Integer
        Get
            Return _Quantity
        End Get
        Set(ByVal value As Integer)
            _Quantity = value
        End Set
    End Property

    Dim _UnitPrice As Double

    Public Property UnitPrice() As Double
        Get
            Return _UnitPrice
        End Get
        Set(ByVal value As Double)
            _UnitPrice = value
        End Set
    End Property

    Dim _EntryDate As DateTime

    Public Property EntryDate() As DateTime
        Get
            Return _EntryDate
        End Get
        Set(ByVal value As DateTime)
            _EntryDate = value
        End Set
    End Property


End Class

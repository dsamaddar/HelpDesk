Imports Microsoft.VisualBasic

Public Class clsWarehouseItems

    Dim _WarehouseItemID, _WarehouseID, _WarehouseName, _InvoiceID, _ItemID, _ItemName, _EntryBy, _WarehouseItemList As String

    Public Property WarehouseItemID() As String
        Get
            Return _WarehouseItemID
        End Get
        Set(ByVal value As String)
            _WarehouseItemID = value
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

    Public Property WarehouseName() As String
        Get
            Return _WarehouseName
        End Get
        Set(ByVal value As String)
            _WarehouseName = value
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

    Public Property EntryBy() As String
        Get
            Return _EntryBy
        End Get
        Set(ByVal value As String)
            _EntryBy = value
        End Set
    End Property

    Public Property WarehouseItemList() As String
        Get
            Return _WarehouseItemList
        End Get
        Set(ByVal value As String)
            _WarehouseItemList = value
        End Set
    End Property

    Dim _ItemBalance, _AdjustedBalance As Integer

    Public Property ItemBalance() As Integer
        Get
            Return _ItemBalance
        End Get
        Set(ByVal value As Integer)
            _ItemBalance = value
        End Set
    End Property

    Public Property AdjustedBalance() As Integer
        Get
            Return _AdjustedBalance
        End Get
        Set(ByVal value As Integer)
            _AdjustedBalance = value
        End Set
    End Property

    Dim _AdjustmentDate, _EntryDate As DateTime

    Public Property AdjustmentDate() As DateTime
        Get
            Return _AdjustmentDate
        End Get
        Set(ByVal value As DateTime)
            _AdjustmentDate = value
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

    Dim _IsAdjusted As Boolean

    Public Property IsAdjusted() As Boolean
        Get
            Return _IsAdjusted
        End Get
        Set(ByVal value As Boolean)
            _IsAdjusted = value
        End Set
    End Property

End Class

Imports Microsoft.VisualBasic

Public Class clsWareToWareBalTransfer

    Dim _SourceWarehouseID, _SourceWarehouse, _DestWarehouseID, _DestWarehouse, _ItemID, _ItemName, _WareToWareBalTransList, _EntryBy As String

    Public Property SourceWarehouseID() As String
        Get
            Return _SourceWarehouseID
        End Get
        Set(ByVal value As String)
            _SourceWarehouseID = value
        End Set
    End Property

    Public Property SourceWarehouse() As String
        Get
            Return _SourceWarehouse
        End Get
        Set(ByVal value As String)
            _SourceWarehouse = value
        End Set
    End Property

    Public Property DestWarehouseID() As String
        Get
            Return _DestWarehouseID
        End Get
        Set(ByVal value As String)
            _DestWarehouseID = value
        End Set
    End Property

    Public Property DestWarehouse() As String
        Get
            Return _DestWarehouse
        End Get
        Set(ByVal value As String)
            _DestWarehouse = value
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

    Public Property WareToWareBalTransList() As String
        Get
            Return _WareToWareBalTransList
        End Get
        Set(ByVal value As String)
            _WareToWareBalTransList = value
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

    Dim _TransferQuantity As Integer

    Public Property TransferQuantity() As Integer
        Get
            Return _TransferQuantity
        End Get
        Set(ByVal value As Integer)
            _TransferQuantity = value
        End Set
    End Property

End Class

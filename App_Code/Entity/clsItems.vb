Imports Microsoft.VisualBasic

Public Class clsItems

    Dim _ItemID, _ItemName, _ItemCode, _UnitTypeID, _EntryBy As String

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

    Public Property ItemCode() As String
        Get
            Return _ItemCode
        End Get
        Set(ByVal value As String)
            _ItemCode = value
        End Set
    End Property

    Public Property UnitTypeID() As String
        Get
            Return _UnitTypeID
        End Get
        Set(ByVal value As String)
            _UnitTypeID = value
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

    Dim _LowBalanceReport, _MaxAllowableRequisition As Integer

    Public Property LowBalanceReport() As Integer
        Get
            Return _LowBalanceReport
        End Get
        Set(ByVal value As Integer)
            _LowBalanceReport = value
        End Set
    End Property

    Public Property MaxAllowableRequisition() As Integer
        Get
            Return _MaxAllowableRequisition
        End Get
        Set(ByVal value As Integer)
            _MaxAllowableRequisition = value
        End Set
    End Property

    Dim _IsActive As Boolean

    Public Property IsActive() As Boolean
        Get
            Return _IsActive
        End Get
        Set(ByVal value As Boolean)
            _IsActive = value
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

Imports Microsoft.VisualBasic

Public Class clsMenu

    Dim _MenuID, _MenuName, _MenuGroupID As String

    Public Property MenuID() As String
        Get
            Return _MenuID
        End Get
        Set(ByVal value As String)
            _MenuID = value
        End Set
    End Property

    Public Property MenuName() As String
        Get
            Return _MenuName
        End Get
        Set(ByVal value As String)
            _MenuName = value
        End Set
    End Property

    Public Property MenuGroupID() As String
        Get
            Return _MenuGroupID
        End Get
        Set(ByVal value As String)
            _MenuGroupID = value
        End Set
    End Property

    Dim _ViewOrder As Integer

    Public Property ViewOrder() As Integer
        Get
            Return _ViewOrder
        End Get
        Set(ByVal value As Integer)
            _ViewOrder = value
        End Set
    End Property


End Class

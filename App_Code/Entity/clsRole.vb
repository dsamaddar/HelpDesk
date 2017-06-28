Imports Microsoft.VisualBasic

Public Class clsRole

    Dim _RoleID, _RoleName, _MenuIDs, _ActivityIDs, _CreatedBy, _LastUpdatedBy, _MenuIDList As String

    Public Property RoleID() As String
        Get
            Return _RoleID
        End Get
        Set(ByVal value As String)
            _RoleID = value
        End Set
    End Property

    Public Property RoleName() As String
        Get
            Return _RoleName
        End Get
        Set(ByVal value As String)
            _RoleName = value
        End Set
    End Property

    Public Property MenuIDs() As String
        Get
            Return _MenuIDs
        End Get
        Set(ByVal value As String)
            _MenuIDs = value
        End Set
    End Property

    Public Property ActivityIDs() As String
        Get
            Return _ActivityIDs
        End Get
        Set(ByVal value As String)
            _ActivityIDs = value
        End Set
    End Property

    Public Property CreatedBy() As String
        Get
            Return _CreatedBy
        End Get
        Set(ByVal value As String)
            _CreatedBy = value
        End Set
    End Property

    Public Property LastUpdatedBy() As String
        Get
            Return _LastUpdatedBy
        End Get
        Set(ByVal value As String)
            _LastUpdatedBy = value
        End Set
    End Property

    Public Property MenuIDList() As String
        Get
            Return _MenuIDList
        End Get
        Set(ByVal value As String)
            _MenuIDList = value
        End Set
    End Property

    Dim _isActive As Boolean

    Public Property isActive() As Boolean
        Get
            Return _isActive
        End Get
        Set(ByVal value As Boolean)
            _isActive = value
        End Set
    End Property

    Dim _CreatedDate, _LastUpdatedDate As DateTime

    Public Property CreatedDate() As DateTime
        Get
            Return _CreatedDate
        End Get
        Set(ByVal value As DateTime)
            _CreatedDate = value
        End Set
    End Property

    Public Property LastUpdatedDate() As DateTime
        Get
            Return _LastUpdatedDate
        End Get
        Set(ByVal value As DateTime)
            _LastUpdatedDate = value
        End Set
    End Property

End Class

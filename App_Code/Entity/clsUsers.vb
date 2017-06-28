Imports Microsoft.VisualBasic

Public Class clsUsers

    Dim _UniqueUserID, _EmployeeID, _UserName, _UserID, _UserPassword, _Email, _UserType, _Gender, _ContactNumber, _SupervisorID, _DepartmentID, _BranchID, _EntryBy, _PermittedMenus, _ChangedPassword As String

    Public Property UniqueUserID() As String
        Get
            Return _UniqueUserID
        End Get
        Set(ByVal value As String)
            _UniqueUserID = value
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

    Public Property UserName() As String
        Get
            Return _UserName
        End Get
        Set(ByVal value As String)
            _UserName = value
        End Set
    End Property

    Public Property UserID() As String
        Get
            Return _UserID
        End Get
        Set(ByVal value As String)
            _UserID = value
        End Set
    End Property

    Public Property UserPassword() As String
        Get
            Return _UserPassword
        End Get
        Set(ByVal value As String)
            _UserPassword = value
        End Set
    End Property

    Public Property Email() As String
        Get
            Return _Email
        End Get
        Set(ByVal value As String)
            _Email = value
        End Set
    End Property

    Public Property UserType() As String
        Get
            Return _UserType
        End Get
        Set(ByVal value As String)
            _UserType = value
        End Set
    End Property

    Public Property Gender() As String
        Get
            Return _Gender
        End Get
        Set(ByVal value As String)
            _Gender = value
        End Set
    End Property

    Public Property ContactNumber() As String
        Get
            Return _ContactNumber
        End Get
        Set(ByVal value As String)
            _ContactNumber = value
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

    Public Property BranchID() As String
        Get
            Return _BranchID
        End Get
        Set(ByVal value As String)
            _BranchID = value
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

    Public Property PermittedMenus() As String
        Get
            Return _PermittedMenus
        End Get
        Set(ByVal value As String)
            _PermittedMenus = value
        End Set
    End Property

    Public Property ChangedPassword() As String
        Get
            Return _ChangedPassword
        End Get
        Set(ByVal value As String)
            _ChangedPassword = value
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

    Dim _DateOfBirth, _EntryDate As DateTime

    Public Property DateOfBirth() As DateTime
        Get
            Return _DateOfBirth
        End Get
        Set(ByVal value As DateTime)
            _DateOfBirth = value
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

End Class

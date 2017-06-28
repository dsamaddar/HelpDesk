Imports Microsoft.VisualBasic

Public Class clsDepartment

    Dim _DepartmentID, _DepartmentName, _DeptCode, _HODID, _DeptMailAddress, _EntryBy As String

    Public Property DepartmentID() As String
        Get
            Return _DepartmentID
        End Get
        Set(ByVal value As String)
            _DepartmentID = value
        End Set
    End Property

    Public Property DepartmentName() As String
        Get
            Return _DepartmentName
        End Get
        Set(ByVal value As String)
            _DepartmentName = value
        End Set
    End Property

    Public Property DeptCode() As String
        Get
            Return _DeptCode
        End Get
        Set(ByVal value As String)
            _DeptCode = value
        End Set
    End Property

    Public Property HODID() As String
        Get
            Return _HODID
        End Get
        Set(ByVal value As String)
            _HODID = value
        End Set
    End Property

    Public Property DeptMailAddress() As String
        Get
            Return _DeptMailAddress
        End Get
        Set(ByVal value As String)
            _DeptMailAddress = value
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

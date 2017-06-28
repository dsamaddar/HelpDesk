Imports Microsoft.VisualBasic

Public Class clsEmployeeInfo

    Dim _EmployeeID, _UserID, _Password, _UserPassword, _UserType, _EmployeeName, _EmpTypeCode, _EmpCode, _EmpTypeID, _DesignationID, _DepartmentID, _
    _ULCBranchID, _CurrentSupervisor, _EmpStatus, _EntryBy, _PermittedMenus, _MailAddress, _MobileNo As String

    Public Property EmployeeID() As String
        Get
            Return _EmployeeID
        End Get
        Set(ByVal value As String)
            _EmployeeID = value
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

    Public Property Password() As String
        Get
            Return _Password
        End Get
        Set(ByVal value As String)
            _Password = value
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

    Public Property UserType() As String
        Get
            Return _UserType
        End Get
        Set(ByVal value As String)
            _UserType = value
        End Set
    End Property

    Public Property EmployeeName() As String
        Get
            Return _EmployeeName
        End Get
        Set(ByVal value As String)
            _EmployeeName = value
        End Set
    End Property

    Public Property EmpTypeCode() As String
        Get
            Return _EmpTypeCode
        End Get
        Set(ByVal value As String)
            _EmpTypeCode = value
        End Set
    End Property

    Public Property EmpCode() As String
        Get
            Return _EmpCode
        End Get
        Set(ByVal value As String)
            _EmpCode = value
        End Set
    End Property

    Public Property EmpTypeID() As String
        Get
            Return _EmpTypeID
        End Get
        Set(ByVal value As String)
            _EmpTypeID = value
        End Set
    End Property

    Public Property DesignationID() As String
        Get
            Return _DesignationID
        End Get
        Set(ByVal value As String)
            _DesignationID = value
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

    Public Property CurrentSupervisor() As String
        Get
            Return _CurrentSupervisor
        End Get
        Set(ByVal value As String)
            _CurrentSupervisor = value
        End Set
    End Property

    Public Property EmpStatus() As String
        Get
            Return _EmpStatus
        End Get
        Set(ByVal value As String)
            _EmpStatus = value
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

    Public Property MailAddress() As String
        Get
            Return _MailAddress
        End Get
        Set(ByVal value As String)
            _MailAddress = value
        End Set
    End Property

    Dim _Designation, _Department, _ULCBranchName, _Supervisor As String

    Public Property Designation() As String
        Get
            Return _Designation
        End Get
        Set(ByVal value As String)
            _Designation = value
        End Set
    End Property

    Public Property Department() As String
        Get
            Return _Department
        End Get
        Set(ByVal value As String)
            _Department = value
        End Set
    End Property

    Public Property ULCBranchName() As String
        Get
            Return _ULCBranchName
        End Get
        Set(ByVal value As String)
            _ULCBranchName = value
        End Set
    End Property

    Public Property Supervisor() As String
        Get
            Return _Supervisor
        End Get
        Set(ByVal value As String)
            _Supervisor = value
        End Set
    End Property

    Public Property MobileNo() As String
        Get
            Return _MobileNo
        End Get
        Set(ByVal value As String)
            _MobileNo = value
        End Set
    End Property

    Dim _DateOfBirth, _JoiningDate, _EntryDate As DateTime

    Public Property DateOfBirth() As DateTime
        Get
            Return _DateOfBirth
        End Get
        Set(ByVal value As DateTime)
            _DateOfBirth = value
        End Set
    End Property

    Public Property JoiningDate() As DateTime
        Get
            Return _JoiningDate
        End Get
        Set(ByVal value As DateTime)
            _JoiningDate = value
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

    Dim _IsActive As Boolean

    Public Property IsActive() As Boolean
        Get
            Return _IsActive
        End Get
        Set(ByVal value As Boolean)
            _IsActive = value
        End Set
    End Property

End Class

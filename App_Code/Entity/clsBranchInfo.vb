Imports Microsoft.VisualBasic

Public Class clsBranchInfo

    Dim _BranchID, _BranchName, _BranchCode, _HOBranch, _Address, _ContactNumber, _BranchMailAddress, _EntryBy As String

    Public Property BranchID() As String
        Get
            Return _BranchID
        End Get
        Set(ByVal value As String)
            _BranchID = value
        End Set
    End Property

    Public Property BranchName() As String
        Get
            Return _BranchName
        End Get
        Set(ByVal value As String)
            _BranchName = value
        End Set
    End Property

    Public Property BranchCode() As String
        Get
            Return _BranchCode
        End Get
        Set(ByVal value As String)
            _BranchCode = value
        End Set
    End Property

    Public Property HOBranch() As String
        Get
            Return _HOBranch
        End Get
        Set(ByVal value As String)
            _HOBranch = value
        End Set
    End Property

    Public Property Address() As String
        Get
            Return _Address
        End Get
        Set(ByVal value As String)
            _Address = value
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

    Public Property BranchMailAddress() As String
        Get
            Return _BranchMailAddress
        End Get
        Set(ByVal value As String)
            _BranchMailAddress = value
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

    Dim _EntryData As DateTime

    Public Property EntryData() As DateTime
        Get
            Return _EntryData
        End Get
        Set(ByVal value As DateTime)
            _EntryData = value
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

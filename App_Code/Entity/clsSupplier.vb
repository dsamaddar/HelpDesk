Imports Microsoft.VisualBasic

Public Class clsSupplier

    Dim _SupplierID, _SupplierName, _Address, _ContactPerson, _ContactNumber, _AboutSupplier, _Company_Phone_Mobile, _Fax, _Email, _EntryBy As String

    Public Property SupplierID() As String
        Get
            Return _SupplierID
        End Get
        Set(ByVal value As String)
            _SupplierID = value
        End Set
    End Property

    Public Property SupplierName() As String
        Get
            Return _SupplierName
        End Get
        Set(ByVal value As String)
            _SupplierName = value
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

    Public Property ContactPerson() As String
        Get
            Return _ContactPerson
        End Get
        Set(ByVal value As String)
            _ContactPerson = value
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

    Public Property AboutSupplier() As String
        Get
            Return _AboutSupplier
        End Get
        Set(ByVal value As String)
            _AboutSupplier = value
        End Set
    End Property

    Public Property Company_Phone_Mobile() As String
        Get
            Return _Company_Phone_Mobile
        End Get
        Set(ByVal value As String)
            _Company_Phone_Mobile = value
        End Set
    End Property

    Public Property Fax() As String
        Get
            Return _Fax
        End Get
        Set(ByVal value As String)
            _Fax = value
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

    Public Property EntryBy() As String
        Get
            Return _EntryBy
        End Get
        Set(ByVal value As String)
            _EntryBy = value
        End Set
    End Property

    Dim _IsBlackListed As Boolean

    Public Property IsBlackListed() As Boolean
        Get
            Return _IsBlackListed
        End Get
        Set(ByVal value As Boolean)
            _IsBlackListed = value
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

Imports Microsoft.VisualBasic

Public Class clsEmployee
    Dim _DesignationName, _DesignationID, _HealthPlanID, _DesignationLabel, _DesignationType, _EntryBy As String

    Dim _intOrder As Integer

    Public Property DesignationName() As String
        Get
            Return _DesignationName
        End Get
        Set(ByVal value As String)
            _DesignationName = value
        End Set
    End Property

    Public Property DesignationLabel() As String
        Get
            Return _DesignationLabel
        End Get
        Set(ByVal value As String)
            _DesignationLabel = value
        End Set
    End Property
    Public Property HealthPlanID() As String
        Get
            Return _HealthPlanID
        End Get
        Set(ByVal value As String)
            _HealthPlanID = value
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

    Public Property DesignationType() As String
        Get
            Return _DesignationType
        End Get
        Set(ByVal value As String)
            _DesignationType = value
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

    Public Property intOrder() As String
        Get
            Return _intOrder
        End Get
        Set(ByVal value As String)
            _intOrder = value
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
End Class

Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Public Class clsULCBranch

    Public con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ChaserConnectionString").ConnectionString)
    Public con2 As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NorthWind").ConnectionString)
    Public conHRM As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)
    Dim _ULCBranchID, _ULCBranchName, _BranchLocation, _EntryBy As String

    Public Property ULCBranchID() As String
        Get
            Return _ULCBranchID
        End Get
        Set(ByVal value As String)
            _ULCBranchID = value
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

    Public Property BranchLocation() As String
        Get
            Return _BranchLocation
        End Get
        Set(ByVal value As String)
            _BranchLocation = value
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

    Dim _isActive As Boolean

    Public Property isActive() As Boolean
        Get
            Return _isActive
        End Get
        Set(ByVal value As Boolean)
            _isActive = value
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

#Region " Insert ULC Branch "

    Public Function fnInsertULCBranch(ByVal ULCBranch As clsULCBranch) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertULCBranch", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@ULCBranchName", ULCBranch.ULCBranchName)
            cmd.Parameters.AddWithValue("@BranchLocation", ULCBranch.BranchLocation)
            cmd.Parameters.AddWithValue("@IsActive", ULCBranch.isActive)
            cmd.Parameters.AddWithValue("@EntryBy", ULCBranch.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Return 1
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function

#End Region

#Region " Update ULC Branch "

    Public Function fnUpdateULCBranch(ByVal ULCBranch As clsULCBranch) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateULCBranch", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@ULCBranchID", ULCBranch.ULCBranchID)
            cmd.Parameters.AddWithValue("@ULCBranchName", ULCBranch.ULCBranchName)
            cmd.Parameters.AddWithValue("@BranchLocation", ULCBranch.BranchLocation)
            cmd.Parameters.AddWithValue("@IsActive", ULCBranch.isActive)
            cmd.ExecuteNonQuery()
            con.Close()
            Return 1
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function

#End Region

#Region " Get Total ULC Branch "

    Public Function fnGetTotalULCBranch() As DataSet
        Dim sp As String = "spGetTotalULCBranch"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get ULC Branch "

    Public Function fnGetULCBranch() As DataSet
        Dim sp As String = "spGetULCBranch"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()

                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

End Class

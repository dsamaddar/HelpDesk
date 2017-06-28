Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Public Class clsULCBranchDataAccess

    Public con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HelpDeskConnectionString").ConnectionString)
    Public conHRM As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

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

Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data


Public Class clsBranchDataAccess

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HelpDeskConnectionString").ConnectionString)

#Region " Insert Branch Info "

    Public Function fnInsertBranchInfo(ByVal BranchInfo As clsBranchInfo) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertBranchInfo", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@BranchName", BranchInfo.BranchName)
            cmd.Parameters.AddWithValue("@BranchCode", BranchInfo.BranchCode)
            cmd.Parameters.AddWithValue("@HOBranch", BranchInfo.HOBranch)
            cmd.Parameters.AddWithValue("@Address", BranchInfo.Address)
            cmd.Parameters.AddWithValue("@ContactNumber", BranchInfo.ContactNumber)
            cmd.Parameters.AddWithValue("@BranchMailAddress", BranchInfo.BranchMailAddress)
            cmd.Parameters.AddWithValue("@IsActive", BranchInfo.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", BranchInfo.EntryBy)

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

#Region " Update Branch Info "

    Public Function fnUpdateBranchInfo(ByVal BranchInfo As clsBranchInfo) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateBranchInfo", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@BranchID", BranchInfo.BranchID)
            cmd.Parameters.AddWithValue("@BranchName", BranchInfo.BranchName)
            cmd.Parameters.AddWithValue("@BranchCode", BranchInfo.BranchCode)
            cmd.Parameters.AddWithValue("@HOBranch", BranchInfo.HOBranch)
            cmd.Parameters.AddWithValue("@Address", BranchInfo.Address)
            cmd.Parameters.AddWithValue("@ContactNumber", BranchInfo.ContactNumber)
            cmd.Parameters.AddWithValue("@BranchMailAddress", BranchInfo.BranchMailAddress)
            cmd.Parameters.AddWithValue("@IsActive", BranchInfo.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", BranchInfo.EntryBy)

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

#Region " Get Branch List "

    Public Function fnGetBranchList() As DataSet

        Dim sp As String = "spGetBranchList"
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

#Region " Get Details Branch List "

    Public Function fnGetDetailsBranchList() As DataSet

        Dim sp As String = "spGetDetailsBranchList"
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

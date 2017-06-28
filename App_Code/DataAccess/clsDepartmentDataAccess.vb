Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data


Public Class clsDepartmentDataAccess

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HelpDeskConnectionString").ConnectionString)

#Region " Insert Department "

    Public Function fnInsertDepartment(ByVal Department As clsDepartment) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertDepartment", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@DepartmentName", Department.DepartmentName)
            cmd.Parameters.AddWithValue("@DeptCode", Department.DeptCode)
            cmd.Parameters.AddWithValue("@HODID", Department.HODID)
            cmd.Parameters.AddWithValue("@DeptMailAddress", Department.DeptMailAddress)
            cmd.Parameters.AddWithValue("@IsActive", Department.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", Department.EntryBy)

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

#Region " Update Department "

    Public Function fnUpdateDepartment(ByVal Department As clsDepartment) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateDepartment", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@DepartmentID", Department.DepartmentID)
            cmd.Parameters.AddWithValue("@DepartmentName", Department.DepartmentName)
            cmd.Parameters.AddWithValue("@DeptCode", Department.DeptCode)
            cmd.Parameters.AddWithValue("@HODID", Department.HODID)
            cmd.Parameters.AddWithValue("@DeptMailAddress", Department.DeptMailAddress)
            cmd.Parameters.AddWithValue("@IsActive", Department.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", Department.EntryBy)

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

#Region " Get Dept List "

    Public Function fnGetDeptList() As DataSet

        Dim sp As String = "spGetDeptList"
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

#Region " Get Department List "

    Public Function fnGetDepartmentList() As DataSet

        Dim sp As String = "spGetDepartmentList"
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

#Region " GetRequisition Remaining Department List "

    Public Function fnGetReqRemDepartmentList() As DataSet

        Dim sp As String = "spGetReqRemDepartmentList"
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

#Region " Get Details DepartmentList "

    Public Function fnGetDetailsDepartmentList() As DataSet

        Dim sp As String = "spGetDetailsDepartmentList"
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

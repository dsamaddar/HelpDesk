Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsUserDataAccess

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HelpDeskConnectionString").ConnectionString)

#Region " Insert Users "

    Public Function fnInsertUsers(ByVal Users As clsUsers) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertUsers", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@UserName", Users.UserName)
            cmd.Parameters.AddWithValue("@DateOfBirth", Users.DateOfBirth)
            cmd.Parameters.AddWithValue("@UserID", Users.UserID)
            cmd.Parameters.AddWithValue("@UserPassword", Users.UserPassword)
            cmd.Parameters.AddWithValue("@Email", Users.Email)
            cmd.Parameters.AddWithValue("@UserType", Users.UserType)
            cmd.Parameters.AddWithValue("@Gender", Users.Gender)
            cmd.Parameters.AddWithValue("@ContactNumber", Users.ContactNumber)
            cmd.Parameters.AddWithValue("@SupervisorID", Users.SupervisorID)
            cmd.Parameters.AddWithValue("@DepartmentID", Users.DepartmentID)
            cmd.Parameters.AddWithValue("@BranchID", Users.BranchID)
            cmd.Parameters.AddWithValue("@IsActive", Users.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", Users.EntryBy)

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

#Region " Update Users "

    Public Function fnUpdateUsers(ByVal Users As clsUsers) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateUsers", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@UniqueUserID", Users.UniqueUserID)
            cmd.Parameters.AddWithValue("@UserName", Users.UserName)
            cmd.Parameters.AddWithValue("@DateOfBirth", Users.DateOfBirth)
            cmd.Parameters.AddWithValue("@UserID", Users.UserID)
            cmd.Parameters.AddWithValue("@UserPassword", Users.UserPassword)
            cmd.Parameters.AddWithValue("@Email", Users.Email)
            cmd.Parameters.AddWithValue("@UserType", Users.UserType)
            cmd.Parameters.AddWithValue("@Gender", Users.Gender)
            cmd.Parameters.AddWithValue("@ContactNumber", Users.ContactNumber)
            cmd.Parameters.AddWithValue("@SupervisorID", Users.SupervisorID)
            cmd.Parameters.AddWithValue("@DepartmentID", Users.DepartmentID)
            cmd.Parameters.AddWithValue("@BranchID", Users.BranchID)
            cmd.Parameters.AddWithValue("@IsActive", Users.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", Users.EntryBy)

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

#Region " Show User List "

    Public Function fnShowUserList() As DataSet

        Dim sp As String = "spShowUserList"
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

#Region " Show Details Users List "

    Public Function fnShowDetailsUsersList() As DataSet

        Dim sp As String = "spShowDetailsUsersList"
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

#Region " Get Req Rem Dept Wise User "

    Public Function fnGetReqRemDeptWiseUser(ByVal DepartmentID As String) As DataSet

        Dim sp As String = "spGetReqRemDeptWiseUser"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@DepartmentID", DepartmentID)
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

#Region " Authenticate User "

    Public Function fnAuthenticateUser(ByVal UserInfo As clsUsers) As clsUsers

        Dim sp As String = "spAuthenticateUser"
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@UserID", UserInfo.UserID)
                cmd.Parameters.AddWithValue("@UserPassword", UserInfo.UserPassword)
                Dim dr As SqlDataReader = cmd.ExecuteReader()
                While dr.Read()
                    UserInfo.UserName = dr.Item("UserName")
                    UserInfo.UserID = dr.Item("UserID")
                    UserInfo.UniqueUserID = dr.Item("UniqueUserID")
                    UserInfo.PermittedMenus = dr.Item("PermittedMenus")
                End While
                con.Close()
                Return UserInfo
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region



#Region " Validate Old Password "

    Public Function fnValidateOldPassword(ByVal Users As clsUsers) As Integer

        Dim IsValid As Integer = 0
        Try
            Dim cmd As SqlCommand = New SqlCommand("spValidateOldPassword", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmployeeID", Users.EmployeeID)
            cmd.Parameters.AddWithValue("@UserPassword", Users.UserPassword)
            Dim dr As SqlDataReader = cmd.ExecuteReader()
            While dr.Read()
                IsValid = dr.Item("IsValid")
            End While
            con.Close()
            Return IsValid
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function

#End Region

#Region " Change Password "

    Public Function fnChangePassword(ByVal Users As clsUsers) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spChangePassword", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmployeeID", Users.EmployeeID)
            cmd.Parameters.AddWithValue("@ChangedPassword", Users.ChangedPassword)
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



End Class

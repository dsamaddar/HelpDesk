Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsRoleDataAccess

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HelpDeskConnectionString").ConnectionString)

#Region " Insert Role "

    Public Function fnInsertRole(ByVal Role As clsRole) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertRole", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@RoleName", Role.RoleName)
            cmd.Parameters.AddWithValue("@isActive", Role.isActive)
            cmd.Parameters.AddWithValue("@CreatedBy", Role.CreatedBy)
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

#Region " Update Role "

    Public Function fnUpdateRole(ByVal Role As clsRole) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateRole", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@RoleID", Role.RoleID)
            cmd.Parameters.AddWithValue("@RoleName", Role.RoleName)
            cmd.Parameters.AddWithValue("@isActive", Role.isActive)
            cmd.Parameters.AddWithValue("@LastUpdatedBy", Role.LastUpdatedBy)
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

#Region " Get Details Role List "

    Public Function fnGetDetailsRoleList() As DataSet
        Dim sp As String = "spGetDetailsRoleList"
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

#Region " Get Role List "

    Public Function fnGetRoleList() As DataSet
        Dim sp As String = "spGetRoleList"
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

#Region " Get Role Wise Menu IDs "

    Public Function fnGetRoleWiseMenuIDs(ByVal RoleID As String) As String
        Dim sp As String = "spGetRoleWiseMenuIDs"
        Dim MenuIDs As String = ""
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@RoleID", RoleID)
                Dim dr As SqlDataReader = cmd.ExecuteReader()

                While dr.Read()
                    MenuIDs = dr.Item("MenuIDs")
                End While

                con.Close()
                Return MenuIDs
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return ""
        End Try
    End Function

#End Region




#Region " Update Role "

    Public Function fnUpdateRolePermission(ByVal Role As clsRole) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateRolePermission", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@RoleID", Role.RoleID)
            cmd.Parameters.AddWithValue("@MenuIDList", Role.MenuIDList)
            cmd.Parameters.AddWithValue("@LastUpdatedBy", Role.LastUpdatedBy)
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

Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsMenuDataAccess

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HelpDeskConnectionString").ConnectionString)

#Region " Get Menu List By Group "

    Public Function fnGetMenuListByGroup(ByVal MenuGroupID As String) As DataSet

        Dim sp As String = "spGetMenuListByGroup"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@MenuGroupID", MenuGroupID)
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

#Region " GetMenuGroupList "

    Public Function fnGetMenuGroupList() As DataSet

        Dim sp As String = "spGetMenuGroupList"
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

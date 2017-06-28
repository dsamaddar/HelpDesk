Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsUnitTypeDataAccess

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HelpDeskConnectionString").ConnectionString)

#Region " Insert Unit Type "

    Public Function fnInsertUnitType(ByVal UnitType As clsUnitType) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertUnitType", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@UnitType", UnitType.UnitType)
            cmd.Parameters.AddWithValue("@IsActive", UnitType.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", UnitType.EntryBy)

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

#Region " Update Unit Type "

    Public Function fnUpdateUnitType(ByVal UnitType As clsUnitType) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateUnitType", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@UnitTypeID", UnitType.UnitTypeID)
            cmd.Parameters.AddWithValue("@UnitType", UnitType.UnitType)
            cmd.Parameters.AddWithValue("@IsActive", UnitType.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", UnitType.EntryBy)
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

#Region " Get Unit Type List "

    Public Function fnGetUnitTypeList() As DataSet

        Dim sp As String = "spGetUnitTypeList"
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

#Region " Show Details Unit Type List "

    Public Function fnShowDetailsUnitTypeList() As DataSet

        Dim sp As String = "spShowDetailsUnitTypeList"
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

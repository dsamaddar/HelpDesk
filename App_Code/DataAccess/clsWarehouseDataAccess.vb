Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsWarehouseDataAccess

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HelpDeskConnectionString").ConnectionString)

#Region " Insert Warehouse "

    Public Function fnInsertWarehouse(ByVal Warehouse As clsWarehouse) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertWarehouse", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@WarehouseName", Warehouse.WarehouseName)
            cmd.Parameters.AddWithValue("@WarehouseCode", Warehouse.WarehouseCode)
            cmd.Parameters.AddWithValue("@BranchID", Warehouse.BranchID)
            cmd.Parameters.AddWithValue("@Location", Warehouse.Location)
            cmd.Parameters.AddWithValue("@Details", Warehouse.Details)
            cmd.Parameters.AddWithValue("@IsActive", Warehouse.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", Warehouse.EntryBy)

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

#Region " Update Warehouse "

    Public Function fnUpdateWarehouse(ByVal Warehouse As clsWarehouse) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateWarehouse", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@WarehouseID", Warehouse.WarehouseID)
            cmd.Parameters.AddWithValue("@WarehouseName", Warehouse.WarehouseName)
            cmd.Parameters.AddWithValue("@WarehouseCode", Warehouse.WarehouseCode)
            cmd.Parameters.AddWithValue("@BranchID", Warehouse.BranchID)
            cmd.Parameters.AddWithValue("@Location", Warehouse.Location)
            cmd.Parameters.AddWithValue("@Details", Warehouse.Details)
            cmd.Parameters.AddWithValue("@IsActive", Warehouse.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", Warehouse.EntryBy)

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

#Region " Get Warehouse List "

    Public Function fnGetWarehouseList() As DataSet

        Dim sp As String = "spGetWarehouseList"
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

#Region " Get Details Warehouse List "

    Public Function fnGetDetailsWarehouseList() As DataSet

        Dim sp As String = "spGetDetailsWarehouseList"
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

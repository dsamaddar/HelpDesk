Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsWarehouseItemDataAccess

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HelpDeskConnectionString").ConnectionString)

#Region " Insert Multiple Warehouse Items "

    Public Function fnInsertMultipleWareHItems(ByVal WarehouseItems As clsWarehouseItems) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertMultipleWareHItems", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@InvoiceID", WarehouseItems.InvoiceID)
            cmd.Parameters.AddWithValue("@WarehouseItemList", WarehouseItems.WarehouseItemList)
            cmd.Parameters.AddWithValue("@EntryBy", WarehouseItems.EntryBy)

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

#Region " Get Warehouse Item Balance "

    Public Function fnGetWarehouseItemBalance(ByVal WarehouseID As String) As DataSet

        Dim sp As String = "spGetWarehouseItemBalance"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@WarehouseID", WarehouseID)
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

#Region " Get Warehouse Item Balance By Item "

    Public Function fnGetWarehouseItemBalByItem(ByVal WarehouseID As String, ByVal ItemID As String) As Integer

        Dim sp As String = "spGetWarehouseItemBalByItem"
        Dim dr As SqlDataReader
        Dim Balance As Integer = 0
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@WarehouseID", WarehouseID)
                cmd.Parameters.AddWithValue("@ItemID", ItemID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    Balance = dr.Item("Balance")
                End While
                con.Close()
                Return Balance
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function

#End Region

#Region " Ware To Ware Balance Transfer List "

    Public Function fnWareToWareBalTransferList(ByVal WTWBalTrans As clsWareToWareBalTransfer) As Integer

        Dim sp As String = "spWareToWareBalTransferList"
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@WareToWareBalTransList", WTWBalTrans.WareToWareBalTransList)
                cmd.Parameters.AddWithValue("@EntryBy", WTWBalTrans.EntryBy)
                cmd.ExecuteNonQuery()
                con.Close()
                Return 1
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function

#End Region

#Region " Warehouse Item Balance By Item "

    Public Function fnWarehouseItemBalanceByItem(ByVal ItemID As String) As DataSet

        Dim sp As String = "spWarehouseItemBalanceByItem"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ItemID", ItemID)
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

#Region " Get Item Balance By Item "

    Public Function fnGetItemBalanceByItem(ByVal ItemID As String) As Integer

        Dim sp As String = "spGetItemBalanceByItem"
        Dim dr As SqlDataReader
        Dim Balance As Integer = 0
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ItemID", ItemID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    Balance = dr.Item("Balance")
                End While
                con.Close()
                Return Balance
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function

#End Region

End Class

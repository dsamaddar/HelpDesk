Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsInvoiceItemDataAccess

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HelpDeskConnectionString").ConnectionString)

#Region " Insert Multiple Invoice Items "

    Public Function fnInsertMultipleInvoiceItems(ByVal InvoiceItems As clsInvoiceItems) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertMultipleInvoiceItems", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@InvoiceID", InvoiceItems.InvoiceID)
            cmd.Parameters.AddWithValue("@InvoiceItemList", InvoiceItems.InvoiceItemList)
            cmd.Parameters.AddWithValue("@EntryBy", InvoiceItems.EntryBy)

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

#Region " Get Items By Invoice At Approval "

    Public Function fnGetItemsByInvoiceAtApp(ByVal InvoiceID As String) As DataSet

        Dim sp As String = "spGetItemsByInvoiceAtApp"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@InvoiceID", InvoiceID)
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

#Region " Get Items By Invoice "

    Public Function fnGetItemsByInvoice(ByVal InvoiceID As String) As DataSet

        Dim sp As String = "spGetItemsByInvoice"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@InvoiceID", InvoiceID)
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

#Region " Get Item Invoice Quantity "

    Public Function fnGetItemInvoiceQuantity(ByVal InvoiceItems As clsInvoiceItems) As Integer
        Try
            Dim ItemQuantity As Integer = 0
            Dim dr As SqlDataReader
            Dim cmd As SqlCommand = New SqlCommand("spGetItemInvoiceQuantity", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@InvoiceID", InvoiceItems.InvoiceID)
            cmd.Parameters.AddWithValue("@ItemID", InvoiceItems.ItemID)

            dr = cmd.ExecuteReader()
            While dr.Read()
                ItemQuantity = dr.Item("Quantity")
            End While
            con.Close()

            Return ItemQuantity
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function

#End Region

#Region " Get Procurement Info By Item "

    Public Function fnGetProcurementInfoByItem(ByVal ItemID As String) As DataSet

        Dim sp As String = "spGetProcurementInfoByItem"
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

End Class

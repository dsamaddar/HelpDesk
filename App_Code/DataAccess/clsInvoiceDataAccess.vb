Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsInvoiceDataAccess

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HelpDeskConnectionString").ConnectionString)

#Region " Insert Invoice "

    Public Function fnInsertInvoice(ByVal Invoice As clsInvoice) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertInvoice", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@InvoiceNo", Invoice.InvoiceNo)
            cmd.Parameters.AddWithValue("@SupplierID", Invoice.SupplierID)
            cmd.Parameters.AddWithValue("@InvoiceDate", Invoice.InvoiceDate)
            cmd.Parameters.AddWithValue("@InvoiceCost", Invoice.InvoiceCost)
            cmd.Parameters.AddWithValue("@ApproverID", Invoice.ApproverID)
            cmd.Parameters.AddWithValue("@EntryBy", Invoice.EntryBy)

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

#Region " Approve Invoice "

    Public Function fnApproveInvoice(ByVal Invoice As clsInvoice) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spApproveInvoice", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@InvoiceID", Invoice.InvoiceID)
            cmd.Parameters.AddWithValue("@ApprovedBy", Invoice.ApprovedBy)

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

#Region " Reject Invoice "

    Public Function fnRejectInvoice(ByVal Invoice As clsInvoice) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spRejectInvoice", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@InvoiceID", Invoice.InvoiceID)
            cmd.Parameters.AddWithValue("@RejectedBy", Invoice.RejectedBy)

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

#Region " Get Details Invoice List "

    Public Function fnGetDetailsInvoiceList() As DataSet

        Dim sp As String = "spGetDetailsInvoiceList"
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

#Region " Get Details Invoice List To Approve "

    Public Function fnGetDetailsInvLstToApprove(ByVal ApproverID As String) As DataSet

        Dim sp As String = "spGetDetailsInvLstToApprove"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ApproverID", ApproverID)
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

#Region " Get Approved Invoice Un Allocated "

    Public Function fnGetApprovedInvoiceUnAllocated() As DataSet

        Dim sp As String = "spGetApprovedInvoiceUnAllocated"
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

#Region " Show Procurement Report "

    Public Function fnShowProcurementReport(ByVal InvoiceInfo As clsInvoice) As DataSet

        Dim sp As String = "spShowProcurementReport"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@InvoiceNo", InvoiceInfo.InvoiceNo)
                cmd.Parameters.AddWithValue("@PurchaseDateFrom", InvoiceInfo.PurchaseDateFrom)
                cmd.Parameters.AddWithValue("@PurchaseDateTo", InvoiceInfo.PurchaseDateTo)
                cmd.Parameters.AddWithValue("@ItemID", InvoiceInfo.ItemID)
                cmd.Parameters.AddWithValue("@SupplierID", InvoiceInfo.SupplierID)
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

Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsItemDataAccess

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HelpDeskConnectionString").ConnectionString)

#Region " Insert Inventory Items "

    Public Function fnInsertInventoryItems(ByVal Items As clsItems) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertInventoryItems", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@ItemName", Items.ItemName)
            cmd.Parameters.AddWithValue("@ItemCode", Items.ItemCode)
            cmd.Parameters.AddWithValue("@UnitTypeID", Items.UnitTypeID)
            cmd.Parameters.AddWithValue("@LowBalanceReport", Items.LowBalanceReport)
            cmd.Parameters.AddWithValue("@MaxAllowableRequisition", Items.MaxAllowableRequisition)
            cmd.Parameters.AddWithValue("@IsActive", Items.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", Items.EntryBy)
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

#Region " Update Inventory Items "

    Public Function fnUpdateInventoryItems(ByVal Items As clsItems) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateInventoryItems", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@ItemID", Items.ItemID)
            cmd.Parameters.AddWithValue("@ItemName", Items.ItemName)
            cmd.Parameters.AddWithValue("@ItemCode", Items.ItemCode)
            cmd.Parameters.AddWithValue("@UnitTypeID", Items.UnitTypeID)
            cmd.Parameters.AddWithValue("@LowBalanceReport", Items.LowBalanceReport)
            cmd.Parameters.AddWithValue("@MaxAllowableRequisition", Items.MaxAllowableRequisition)
            cmd.Parameters.AddWithValue("@IsActive", Items.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", Items.EntryBy)
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

#Region " Get Item List "

    Public Function fnGetItemList() As DataSet

        Dim sp As String = "spGetItemList"
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

#Region " Get Requisition Remmaining Item List "

    Public Function fnGetReqRemItemList() As DataSet

        Dim sp As String = "spGetReqRemItemList"
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

#Region " Get Item List Details "

    Public Function fnGetItemListDetails() As DataSet

        Dim sp As String = "spGetItemListDetails"
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

#Region " Get Low Balance Item List "

    Public Function fnGetLowBalanceItemList() As DataSet

        Dim sp As String = "spGetLowBalanceItemList"
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

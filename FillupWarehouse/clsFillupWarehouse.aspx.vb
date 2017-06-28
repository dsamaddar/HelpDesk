Imports System
Imports System.Data
Imports System.Data.SqlClient

Partial Class FillupWarehouse_clsFillupWarehouse
    Inherits System.Web.UI.Page

    Dim InvoiceData As New clsInvoiceDataAccess()
    Dim InvoiceItemData As New clsInvoiceItemDataAccess()
    Dim WarehouseItemData As New clsWarehouseItemDataAccess()
    Dim WarehouseData As New clsWarehouseDataAccess()

    Protected Function FormatAllocation() As DataTable
        Dim dt As DataTable = New DataTable()
        dt.Columns.Add("ItemID", System.Type.GetType("System.String"))
        dt.Columns.Add("ItemName", System.Type.GetType("System.String"))
        dt.Columns.Add("WarehouseID", System.Type.GetType("System.String"))
        dt.Columns.Add("WarehouseName", System.Type.GetType("System.String"))
        dt.Columns.Add("Allocated", System.Type.GetType("System.Decimal"))
        Return dt
    End Function

    Protected Function FormatItemWiseAllocation() As DataTable
        Dim dt As DataTable = New DataTable()
        dt.Columns.Add("ItemID", System.Type.GetType("System.String"))
        dt.Columns.Add("ItemName", System.Type.GetType("System.String"))
        dt.Columns.Add("Allocated", System.Type.GetType("System.Decimal"))
        Return dt
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "ProcToWare~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then

            Session("dtAllocation") = ""
            Session("dtItemWiseAllocation") = ""

            GetUnAllocatedApprovedInv()
            GetWarehouseList()

            Dim dtAllocation As DataTable = New DataTable()
            dtAllocation = FormatAllocation()
            Session("dtAllocation") = dtAllocation

            Dim dtItemWiseAllocation As DataTable = New DataTable()
            dtItemWiseAllocation = FormatItemWiseAllocation()
            Session("dtItemWiseAllocation") = dtItemWiseAllocation

            btnTransfer.Enabled = False
            btnSubmit.Enabled = False

        End If
    End Sub

    Protected Sub GetUnAllocatedApprovedInv()
        grdInvoiceUnAllocated.DataSource = InvoiceData.fnGetApprovedInvoiceUnAllocated()
        grdInvoiceUnAllocated.DataBind()
    End Sub

    Protected Sub GetWarehouseList()
        drpWarehouseList.DataTextField = "WarehouseName"
        drpWarehouseList.DataValueField = "WarehouseID"
        drpWarehouseList.DataSource = WarehouseData.fnGetWarehouseList()
        drpWarehouseList.DataBind()
    End Sub

    Protected Sub GetInvoiceItems(ByVal InvoiceID As String)
        drpInventoryItems.DataTextField = "ItemName"
        drpInventoryItems.DataValueField = "ItemID"
        drpInventoryItems.DataSource = InvoiceItemData.fnGetItemsByInvoice(InvoiceID)
        drpInventoryItems.DataBind()
    End Sub

    Protected Sub btnTransfer_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnTransfer.Click
        lblWarningMsg.Text = ""
        If Convert.ToInt32(txtTransferQuantity.Text) > Convert.ToInt32(lblItemBalanceRemaining.Text) Or Convert.ToInt32(txtTransferQuantity.Text) = 0 Then
            MessageBox("You Can't Add This Quantity")
            lblWarningMsg.Text = "You Can't Add This Quantity"
            Exit Sub
        End If

        Dim WarehouseItems As New clsWarehouseItems()

        WarehouseItems.ItemID = drpInventoryItems.SelectedValue
        WarehouseItems.ItemName = drpInventoryItems.SelectedItem.ToString()
        WarehouseItems.WarehouseID = drpWarehouseList.SelectedValue
        WarehouseItems.WarehouseName = drpWarehouseList.SelectedItem.ToString()
        WarehouseItems.ItemBalance = Convert.ToInt32(txtTransferQuantity.Text)

        Dim dtAllocation As DataTable = New DataTable()

        dtAllocation = AddAllocation(WarehouseItems)
        Session("dtAllocation") = dtAllocation

        grdAllocation.DataSource = dtAllocation
        grdAllocation.DataBind()

        ClearTransferItem()
        UpdateItemBalance(drpInventoryItems.SelectedValue)

        '' Check For All Allocation Is Done 
        Dim IsAllocationDone As Boolean = False
        IsAllocationDone = ChqIfAllocationIsDone()

        If IsAllocationDone = True Then
            btnSubmit.Enabled = True
            btnTransfer.Enabled = False
        Else
            btnTransfer.Enabled = True
            btnSubmit.Enabled = False
        End If

    End Sub

    Protected Function ChqIfAllocationIsDone() As Boolean
        Dim lblInvoiceID As New System.Web.UI.WebControls.Label()
        Dim InvoiceItems As New clsInvoiceItems()
        Dim ItemQuantity As Integer = 0
        lblInvoiceID = grdInvoiceUnAllocated.SelectedRow.FindControl("lblInvoiceID")

        Dim dtItemWiseAllocation As DataTable = New DataTable()
        dtItemWiseAllocation = Session("dtItemWiseAllocation")

        InvoiceItems.InvoiceID = lblInvoiceID.Text

        For Each itm As ListItem In drpInventoryItems.Items
           
            InvoiceItems.ItemID = itm.Value

            ItemQuantity = InvoiceItemData.fnGetItemInvoiceQuantity(InvoiceItems)

            For Each rw As DataRow In dtItemWiseAllocation.Rows
                If rw.Item("ItemID") = itm.Value Then
                    ItemQuantity -= Convert.ToInt32(rw.Item("Allocated"))
                    Exit For
                End If
            Next

            If ItemQuantity <> 0 Then
                Return False
            End If
        Next

        Return True

    End Function

    Protected Sub ClearTransferItem()
        txtTransferQuantity.Text = ""
        drpWarehouseList.SelectedIndex = -1
    End Sub

    Protected Function AddAllocation(ByVal WarehouserItems As clsWarehouseItems) As DataTable

        Dim dtAllocation As DataTable = New DataTable()
        dtAllocation = Session("dtAllocation")

        '' Chq If Item Already Exists

        If ChqItemAlreadyExists(WarehouserItems) = 1 Then
            MessageBox("Item Already In The List.")
            Return dtAllocation
        End If

        Dim dr As DataRow
        dr = dtAllocation.NewRow()
        dr("ItemID") = WarehouserItems.ItemID
        dr("ItemName") = WarehouserItems.ItemName
        dr("WarehouseID") = WarehouserItems.WarehouseID
        dr("WarehouseName") = WarehouserItems.WarehouseName
        dr("Allocated") = WarehouserItems.ItemBalance



        dtAllocation.Rows.Add(dr)
        dtAllocation.AcceptChanges()

        '' Update ItemWise Allocation Table
        grdItemWiseAllocation.DataSource = AddItemWiseAllocation(WarehouserItems)
        grdItemWiseAllocation.DataBind()

        Return dtAllocation

    End Function

    Protected Function ChqItemAlreadyExists(ByVal WarehouserItems As clsWarehouseItems) As Integer

        Dim dtAllocation As DataTable = New DataTable()
        dtAllocation = Session("dtAllocation")

        Dim IsExists As Boolean = False
        Dim ExistingItemID As String = ""
        Dim ExistingWarehouseID As String = ""

        For Each rw As DataRow In dtAllocation.Rows
            ExistingItemID = rw.Item("ItemID")
            ExistingWarehouseID = rw.Item("WarehouseID")
            If ExistingItemID = WarehouserItems.ItemID And ExistingWarehouseID = WarehouserItems.WarehouseID Then
                IsExists = True
                Exit For
            End If
        Next

        If IsExists = True Then
            Return 1
        Else
            Return 0
        End If

    End Function

    Protected Function AddItemWiseAllocation(ByVal WarehouserItems As clsWarehouseItems) As DataTable

        Dim dtItemWiseAllocation As DataTable = New DataTable()
        dtItemWiseAllocation = Session("dtItemWiseAllocation")

        '' Chq If Item Already Exists Then Update
        If ChqItemWiseAllocationAlreadyExists(WarehouserItems) = 1 Then
            For Each rw As DataRow In dtItemWiseAllocation.Rows

                If rw.Item("ItemID") = WarehouserItems.ItemID Then
                    rw.Item("Allocated") = Convert.ToInt32(rw.Item("Allocated")) + Convert.ToInt32(txtTransferQuantity.Text)
                    Return dtItemWiseAllocation
                End If
            Next
        End If

        Dim dr As DataRow
        dr = dtItemWiseAllocation.NewRow()
        dr("ItemID") = WarehouserItems.ItemID
        dr("ItemName") = WarehouserItems.ItemName
        dr("Allocated") = WarehouserItems.ItemBalance

        dtItemWiseAllocation.Rows.Add(dr)
        dtItemWiseAllocation.AcceptChanges()

        Return dtItemWiseAllocation

    End Function

    Protected Function ChqItemWiseAllocationAlreadyExists(ByVal WarehouserItems As clsWarehouseItems) As Integer
        Try
            Dim dtItemWiseAllocation As DataTable = New DataTable()
            dtItemWiseAllocation = Session("dtItemWiseAllocation")

            Dim IsExists As Boolean = False
            Dim ExistingItemID As String = ""

            For Each rw As DataRow In dtItemWiseAllocation.Rows
                ExistingItemID = rw.Item("ItemID")
                If ExistingItemID = WarehouserItems.ItemID Then
                    IsExists = True
                    Exit For
                End If
            Next

            If IsExists = True Then
                Return 1
            Else
                Return 0
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Function

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearForm()
    End Sub

    Protected Sub ClearForm()
        grdAllocation.DataSource = ""
        grdAllocation.DataBind()

        grdItemWiseAllocation.DataSource = ""
        grdItemWiseAllocation.DataBind()

        drpInventoryItems.DataSource = ""
        drpInventoryItems.DataBind()

        grdInvoiceUnAllocated.SelectedIndex = -1
        lblItemBalanceRemaining.Text = "0"

        drpWarehouseList.SelectedIndex = -1

        GetUnAllocatedApprovedInv()
        GetWarehouseList()

        btnSubmit.Enabled = False
        btnTransfer.Enabled = False

        Session("dtItemWiseAllocation") = ""
        Session("dtAllocation") = ""
    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click

        Dim lblInvoiceID, lblItemID, lblWarehouseID, lblAllocated As New System.Web.UI.WebControls.Label()
        Dim WarehouseItemList As String = ""
        Dim WarehouseItems As New clsWarehouseItems()

        Try
            For Each rw As GridViewRow In grdAllocation.Rows
                lblWarehouseID = rw.FindControl("lblWarehouseID")
                lblItemID = rw.FindControl("lblItemID")
                lblAllocated = rw.FindControl("lblAllocated")

                WarehouseItemList += lblWarehouseID.Text & "~" & lblItemID.Text & "~" & lblAllocated.Text & "~|"
            Next

            lblInvoiceID = grdInvoiceUnAllocated.SelectedRow.FindControl("lblInvoiceID")
            WarehouseItems.InvoiceID = lblInvoiceID.Text
            WarehouseItems.WarehouseItemList = WarehouseItemList
            WarehouseItems.EntryBy = Session("LoginUserID")

            Dim Check As Integer = WarehouseItemData.fnInsertMultipleWareHItems(WarehouseItems)

            If Check = 1 Then
                MessageBox("Submitted Successfully.")
                Response.Redirect("clsFillupWarehouse.aspx")
                ClearForm()
            Else
                MessageBox("Error Found.")
            End If

        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

    End Sub

    Protected Sub grdInvoiceUnAllocated_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdInvoiceUnAllocated.SelectedIndexChanged
        Dim lblInvoiceID As New System.Web.UI.WebControls.Label()

        Try
            lblInvoiceID = grdInvoiceUnAllocated.SelectedRow.FindControl("lblInvoiceID")

            GetInvoiceItems(lblInvoiceID.Text)

            If drpInventoryItems.Items.Count > 0 Then
                drpInventoryItems.SelectedIndex = 0

                Dim InvoiceItems As New clsInvoiceItems()
                Dim ItemQuantity As Integer = 0

                InvoiceItems.InvoiceID = lblInvoiceID.Text
                InvoiceItems.ItemID = drpInventoryItems.SelectedValue

                ItemQuantity = InvoiceItemData.fnGetItemInvoiceQuantity(InvoiceItems)

                lblItemBalanceRemaining.Text = ItemQuantity
            End If

            btnTransfer.Enabled = True
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub drpInventoryItems_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpInventoryItems.SelectedIndexChanged
        Try
            Dim InvoiceItems As New clsInvoiceItems()
            Dim lblInvoiceID As New System.Web.UI.WebControls.Label()
            Dim ItemQuantity As Integer = 0

            lblInvoiceID = grdInvoiceUnAllocated.SelectedRow.FindControl("lblInvoiceID")

            InvoiceItems.InvoiceID = lblInvoiceID.Text
            InvoiceItems.ItemID = drpInventoryItems.SelectedValue

            ItemQuantity = InvoiceItemData.fnGetItemInvoiceQuantity(InvoiceItems)

            lblItemBalanceRemaining.Text = ItemQuantity


            UpdateItemBalance(drpInventoryItems.SelectedValue)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub grdAllocation_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles grdAllocation.RowDeleting
        Dim i As Integer

        Dim ItemID As String = ""
        Dim Allocated As Integer = 0

        Dim dtAllocation As DataTable = New DataTable()
        dtAllocation = Session("dtAllocation")

        Dim dtItemWiseAllocation As DataTable = New DataTable()
        dtItemWiseAllocation = Session("dtItemWiseAllocation")

        i = e.RowIndex

        ItemID = dtAllocation.Rows(i).Item("ItemID")
        Allocated = dtAllocation.Rows(i).Item("Allocated")

        For Each rw As DataRow In dtItemWiseAllocation.Rows
            If rw.Item("ItemID") = ItemID Then
                rw.Item("Allocated") = Convert.ToInt32(rw.Item("Allocated")) - Allocated

                dtItemWiseAllocation.AcceptChanges()

                Session("dtItemWiseAllocation") = dtItemWiseAllocation

                grdItemWiseAllocation.DataSource = dtItemWiseAllocation
                grdItemWiseAllocation.DataBind()

                '' If Item Balance Goes To Zero Then Delete The Item from ItemWise Allocation List.
                If rw.Item("Allocated") = 0 Then
                    DeleteItemFrmItmWiseAllocation(rw.Item("ItemID"))
                End If

                Exit For
            End If
        Next

        dtAllocation.Rows(i).Delete()
        dtAllocation.AcceptChanges()

        Session("dtAllocation") = dtAllocation

        grdAllocation.DataSource = dtAllocation
        grdAllocation.DataBind()

        UpdateItemBalance(drpInventoryItems.SelectedValue)

        '' Check For All Allocation Is Done 
        Dim IsAllocationDone As Boolean = False
        IsAllocationDone = ChqIfAllocationIsDone()

        If IsAllocationDone = True Then
            btnSubmit.Enabled = True
            btnTransfer.Enabled = False
        Else
            btnTransfer.Enabled = True
            btnSubmit.Enabled = False
        End If

    End Sub

    Protected Sub UpdateItemBalance(ByVal ItemID As String)
        Try
            Dim InvoiceItems As New clsInvoiceItems()
            Dim ItemQuantity As Integer = 0
            Dim lblInvoiceID As New System.Web.UI.WebControls.Label()

            Dim dtItemWiseAllocation As DataTable = New DataTable()
            dtItemWiseAllocation = Session("dtItemWiseAllocation")

            lblInvoiceID = grdInvoiceUnAllocated.SelectedRow.FindControl("lblInvoiceID")

            InvoiceItems.InvoiceID = lblInvoiceID.Text
            InvoiceItems.ItemID = ItemID

            ItemQuantity = InvoiceItemData.fnGetItemInvoiceQuantity(InvoiceItems)

            For Each rw As DataRow In dtItemWiseAllocation.Rows
                If rw.Item("ItemID") = ItemID Then
                    ItemQuantity -= Convert.ToInt32(rw.Item("Allocated"))
                    Exit For
                End If
            Next

            lblItemBalanceRemaining.Text = ItemQuantity
            txtTransferQuantity.Text = lblItemBalanceRemaining.Text
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub DeleteItemFrmItmWiseAllocation(ByVal ItemID As String)
        Try
            Dim dtItemWiseAllocation As DataTable = New DataTable()
            dtItemWiseAllocation = Session("dtItemWiseAllocation")

            For Each rw As DataRow In dtItemWiseAllocation.Rows
                If rw.Item("ItemID") = ItemID Then
                    rw.Delete()
                    dtItemWiseAllocation.AcceptChanges()

                    Session("dtItemWiseAllocation") = dtItemWiseAllocation

                    grdItemWiseAllocation.DataSource = dtItemWiseAllocation
                    grdItemWiseAllocation.DataBind()

                    Exit For
                End If
            Next
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

End Class

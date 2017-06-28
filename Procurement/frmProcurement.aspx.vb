Imports System
Imports System.Data
Imports System.Data.SqlClient

Partial Class frmProcurement
    Inherits System.Web.UI.Page

    Dim ItemData As New clsItemDataAccess()
    Dim InvoiceData As New clsInvoiceDataAccess()
    Dim InvoiceItemData As New clsInvoiceItemDataAccess()

    Shared InvoiceCostRemaining As Double = 0

    Dim TotalCost As Double = 0

    Protected Function FormatInvoiceItem() As DataTable
        Dim dt As DataTable = New DataTable()
        dt.Columns.Add("ItemID", System.Type.GetType("System.String"))
        dt.Columns.Add("ItemName", System.Type.GetType("System.String"))
        dt.Columns.Add("Quantity", System.Type.GetType("System.Decimal"))
        dt.Columns.Add("UnitPrice", System.Type.GetType("System.Decimal"))
        dt.Columns.Add("TotalPrice", System.Type.GetType("System.Double"))
        Return dt
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "ProcInput~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then
            ShowInvoiceDetails()
            ShowItemList()

            Session("dtInvoiceItem") = ""
            TotalCost = 0
            InvoiceCostRemaining = 0
            hdFldInvoiceID.Value = ""

            btnAddItemPurchase.Enabled = False
            btnSubmitProcurement.Enabled = False

            Dim dtInvoiceItem As DataTable = New DataTable()
            dtInvoiceItem = FormatInvoiceItem()
            Session("dtInvoiceItem") = dtInvoiceItem

        End If
    End Sub

    Protected Sub ShowInvoiceDetails()
        grdInvoiceSelection.DataSource = InvoiceData.fnGetDetailsInvoiceList()
        grdInvoiceSelection.DataBind()
    End Sub

    Protected Sub ShowItemList()
        drpItemList.DataTextField = "ItemName"
        drpItemList.DataValueField = "ItemID"
        drpItemList.DataSource = ItemData.fnGetItemList()
        drpItemList.DataBind()

        Dim A As New ListItem

        A.Text = "N\A"
        A.Value = "N\A"

        drpItemList.Items.Insert(0, A)

    End Sub

    Protected Sub grdInvoiceSelection_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdInvoiceSelection.SelectedIndexChanged
        Dim lblInvoiceID, lblInvoiceNo, lblSupplierName, lblInvoiceDate, lblInvoiceCost As New System.Web.UI.WebControls.Label()

        lblInvoiceID = grdInvoiceSelection.SelectedRow.FindControl("lblInvoiceID")
        lblInvoiceNo = grdInvoiceSelection.SelectedRow.FindControl("lblInvoiceNo")
        lblSupplierName = grdInvoiceSelection.SelectedRow.FindControl("lblSupplierName")
        lblInvoiceDate = grdInvoiceSelection.SelectedRow.FindControl("lblInvoiceDate")
        lblInvoiceCost = grdInvoiceSelection.SelectedRow.FindControl("lblInvoiceCost")

        hdFldInvoiceID.Value = lblInvoiceID.Text
        lblSupplier.Text = lblSupplierName.Text
        lblFrmInvoiceNo.Text = lblInvoiceNo.Text
        lblPurchaseDate.Text = lblInvoiceDate.Text
        lblTotalCost.Text = lblInvoiceCost.Text
        lblAllocationRemaining.Text = lblInvoiceCost.Text

        InvoiceCostRemaining = Convert.ToDouble(lblInvoiceCost.Text)

        btnAddItemPurchase.Enabled = True

    End Sub

    Protected Sub pnlCancelSelection_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles pnlCancelSelection.Click
        drpItemList.SelectedIndex = -1
        txtQuantity.Text = ""
        txtUnitPrice.Text = ""
    End Sub

    Protected Sub ClearAddInvoiceItems()
        drpItemList.SelectedIndex = -1
        txtQuantity.Text = ""
        txtUnitPrice.Text = ""
    End Sub

    Protected Sub btnAddItemPurchase_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddItemPurchase.Click
        If drpItemList.SelectedValue = "N\A" Then
            MessageBox("Select An Item First.")
            Exit Sub
        End If

        Dim InvoiceItems As New clsInvoiceItems()

        InvoiceItems.ItemID = drpItemList.SelectedValue
        InvoiceItems.ItemName = drpItemList.SelectedItem.ToString()
        InvoiceItems.Quantity = txtQuantity.Text
        InvoiceItems.UnitPrice = txtUnitPrice.Text

        If ChqItemAlreadyExists(InvoiceItems.ItemID) = 1 Then
            MessageBox("Item Already In The List.")
            Exit Sub
        End If

        If Math.Round(Convert.ToDouble(InvoiceItems.Quantity * InvoiceItems.UnitPrice), 2) > Math.Round(InvoiceCostRemaining, 2) Then
            MessageBox("This Item Exceeds Total Invoice Cost.")
            Exit Sub
        Else
            InvoiceCostRemaining -= Math.Round(Convert.ToDouble(InvoiceItems.Quantity * InvoiceItems.UnitPrice), 2)

            lblAllocationRemaining.Text = InvoiceCostRemaining
        End If

        Dim dtInvoiceItem As DataTable = New DataTable()

        dtInvoiceItem = AddInvoiceItems(InvoiceItems)
        Session("dtInvoiceItem") = dtInvoiceItem

        grdInvoiceItems.DataSource = dtInvoiceItem
        grdInvoiceItems.DataBind()

        If Convert.ToDouble(lblAllocationRemaining.Text) = 0 Then
            btnSubmitProcurement.Enabled = True
            btnAddItemPurchase.Enabled = False
        End If

        ClearAddInvoiceItems()

    End Sub

    Protected Function AddInvoiceItems(ByVal InvoiceItems As clsInvoiceItems) As DataTable

        Dim dtInvoiceItem As DataTable = New DataTable()
        dtInvoiceItem = Session("dtInvoiceItem")

        '' Chq If Item Already Exists

        If ChqItemAlreadyExists(InvoiceItems.ItemID) = 1 Then
            MessageBox("Item Already In The List.")
            Return dtInvoiceItem
        End If

        Dim dr As DataRow
        dr = dtInvoiceItem.NewRow()
        dr("ItemID") = InvoiceItems.ItemID
        dr("ItemName") = InvoiceItems.ItemName
        dr("Quantity") = InvoiceItems.Quantity
        dr("UnitPrice") = InvoiceItems.UnitPrice
        dr("TotalPrice") = Convert.ToDouble(InvoiceItems.Quantity * InvoiceItems.UnitPrice)

        dtInvoiceItem.Rows.Add(dr)
        dtInvoiceItem.AcceptChanges()

        Return dtInvoiceItem

    End Function

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Function ChqItemAlreadyExists(ByVal ItemID As String) As Integer

        Dim dtInvoiceItem As DataTable = New DataTable()
        dtInvoiceItem = Session("dtInvoiceItem")

        Dim IsExists As Boolean = False
        Dim ExistingItemID As String = ""

        For Each rw As DataRow In dtInvoiceItem.Rows
            ExistingItemID = rw.Item("ItemID")

            If ExistingItemID = ItemID Then
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

    Protected Sub btnSubmitProcurement_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmitProcurement.Click

        Dim lblItemID, lblQuantity, lblUnitPrice As New System.Web.UI.WebControls.Label()
        Dim InvoiceItemList As String = ""

        For Each rw As GridViewRow In grdInvoiceItems.Rows
            lblItemID = rw.FindControl("lblItemID")
            lblQuantity = rw.FindControl("lblQuantity")
            lblUnitPrice = rw.FindControl("lblUnitPrice")

            InvoiceItemList += lblItemID.Text & "~" & lblQuantity.Text & "~" & Convert.ToDouble(lblUnitPrice.Text).ToString() & "~|"
        Next

        Dim InvoiceItems As New clsInvoiceItems()

        InvoiceItems.InvoiceID = hdFldInvoiceID.Value
        InvoiceItems.InvoiceItemList = InvoiceItemList
        InvoiceItems.EntryBy = Session("LoginUserID")

        Dim Check As Integer = InvoiceItemData.fnInsertMultipleInvoiceItems(InvoiceItems)

        If Check = 1 Then
            MessageBox("Submitted Successfully.")
            ClearProcurementForm()
        Else
            MessageBox("Error Found.")
        End If

    End Sub

    Protected Sub ClearProcurementForm()

        grdInvoiceSelection.SelectedIndex = -1
        ShowInvoiceDetails()
        lblAllocationRemaining.Text = "0"
        lblFrmInvoiceNo.Text = "N\A"
        lblItemBalance.Text = "N\A"
        lblPurchaseDate.Text = "N\A"
        lblSupplier.Text = "N\A"
        lblTotalCost.Text = "0"

        btnAddItemPurchase.Enabled = False
        btnSubmitProcurement.Enabled = False

        ClearAddInvoiceItems()

        grdInvoiceItems.DataSource = ""
        grdInvoiceItems.DataBind()

    End Sub

    Protected Sub grdInvoiceItems_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdInvoiceItems.RowDataBound
        Try
            Dim lblQuantity, lblUnitPrice As New System.Web.UI.WebControls.Label()

            If e.Row.RowType = DataControlRowType.DataRow Then

                lblQuantity = e.Row.FindControl("lblQuantity")
                lblUnitPrice = e.Row.FindControl("lblUnitPrice")

                TotalCost += (Convert.ToDouble(lblQuantity.Text) * Convert.ToDouble(lblUnitPrice.Text))
            End If

            If e.Row.RowType = DataControlRowType.Footer Then
                e.Row.Cells(4).Text = " Total : "
                e.Row.Cells(5).Text = String.Format("{0:N2}", TotalCost)
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

    End Sub

    Protected Sub grdInvoiceItems_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles grdInvoiceItems.RowDeleting
        Dim i As Integer
        Dim dtInvoiceItem As DataTable = New DataTable()
        Dim ItemQuantity As Integer = 0
        Dim ItemUnitPrice As Double = 0

        dtInvoiceItem = Session("dtInvoiceItem")

        i = e.RowIndex

        ItemQuantity = dtInvoiceItem.Rows(i).Item("Quantity")
        ItemUnitPrice = dtInvoiceItem.Rows(i).Item("UnitPrice")

        InvoiceCostRemaining += Convert.ToDouble(ItemQuantity * ItemUnitPrice)

        lblAllocationRemaining.Text = InvoiceCostRemaining

        If Convert.ToDouble(lblAllocationRemaining.Text) = 0 Then
            btnAddItemPurchase.Enabled = False
            btnSubmitProcurement.Enabled = True
        Else
            btnAddItemPurchase.Enabled = True
            btnSubmitProcurement.Enabled = False
        End If

        dtInvoiceItem.Rows(i).Delete()
        dtInvoiceItem.AcceptChanges()

        Session("dtInvoiceItem") = dtInvoiceItem

        grdInvoiceItems.DataSource = dtInvoiceItem
        grdInvoiceItems.DataBind()

    End Sub

End Class

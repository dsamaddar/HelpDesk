Imports System
Imports System.Data
Imports System.Data.SqlClient

Partial Class Requisition_frmRequisition
    Inherits System.Web.UI.Page


    Dim ItemData As New clsItemDataAccess()
    Dim ItemRequisitionData As New clsItemRequisitionDataAccess()
    Dim WarehouseItemData As New clsWarehouseItemDataAccess()

    Protected Function FormatItemRequisition() As DataTable
        Dim dt As DataTable = New DataTable()
        dt.Columns.Add("ItemID", System.Type.GetType("System.String"))
        dt.Columns.Add("ItemName", System.Type.GetType("System.String"))
        dt.Columns.Add("Quantity", System.Type.GetType("System.Decimal"))
        dt.Columns.Add("Remarks", System.Type.GetType("System.String"))
        Return dt
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "ItmReq~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then

            Session("dtItemRequisition") = ""
            btnSubmit.Enabled = False

            Dim dtItemRequisition As DataTable = New DataTable()
            dtItemRequisition = FormatItemRequisition()
            Session("dtItemRequisition") = dtItemRequisition

            ShowItemList()

        End If
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

    Protected Sub ShowItemBalance(ByVal ItemID As String)
        lblItemBalance.Text = WarehouseItemData.fnGetItemBalanceByItem(ItemID).ToString()
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Function AddItemRequisition(ByVal ItemRequisition As clsItemRequisition) As DataTable

        Dim dtItemRequisition As DataTable = New DataTable()
        dtItemRequisition = Session("dtItemRequisition")

        '' Chq If Item Already Exists

        If ChqItemAlreadyExists(ItemRequisition.ItemID) = 1 Then
            MessageBox("Item Already In The List.")
            Return dtItemRequisition
        End If

        Dim dr As DataRow
        dr = dtItemRequisition.NewRow()
        dr("ItemID") = ItemRequisition.ItemID
        dr("ItemName") = ItemRequisition.ItemName
        dr("Quantity") = ItemRequisition.Quantity
        dr("Remarks") = ItemRequisition.Remarks

        dtItemRequisition.Rows.Add(dr)
        dtItemRequisition.AcceptChanges()
        btnSubmit.Enabled = True
        Return dtItemRequisition

    End Function

    Protected Function ChqItemAlreadyExists(ByVal ItemID As String) As Integer

        Dim dtItemRequisition As DataTable = New DataTable()
        dtItemRequisition = Session("dtItemRequisition")

        Dim IsExists As Boolean = False
        Dim ExistingItemID As String = ""

        For Each rw As DataRow In dtItemRequisition.Rows
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

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click

        Dim ItemRequisitionInfo As New clsItemRequisition()

        Dim RequisitionItemList As String = ""

        Dim lblItemID, lblQuantity, lblRemarks As New System.Web.UI.WebControls.Label()
        For Each rw As GridViewRow In grdRequisitionList.Rows
            lblItemID = rw.FindControl("lblItemID")
            lblQuantity = rw.FindControl("lblQuantity")
            lblRemarks = rw.FindControl("lblRemarks")

            RequisitionItemList += lblItemID.Text & "~" & lblQuantity.Text & "~" & lblRemarks.Text & "~|"
        Next

        ItemRequisitionInfo.EmployeeID = Session("EmployeeID")
        ItemRequisitionInfo.RequisitionItemList = RequisitionItemList
        ItemRequisitionInfo.EntryBy = Session("LoginUserID")

        Dim Check As Integer = ItemRequisitionData.fnInsertMultipleRequisition(ItemRequisitionInfo)

        If Check = 1 Then
            MessageBox("Requisition Submitted.")
            ClearSubmission()
        Else
            MessageBox("Error Found.")
        End If

    End Sub

    Protected Sub ClearSubmission()

        drpItemList.SelectedIndex = -1
        txtQuantity.Text = ""
        txtItemRequisitionRemarks.Text = ""

        grdRequisitionList.DataSource = ""
        grdRequisitionList.DataBind()

        btnSubmit.Enabled = False

    End Sub

    Protected Sub ClearItemRequisition()
        drpItemList.SelectedIndex = -1
        txtQuantity.Text = ""
        txtItemRequisitionRemarks.Text = ""
    End Sub

    Protected Sub btnAddRequisition_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddRequisition.Click

        If drpItemList.SelectedValue = "N\A" Then
            MessageBox("Select An Item First.")
            Exit Sub
        End If

        Dim ItemRequisition As New clsItemRequisition()

        ItemRequisition.ItemID = drpItemList.SelectedValue
        ItemRequisition.ItemName = drpItemList.SelectedItem.ToString()
        ItemRequisition.Quantity = txtQuantity.Text
        ItemRequisition.Remarks = If(txtItemRequisitionRemarks.Text = "", "", txtItemRequisitionRemarks.Text)

        Dim dtItemRequisition As DataTable = New DataTable()

        dtItemRequisition = AddItemRequisition(ItemRequisition)
        Session("dtItemRequisition") = dtItemRequisition

        grdRequisitionList.DataSource = dtItemRequisition
        grdRequisitionList.DataBind()

        ClearItemRequisition()

        If grdRequisitionList.Rows.Count > 0 Then
            btnSubmit.Enabled = True
        Else
            btnSubmit.Enabled = False
        End If

    End Sub

    Protected Sub grdRequisitionList_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles grdRequisitionList.RowDeleting

        Dim i As Integer
        Dim dtItemRequisition As DataTable = New DataTable()

        dtItemRequisition = Session("dtItemRequisition")

        i = e.RowIndex

        dtItemRequisition.Rows(i).Delete()
        dtItemRequisition.AcceptChanges()

        Session("dtItemRequisition") = dtItemRequisition

        grdRequisitionList.DataSource = dtItemRequisition
        grdRequisitionList.DataBind()

        If grdRequisitionList.Rows.Count > 0 Then
            btnSubmit.Enabled = True
        Else
            btnSubmit.Enabled = False
        End If


    End Sub

    Protected Sub drpItemList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpItemList.SelectedIndexChanged
        ShowItemBalance(drpItemList.SelectedValue)
    End Sub

End Class

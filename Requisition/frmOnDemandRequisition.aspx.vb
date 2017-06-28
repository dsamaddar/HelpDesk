Imports System
Imports System.Data
Imports System.Data.SqlClient

Partial Class Requisition_frmOnDemandRequisition
    Inherits System.Web.UI.Page

    Dim ItemData As New clsItemDataAccess()
    'Dim UserData As New clsUserDataAccess()
    Dim EmpData As New clsEmployeeInfoDataAccess()
    Dim WarehouseItemData As New clsWarehouseItemDataAccess()
    Dim ItemRequisitionData As New clsItemRequisitionDataAccess()

    Protected Function FormatItemRequisition() As DataTable
        Dim dt As DataTable = New DataTable()
        dt.Columns.Add("ItemID", System.Type.GetType("System.String"))
        dt.Columns.Add("ItemName", System.Type.GetType("System.String"))
        dt.Columns.Add("Quantity", System.Type.GetType("System.Decimal"))
        dt.Columns.Add("Remarks", System.Type.GetType("System.String"))
        dt.Columns.Add("EmployeeID", System.Type.GetType("System.String"))
        dt.Columns.Add("RequisitionFor", System.Type.GetType("System.String"))
        Return dt
    End Function

    Protected Sub btnAddRequisition_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddRequisition.Click

        If drpItemList.SelectedValue = "N\A" Or drpUserList.SelectedValue = "N\A" Then
            MessageBox("Select Proper Item And User.")
            Exit Sub
        End If

        Dim ItemRequisition As New clsItemRequisition()

        ItemRequisition.ItemID = drpItemList.SelectedValue
        ItemRequisition.ItemName = drpItemList.SelectedItem.ToString()
        ItemRequisition.Quantity = txtQuantity.Text
        ItemRequisition.Remarks = txtItemRequisitionRemarks.Text
        ItemRequisition.EmployeeID = drpUserList.SelectedValue
        ItemRequisition.RequisitionFor = drpUserList.SelectedItem.Text

        Dim dtOnDemandItemRequisition As DataTable = New DataTable()
        dtOnDemandItemRequisition = AddItemRequisition(ItemRequisition)
        Session("dtOnDemandItemRequisition") = dtOnDemandItemRequisition

        grdRequisitionList.DataSource = dtOnDemandItemRequisition
        grdRequisitionList.DataBind()

        ClearRequisitionForm()

    End Sub

    Protected Sub ClearRequisitionForm()
        drpItemList.SelectedIndex = -1
        txtQuantity.Text = ""
        txtItemRequisitionRemarks.Text = ""
        lblItemBalance.Text = "0"
        drpUserList.SelectedIndex = -1
    End Sub

    Protected Function AddItemRequisition(ByVal ItemRequisition As clsItemRequisition) As DataTable

        Dim dtOnDemandItemRequisition As DataTable = New DataTable()
        dtOnDemandItemRequisition = Session("dtOnDemandItemRequisition")

        '' Chq If Item Already Exists
        If ChqItemAlreadyExists(ItemRequisition.ItemID) = 1 Then
            MessageBox("Item Already In The List.")
            Return dtOnDemandItemRequisition
        End If

        Dim dr As DataRow
        dr = dtOnDemandItemRequisition.NewRow()
        dr("ItemID") = ItemRequisition.ItemID
        dr("ItemName") = ItemRequisition.ItemName
        dr("Quantity") = ItemRequisition.Quantity
        dr("Remarks") = ItemRequisition.Remarks
        dr("EmployeeID") = ItemRequisition.EmployeeID
        dr("RequisitionFor") = ItemRequisition.RequisitionFor

        dtOnDemandItemRequisition.Rows.Add(dr)
        dtOnDemandItemRequisition.AcceptChanges()
        btnSubmit.Enabled = True
        Return dtOnDemandItemRequisition

    End Function

    Protected Function ChqItemAlreadyExists(ByVal ItemID As String) As Integer

        Dim dtOnDemandItemRequisition As DataTable = New DataTable()
        dtOnDemandItemRequisition = Session("dtOnDemandItemRequisition")

        Dim IsExists As Boolean = False
        Dim ExistingItemID As String = ""

        For Each rw As DataRow In dtOnDemandItemRequisition.Rows
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

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub ShowUserList()
        drpUserList.DataTextField = "EmployeeName"
        drpUserList.DataValueField = "EmployeeID"
        drpUserList.DataSource = EmpData.fnGetActiveEmpList()
        drpUserList.DataBind()

        Dim A As New ListItem()

        A.Text = "N\A"
        A.Value = "N\A"

        drpUserList.Items.Insert(0, A)
    End Sub

    Protected Sub ShowItemBalance(ByVal ItemID As String)
        lblItemBalance.Text = WarehouseItemData.fnGetItemBalanceByItem(ItemID).ToString()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "OnDemandReq~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then

            ShowItemList()
            ShowUserList()

            Session("dtOnDemandItemRequisition") = ""
            btnSubmit.Enabled = False

            Dim dtOnDemandItemRequisition As DataTable = New DataTable()
            dtOnDemandItemRequisition = FormatItemRequisition()
            Session("dtOnDemandItemRequisition") = dtOnDemandItemRequisition



        End If
    End Sub

    Protected Sub drpItemList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpItemList.SelectedIndexChanged
        ShowItemBalance(drpItemList.SelectedValue)
    End Sub

    Protected Sub grdRequisitionList_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles grdRequisitionList.RowDeleting
        Dim i As Integer
        Dim dtOnDemandItemRequisition As DataTable = New DataTable()

        dtOnDemandItemRequisition = Session("dtOnDemandItemRequisition")

        i = e.RowIndex

        dtOnDemandItemRequisition.Rows(i).Delete()
        dtOnDemandItemRequisition.AcceptChanges()

        Session("dtOnDemandItemRequisition") = dtOnDemandItemRequisition

        grdRequisitionList.DataSource = dtOnDemandItemRequisition
        grdRequisitionList.DataBind()

        If grdRequisitionList.Rows.Count > 0 Then
            btnSubmit.Enabled = True
        Else
            btnSubmit.Enabled = False
        End If
    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Dim ItemRequisitionInfo As New clsItemRequisition()

        Dim RequisitionItemList As String = ""

        Dim lblItemID, lblQuantity, lblRemarks, lblEmployeeID As New System.Web.UI.WebControls.Label()
        For Each rw As GridViewRow In grdRequisitionList.Rows
            lblItemID = rw.FindControl("lblItemID")
            lblQuantity = rw.FindControl("lblQuantity")
            lblRemarks = rw.FindControl("lblRemarks")
            lblEmployeeID = rw.FindControl("lblEmployeeID")

            RequisitionItemList += lblItemID.Text & "~" & lblQuantity.Text & "~" & lblRemarks.Text & "~" & lblEmployeeID.Text & "~|"
        Next

        ItemRequisitionInfo.RequisitionItemList = RequisitionItemList
        ItemRequisitionInfo.EntryBy = Session("LoginUserID")

        Dim Check As Integer = ItemRequisitionData.fnInsertMultipleOnDemandReq(ItemRequisitionInfo)

        If Check = 1 Then
            MessageBox("Requisition Submitted.")
            ClearRequisitionForm()
            ClearSubmission()
        Else
            MessageBox("Error Found.")
        End If
    End Sub

    Protected Sub ClearSubmission()
        grdRequisitionList.DataSource = ""
        grdRequisitionList.DataBind()

        btnSubmit.Enabled = False
        Session("dtOnDemandItemRequisition") = ""
    End Sub



End Class

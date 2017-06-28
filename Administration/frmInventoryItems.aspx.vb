
Partial Class Administration_frmInventoryItems
    Inherits System.Web.UI.Page

    Dim UnitTypeData As New clsUnitTypeDataAccess()
    Dim ItemData As New clsItemDataAccess()

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub ShowUnitTypeList()
        drpUnitType.DataTextField = "UnitType"
        drpUnitType.DataValueField = "UnitTypeID"
        drpUnitType.DataSource = UnitTypeData.fnGetUnitTypeList()
        drpUnitType.DataBind()
    End Sub

    Protected Sub GetInventoryItemDetails()
        grdAvailableItems.DataSource = ItemData.fnGetItemListDetails()
        grdAvailableItems.DataBind()
    End Sub

    Protected Sub btnCancelInputItemType_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelInputItemType.Click
        ClearItemInput()
    End Sub

    Protected Sub ClearItemInput()
        txtItemCode.Text = ""
        txtItemName.Text = ""
        txtLowBalanceReport.Text = ""
        txtMaxRequisition.Text = "10000"
        drpUnitType.SelectedIndex = -1
        chkItemIsActive.Checked = False

        grdAvailableItems.SelectedIndex = -1

        btnAddItem.Visible = True
        btnUpdateInventoryItems.Visible = False
        hdFldItemID.Value = ""
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "MngItm~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then
            ShowUnitTypeList()
            btnUpdateInventoryItems.Visible = False
            GetInventoryItemDetails()
        End If
    End Sub

    Protected Sub btnUpdateInventoryItems_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateInventoryItems.Click

        Dim Items As New clsItems()
        Try
            Items.ItemID = hdFldItemID.Value
            Items.ItemName = txtItemName.Text
            Items.ItemCode = txtItemCode.Text
            Items.LowBalanceReport = txtLowBalanceReport.Text
            Items.MaxAllowableRequisition = txtMaxRequisition.Text
            Items.UnitTypeID = drpUnitType.SelectedValue
            If chkItemIsActive.Checked = True Then
                Items.IsActive = True
            Else
                Items.IsActive = False
            End If

            Items.EntryBy = Session("LoginUserID")

            Dim Check As Integer = ItemData.fnUpdateInventoryItems(Items)

            If Check = 1 Then
                MessageBox("Item Updated Successfully.")
                GetInventoryItemDetails()
                ClearItemInput()
            Else
                MessageBox("Error Found.")
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

    End Sub

    Protected Sub grdAvailableItems_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdAvailableItems.SelectedIndexChanged

        grdAvailableItems.Focus()
        btnAddItem.Visible = False
        btnUpdateInventoryItems.Visible = True

        Dim lblItemID As New System.Web.UI.WebControls.Label()
        Dim lblItemName As New System.Web.UI.WebControls.Label()
        Dim lblItemCode As New System.Web.UI.WebControls.Label()
        Dim lblUnitTypeID As New System.Web.UI.WebControls.Label()
        Dim lblLowBalanceReport As New System.Web.UI.WebControls.Label()
        Dim lblMaxAllowableRequisition As New System.Web.UI.WebControls.Label()
        Dim lblIsActive As New System.Web.UI.WebControls.Label()

        lblItemID = grdAvailableItems.SelectedRow.FindControl("lblItemID")
        lblItemName = grdAvailableItems.SelectedRow.FindControl("lblItemName")
        lblItemCode = grdAvailableItems.SelectedRow.FindControl("lblItemCode")
        lblUnitTypeID = grdAvailableItems.SelectedRow.FindControl("lblUnitTypeID")
        lblLowBalanceReport = grdAvailableItems.SelectedRow.FindControl("lblLowBalanceReport")
        lblMaxAllowableRequisition = grdAvailableItems.SelectedRow.FindControl("lblMaxAllowableRequisition")
        lblIsActive = grdAvailableItems.SelectedRow.FindControl("lblIsActive")

        hdFldItemID.Value = lblItemID.Text
        txtItemName.Text = lblItemName.Text
        txtItemCode.Text = lblItemCode.Text
        drpUnitType.SelectedValue = lblUnitTypeID.Text
        txtLowBalanceReport.Text = lblLowBalanceReport.Text
        txtMaxRequisition.Text = lblMaxAllowableRequisition.Text

        If lblIsActive.Text = "Active" Then
            chkItemIsActive.Checked = True
        Else
            chkItemIsActive.Checked = False
        End If

    End Sub

    Protected Sub btnAddItem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddItem.Click
        Dim Items As New clsItems()

        Try
            Items.ItemName = txtItemName.Text
            Items.ItemCode = txtItemCode.Text
            Items.LowBalanceReport = txtLowBalanceReport.Text
            Items.MaxAllowableRequisition = txtMaxRequisition.Text
            Items.UnitTypeID = drpUnitType.SelectedValue
            If chkItemIsActive.Checked = True Then
                Items.IsActive = True
            Else
                Items.IsActive = False
            End If

            Items.EntryBy = Session("LoginUserID")

            Dim Check As Integer = ItemData.fnInsertInventoryItems(Items)

            If Check = 1 Then
                MessageBox("Item Inserted Successfully.")
                GetInventoryItemDetails()
                ClearItemInput()
            Else
                MessageBox("Error Found.")
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
       
    End Sub

End Class

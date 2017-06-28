
Partial Class AcceptRequisition_frmAcceptRequisition
    Inherits System.Web.UI.Page

    Dim DepartmentData As New clsDepartmentDataAccess()
    Dim UserData As New clsUserDataAccess()
    Dim ItemRequisitionData As New clsItemRequisitionDataAccess()
    Dim WarehouseData As New clsWarehouseDataAccess()
    Dim WarehouseItemData As New clsWarehouseItemDataAccess()
    'Dim BranchData As New clsBranchDataAccess()
    Dim ULCBranchData As New clsULCBranchDataAccess()
    Dim ItemData As New clsItemDataAccess()

    Protected Sub btnShowRequisition_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShowRequisition.Click
        ShowRequisitions()
    End Sub

    Protected Sub ShowRequisitions()

        Dim ItemReqInfo As New clsItemRequisition()

        If txtDateFrom.Text <> "" And txtDateTo.Text = "" Then
            MessageBox("Date To Cann't Be Empty.")
            Exit Sub
        End If

        If txtDateFrom.Text = "" And txtDateTo.Text <> "" Then
            MessageBox("Date From Cann't Be Empty.")
            Exit Sub
        End If

        If txtDateFrom.Text = "" Or txtDateTo.Text = "" Then
            ItemReqInfo.DateFrom = "1/1/1900"
            ItemReqInfo.DateTo = "1/1/2099"
        End If

        ItemReqInfo.WarehouseID = drpWareHouseList.SelectedValue
        ItemReqInfo.ULCBranchID = drpBranch.SelectedValue
        ItemReqInfo.DepartmentID = drpDepartment.SelectedValue
        ItemReqInfo.EmployeeID = drpUserList.SelectedValue
        ItemReqInfo.ItemID = drpItemList.SelectedValue

        grdRequisition.DataSource = ItemRequisitionData.fnSearchItemRequisition(ItemReqInfo)
        grdRequisition.DataBind()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "AcptReq~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If


        If Not IsPostBack Then
            GetWarehouseList()
            GetDepartmentList()
            GetBranchList()
            ShowReqRemainingItemList()
            'lblRemarks.Visible = False
            'txtRemarks.Visible = False
            reqFldRejectionRemarks.ValidationGroup = "RejectRequisition"
            ShowRequisitions()
        End If
    End Sub

    Protected Sub GetWarehouseList()
        drpWarehouseList.DataTextField = "WarehouseName"
        drpWarehouseList.DataValueField = "WarehouseID"
        drpWarehouseList.DataSource = WarehouseData.fnGetWarehouseList()
        drpWarehouseList.DataBind()
    End Sub

    Protected Sub GetDepartmentList()
        drpDepartment.DataTextField = "DeptName"
        drpDepartment.DataValueField = "DepartmentID"
        drpDepartment.DataSource = DepartmentData.fnGetReqRemDepartmentList()
        drpDepartment.DataBind()

        Dim A As New ListItem
        A.Value = "N\A"
        A.Text = "N\A"

        drpDepartment.Items.Insert(0, A)

        If drpDepartment.Items.Count > 0 Then
            drpDepartment.SelectedIndex = 0
            ShowUserList(drpDepartment.SelectedValue)
        End If

    End Sub

    Protected Sub ShowUserList(ByVal DepartmentID As String)
        drpUserList.DataTextField = "EmployeeName"
        drpUserList.DataValueField = "EmployeeID"
        drpUserList.DataSource = UserData.fnGetReqRemDeptWiseUser(DepartmentID)
        drpUserList.DataBind()

        Dim A As New ListItem()

        A.Text = "N\A"
        A.Value = "N\A"

        drpUserList.Items.Insert(0, A)
    End Sub

    Protected Sub ShowReqRemainingItemList()

        drpItemList.DataTextField = "ItemName"
        drpItemList.DataValueField = "ItemID"
        drpItemList.DataSource = ItemData.fnGetReqRemItemList()
        drpItemList.DataBind()

        Dim A As New ListItem()

        A.Text = "N\A"
        A.Value = "N\A"

        drpItemList.Items.Insert(0, A)
    End Sub

    Protected Sub GetBranchList()
        drpBranch.DataTextField = "ULCBranchName"
        drpBranch.DataValueField = "ULCBranchID"
        drpBranch.DataSource = ULCBranchData.fnGetULCBranch()
        drpBranch.DataBind()

        Dim A As New ListItem
        A.Value = "N\A"
        A.Text = "N\A"

        drpBranch.Items.Insert(0, A)

    End Sub

    Protected Sub drpDepartment_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpDepartment.SelectedIndexChanged
        ShowUserList(drpDepartment.SelectedValue)
    End Sub

    Protected Sub grdRequisition_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdRequisition.SelectedIndexChanged

        Dim lblEmployeeName, lblItemID, lblReqItemName, lblReqQuantity As New System.Web.UI.WebControls.Label()
        Dim AvailableBalance As Integer = 0

        Try
            lblEmployeeName = grdRequisition.SelectedRow.FindControl("lblEmployeeName")
            lblItemID = grdRequisition.SelectedRow.FindControl("lblItemID")
            lblReqItemName = grdRequisition.SelectedRow.FindControl("lblItemName")
            lblReqQuantity = grdRequisition.SelectedRow.FindControl("lblQuantity")

            lblWarehouseName.Text = drpWareHouseList.SelectedItem.ToString()
            lblUserName.Text = lblEmployeeName.Text
            lblItem.Text = lblReqItemName.Text
            lblRequestedQuantity.Text = lblReqQuantity.Text

            AvailableBalance = WarehouseItemData.fnGetWarehouseItemBalByItem(drpWareHouseList.SelectedValue, lblItemID.Text).ToString()
            lblAvailableBalance.Text = AvailableBalance
            If AvailableBalance < Convert.ToInt32(lblReqQuantity.Text) Then
                lblAvailableBalance.ForeColor = Drawing.Color.Red
                'lblRemarks.Visible = True
                'txtRemarks.Visible = True
                reqFldRejectionRemarks.ValidationGroup = "AcceptRequisition"
            Else
                lblAvailableBalance.ForeColor = Drawing.Color.Green
                'lblRemarks.Visible = False
                'txtRemarks.Visible = False
                reqFldRejectionRemarks.ValidationGroup = "RejectRequisition"
            End If

            If Convert.ToInt32(lblAvailableBalance.Text) >= Convert.ToInt32(lblRequestedQuantity.Text) Then
                txtAppovedQuantity.Text = lblRequestedQuantity.Text
            Else
                txtAppovedQuantity.Text = lblAvailableBalance.Text
            End If

            If Convert.ToInt32(lblAvailableBalance.Text) = 0 Then
                btnAccept.Enabled = False
            Else
                btnAccept.Enabled = True
            End If

            If Convert.ToInt32(lblAvailableBalance.Text) < Convert.ToInt32(lblRequestedQuantity.Text) Then
                txtRemarks.Text = "Delivery of some of your stationary items will be delayed "
            Else
                txtRemarks.Text = ""
            End If

            lnkBtnSelectReq_ModalPopupExtender.Show()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

    End Sub

    Protected Sub btnAccept_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAccept.Click

        Try
            If grdRequisition.SelectedIndex = -1 Then
                MessageBox("Select A Requisition First.")
                Exit Sub
            End If

            If Convert.ToInt32(lblAvailableBalance.Text) = 0 Or Convert.ToInt32(txtAppovedQuantity.Text) = 0 Then
                MessageBox("You Can't Accept This Requisition")
                Exit Sub
            End If

            If Convert.ToInt32(txtAppovedQuantity.Text) > Convert.ToInt32(lblRequestedQuantity.Text) Then
                MessageBox("Approved Quantity Cann't be Greater Than Requested Quantity.")
                Exit Sub
            End If

            Dim lblRequisitionID, lblItemID As New System.Web.UI.WebControls.Label()
            Dim ItemRequisition As New clsItemRequisition()

            lblRequisitionID = grdRequisition.SelectedRow.FindControl("lblRequisitionID")
            lblItemID = grdRequisition.SelectedRow.FindControl("lblItemID")

            ItemRequisition.RequisitionID = lblRequisitionID.Text
            ItemRequisition.WarehouseID = drpWareHouseList.SelectedValue
            ItemRequisition.ItemID = lblItemID.Text
            ItemRequisition.ApprovedQuantity = Convert.ToInt32(txtAppovedQuantity.Text)

            If Convert.ToInt32(lblRequestedQuantity.Text) > Convert.ToInt32(txtAppovedQuantity.Text) Then
                txtRemarks.Text = "Delivery of some of your stationary items will be delayed "
            End If
            ItemRequisition.ApproverRemarks = txtRemarks.Text
            ItemRequisition.EntryBy = Session("LoginUserID")

            Dim Check As Integer = ItemRequisitionData.fnAcceptRequisition(ItemRequisition)

            If Check = 1 Then
                MessageBox("Requisition Accepted.")
                ClearRequisition()
                ShowRequisitions()
            Else
                MessageBox("Error Found.")
            End If

        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
       
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReject.Click

        If grdRequisition.SelectedIndex = -1 Then
            MessageBox("Select A Requisition First.")
            Exit Sub
        End If

        Dim lblRequisitionID As New System.Web.UI.WebControls.Label()
        Dim ItemRequisition As New clsItemRequisition()

        lblRequisitionID = grdRequisition.SelectedRow.FindControl("lblRequisitionID")

        ItemRequisition.RequisitionID = lblRequisitionID.Text
        ItemRequisition.ApproverRemarks = txtRemarks.Text
        ItemRequisition.EntryBy = Session("LoginUserID")

        Dim Check As Integer = ItemRequisitionData.fnRejectRequisition(ItemRequisition)

        If Check = 1 Then
            MessageBox("Requisition Rejected")
            ClearRequisition()
            ShowRequisitions()
        Else
            MessageBox("Error Found.")
        End If
    End Sub

    Protected Sub ClearRequisition()
        grdRequisition.SelectedIndex = -1
        txtAppovedQuantity.Text = ""
        lblAvailableBalance.Text = ""
        lblItem.Text = ""
        lblRequestedQuantity.Text = ""
        lblUserName.Text = ""
        lblWarehouseName.Text = ""
    End Sub

    Protected Sub drpWareHouseList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpWareHouseList.SelectedIndexChanged
        ShowRequisitions()
        ClearRequisition()
    End Sub

    Protected Sub grdRequisition_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdRequisition.RowDataBound

        Dim lblQuantity, lblBalance As New System.Web.UI.WebControls.Label()

        If e.Row.RowType = DataControlRowType.DataRow Then
            lblQuantity = e.Row.FindControl("lblQuantity")
            lblBalance = e.Row.FindControl("lblBalance")

            If Convert.ToInt32(lblBalance.Text) < Convert.ToInt32(lblQuantity.Text) Then
                lblBalance.ForeColor = Drawing.Color.Red
            Else
                lblBalance.ForeColor = Drawing.Color.Green
            End If

            lblBalance.Font.Bold = True
        End If

    End Sub

    Protected Sub btnCancelSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelSearch.Click
        ClearForm()
    End Sub

    Protected Sub ClearForm()
        drpWareHouseList.SelectedIndex = -1

        grdRequisition.DataSource = ""
        grdRequisition.DataBind()

        txtDateFrom.Text = ""
        txtDateTo.Text = ""
        drpBranch.SelectedIndex = -1
        drpDepartment.SelectedIndex = -1
        drpUserList.SelectedIndex = -1
        drpItemList.SelectedIndex = -1
    End Sub

End Class


Partial Class AcceptRequisition_frmAdvAcceptRequisition
    Inherits System.Web.UI.Page

    Dim DepartmentData As New clsDepartmentDataAccess()
    Dim UserData As New clsUserDataAccess()
    Dim ItemRequisitionData As New clsItemRequisitionDataAccess()
    Dim WarehouseData As New clsWarehouseDataAccess()
    Dim WarehouseItemData As New clsWarehouseItemDataAccess()
    'Dim BranchData As New clsBranchDataAccess()
    Dim ULCBranchData As New clsULCBranchDataAccess()
    Dim ItemData As New clsItemDataAccess()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "AdvAcptReq~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If


        If Not IsPostBack Then
            GetWarehouseList()
            GetDepartmentList()
            GetBranchList()
            ShowReqRemainingItemList()
            
            ShowRequisitions()
        End If
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
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

    Protected Sub btnShowRequisition_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShowRequisition.Click
        ShowRequisitions()
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearForm()
    End Sub

    Protected Sub ClearForm()
        drpWareHouseList.SelectedIndex = -1

        grdRequisition.DataSource = ""
        grdRequisition.DataBind()

        txtApproverRemarks.Text = ""
        chkSelectAllRequisition.Checked = False
        chkSelectAllRequisition.Text = "Select All"
        lblWarning.Text = ""

        txtDateFrom.Text = ""
        txtDateTo.Text = ""
        drpBranch.SelectedIndex = -1
        drpDepartment.SelectedIndex = -1
        drpUserList.SelectedIndex = -1
        drpItemList.SelectedIndex = -1
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

    Protected Sub btnAcceptRequisition_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAcceptRequisition.Click

        Dim IsSelected As Boolean = False
        Dim lblRequisitionID As Label
        Dim chkSelectRequisition As New CheckBox
        For Each rw As GridViewRow In grdRequisition.Rows
            chkSelectRequisition = rw.FindControl("chkSelectRequisition")
            If chkSelectRequisition.Checked = True Then
                IsSelected = True
                Exit For
            End If
        Next

        If IsSelected = False Then
            MessageBox("Select At Lease One Requisition To Accept.")
            Exit Sub
        End If

        Dim RequisitionIDList As String = ""
        Dim ItemRequisition As New clsItemRequisition()

        For Each rw As GridViewRow In grdRequisition.Rows
            chkSelectRequisition = rw.FindControl("chkSelectRequisition")
            If chkSelectRequisition.Checked = True Then
                lblRequisitionID = rw.FindControl("lblRequisitionID")
                RequisitionIDList = RequisitionIDList & lblRequisitionID.Text & "~|"
            End If
        Next

        If drpWareHouseList.SelectedValue = "N\A" Then
            MessageBox("Select a Warehouse first.")
            Exit Sub
        End If

        If RequisitionIDList <> "" Then
            ItemRequisition.RequisitionIDList = RequisitionIDList
            ItemRequisition.WarehouseID = drpWareHouseList.SelectedValue
            ItemRequisition.ApproverRemarks = txtApproverRemarks.Text
            ItemRequisition.EntryBy = Session("LoginUserID")

            Dim Check As Integer = ItemRequisitionData.fnAdvAcceptRequisition(ItemRequisition)

            If Check = 1 Then
                MessageBox("Requisition Accepted.")
                ClearForm()
                ShowRequisitions()
            Else
                MessageBox("Error Found.")
            End If
        End If

    End Sub

    Protected Sub chkSelectRequisition_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim lblQuantity, lblBalance As New System.Web.UI.WebControls.Label()
        Dim chkSelectRequisition As CheckBox


        For Each rw As GridViewRow In grdRequisition.Rows
            lblQuantity = rw.FindControl("lblQuantity")
            lblBalance = rw.FindControl("lblBalance")
            chkSelectRequisition = rw.FindControl("chkSelectRequisition")

            If chkSelectRequisition.Checked = True Then
                If Convert.ToInt32(lblBalance.Text) < Convert.ToInt32(lblQuantity.Text) Then
                    chkSelectRequisition.Checked = False
                    lblWarning.Text = "Requisition Can't Be Selected Due to Low Balance"
                Else
                    chkSelectAllRequisition.Checked = False
                    chkSelectAllRequisition.Text = "Select All"
                End If
            Else

            End If

        Next

    End Sub

    Protected Sub chkSelectAllRequisition_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkSelectAllRequisition.CheckedChanged
        Dim lblQuantity, lblBalance As New System.Web.UI.WebControls.Label()
        Dim chkSelectRequisition As CheckBox

        If chkSelectAllRequisition.Checked = True Then
            For Each rw As GridViewRow In grdRequisition.Rows
                lblQuantity = rw.FindControl("lblQuantity")
                lblBalance = rw.FindControl("lblBalance")
                chkSelectRequisition = rw.FindControl("chkSelectRequisition")
                If Convert.ToInt32(lblBalance.Text) < Convert.ToInt32(lblQuantity.Text) Then
                    chkSelectRequisition.Checked = False
                    lblWarning.Text = "All Items Cann't Selected."
                Else
                    chkSelectRequisition.Checked = True
                End If
            Next
            chkSelectAllRequisition.Text = "De Select All"
        Else

            For Each rw As GridViewRow In grdRequisition.Rows
                chkSelectRequisition = rw.FindControl("chkSelectRequisition")
                chkSelectRequisition.Checked = False
                lblWarning.Text = ""
            Next

            chkSelectAllRequisition.Text = "Select All"

        End If

        

    End Sub

End Class

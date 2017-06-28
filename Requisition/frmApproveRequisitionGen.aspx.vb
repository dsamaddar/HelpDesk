
Partial Class Requisition_frmApproveRequisitionGen
    Inherits System.Web.UI.Page

    Dim ItemRequisitionData As New clsItemRequisitionDataAccess()
    Dim DepartmentData As New clsDepartmentDataAccess()
    Dim UserData As New clsUserDataAccess()
    'Dim BranchData As New clsBranchDataAccess()
    Dim ULCBranchData As New clsULCBranchDataAccess()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'Dim MenuIDs As String

        'MenuIDs = Session("PermittedMenus")

        'If InStr(MenuIDs, "AppReq~") = 0 Then
        '    Response.Redirect("~\frmAILogin.aspx")
        'End If

        If Not IsPostBack Then
            ShowReqForDeptApproval()
            GetDepartmentList()
            GetBranchList()
        End If
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub ShowReqForDeptApproval()

        Dim ItemReqInfo As New clsItemRequisition()
        If txtDateFrom.Text <> "" And txtDateTo.Text = "" Then
            MessageBox("Date To Cann't Be Empty.")
            Exit Sub
        ElseIf txtDateFrom.Text = "" And txtDateTo.Text <> "" Then
            MessageBox("Date From Cann't Be Empty.")
            Exit Sub
        ElseIf txtDateFrom.Text = "" Or txtDateTo.Text = "" Then
            ItemReqInfo.DateFrom = "1/1/1900"
            ItemReqInfo.DateTo = "1/1/2099"
        Else

        End If

        ItemReqInfo.ULCBranchID = drpBranch.SelectedValue
        ItemReqInfo.DepartmentID = drpDepartment.SelectedValue
        ItemReqInfo.SupervisorID = Session("EmployeeID")
        grdReqDeptApproval.DataSource = ItemRequisitionData.fnItmReqForDeptApproval(ItemReqInfo)
        grdReqDeptApproval.DataBind()
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

    Protected Sub btnApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApprove.Click

        Dim chkSelectRequisition As New System.Web.UI.WebControls.CheckBox
        Dim lblRequisitionID As New System.Web.UI.WebControls.Label
        Dim ItemRequisition As New clsItemRequisition()

        Dim RequisitionIDList As String = ""
        For Each rw As GridViewRow In grdReqDeptApproval.Rows
            chkSelectRequisition = rw.FindControl("chkSelectRequisition")
            If chkSelectRequisition.Checked = True Then
                lblRequisitionID = rw.FindControl("lblRequisitionID")
                RequisitionIDList += lblRequisitionID.Text + ","
            End If
        Next

        If RequisitionIDList <> "" Then
            RequisitionIDList = RequisitionIDList.Remove(Len(RequisitionIDList) - 1, 1)
        Else
            MessageBox("Select Requisition Request From The List.")
            Exit Sub
        End If

        ItemRequisition.RequisitionIDList = RequisitionIDList
        ItemRequisition.EntryBy = Session("LoginUserID")

        Dim Check As Integer = ItemRequisitionData.fnReqDeptApproval(ItemRequisition)

        If Check = 1 Then
            MessageBox("Approved.")
            ShowReqForDeptApproval()
            txtRemarks.Text = ""
        Else
            MessageBox("Error Found in Approval.")
        End If

    End Sub

    Protected Sub btnReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReject.Click
        Dim chkSelectRequisition As New System.Web.UI.WebControls.CheckBox
        Dim lblRequisitionID As New System.Web.UI.WebControls.Label
        Dim ItemRequisition As New clsItemRequisition()

        Dim RequisitionIDList As String = ""
        For Each rw As GridViewRow In grdReqDeptApproval.Rows
            chkSelectRequisition = rw.FindControl("chkSelectRequisition")
            If chkSelectRequisition.Checked = True Then
                lblRequisitionID = rw.FindControl("lblRequisitionID")
                RequisitionIDList += lblRequisitionID.Text + ","
            End If
        Next

        If RequisitionIDList <> "" Then
            RequisitionIDList = RequisitionIDList.Remove(Len(RequisitionIDList) - 1, 1)
        Else
            MessageBox("Select Requisition Request From The List.")
            Exit Sub
        End If

        ItemRequisition.RequisitionIDList = RequisitionIDList
        ItemRequisition.ApproverRemarks = txtRemarks.Text
        ItemRequisition.EntryBy = Session("LoginUserID")

        Dim Check As Integer = ItemRequisitionData.fnReqDeptRejection(ItemRequisition)

        If Check = 1 Then
            MessageBox("Requisition Rejected.")
            ShowReqForDeptApproval()
            txtRemarks.Text = ""
        Else
            MessageBox("Error Found in Rejection.")
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearForm()
    End Sub

    Protected Sub ClearForm()
        Dim chkSelectRequisition As New System.Web.UI.WebControls.CheckBox
        For Each rw As GridViewRow In grdReqDeptApproval.Rows
            chkSelectRequisition = rw.FindControl("chkSelectRequisition")
            If chkSelectRequisition.Checked = True Then
                chkSelectRequisition.Checked = False
            End If
        Next

        txtRemarks.Text = ""

    End Sub

    Protected Sub drpDepartment_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpDepartment.SelectedIndexChanged
        ShowUserList(drpDepartment.SelectedValue)
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

    Protected Sub btnShowRequisition_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShowRequisition.Click
        ShowReqForDeptApproval()
    End Sub

End Class

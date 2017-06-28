
Partial Class AcceptRequisition_frmDeliverRequisition
    Inherits System.Web.UI.Page

    Dim ItemRequisitionData As New clsItemRequisitionDataAccess()
    Dim DepartmentData As New clsDepartmentDataAccess()
    Dim UserData As New clsUserDataAccess()
    'Dim EmpData As New clsEmployeeInfoDataAccess()
    'Dim BranchData As New clsBranchDataAccess()
    Dim ULCBranchData As New clsULCBranchDataAccess()

    Protected Sub btnShowRequisition_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShowRequisition.Click
        GetPendingReqListToDeliver()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "DelReq~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then
            GetDepartmentList()
            GetBranchList()
            GetPendingReqListToDeliver()
        End If
    End Sub

    Protected Sub GetPendingReqListToDeliver()
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

        ItemReqInfo.ULCBranchID = drpBranch.SelectedValue
        ItemReqInfo.DepartmentID = drpDepartment.SelectedValue
        grdPendingReqListToDeliver.DataSource = ItemRequisitionData.fnGetPendingReqListToDeliver(ItemReqInfo)
        grdPendingReqListToDeliver.DataBind()

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

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
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

    Protected Sub drpDepartment_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpDepartment.SelectedIndexChanged
        ShowUserList(drpDepartment.SelectedValue)
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click

    End Sub

    Protected Sub btnDeliver_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDeliver.Click
        Dim chkSelectRequisition As New System.Web.UI.WebControls.CheckBox
        Dim lblRequisitionID As New System.Web.UI.WebControls.Label
        Dim ItemRequisition As New clsItemRequisition()

        Dim RequisitionIDList As String = ""
        For Each rw As GridViewRow In grdPendingReqListToDeliver.Rows
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
        ItemRequisition.DeliveredBy = Session("LoginUserID")

        Dim Check As Integer = ItemRequisitionData.fnDeliverRequisition(ItemRequisition)

        If Check = 1 Then
            MessageBox("Your Are requested To Deliver The Items.")
            GetPendingReqListToDeliver()
        Else
            MessageBox("Error Found.")
        End If

    End Sub

    Protected Sub chkSelectAll_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim chk As New CheckBox
        Dim chkAll As New CheckBox

        chkAll = grdPendingReqListToDeliver.HeaderRow.FindControl("chkSelectAll")

        If chkAll.Checked = True Then
            For Each rw As GridViewRow In grdPendingReqListToDeliver.Rows
                chk = rw.FindControl("chkSelectRequisition")
                chk.Checked = True
            Next
            chkAll.Text = "Deselect All"
        Else
            For Each rw As GridViewRow In grdPendingReqListToDeliver.Rows
                chk = rw.FindControl("chkSelectRequisition")
                chk.Checked = False
            Next
            chkAll.Text = "Select All"
        End If


        
    End Sub
End Class

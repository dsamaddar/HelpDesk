
Partial Class Administration_frmCreateDepartment
    Inherits System.Web.UI.Page

    Dim UserData As New clsUserDataAccess()
    Dim DepartmentData As New clsDepartmentDataAccess()

    Protected Sub btnAddDept_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddDept.Click

        Dim DepartmentInfo As New clsDepartment()

        DepartmentInfo.DepartmentName = txtDeptName.Text
        DepartmentInfo.DeptCode = txtDeptCode.Text
        DepartmentInfo.HODID = drpDeptHead.SelectedValue
        DepartmentInfo.DeptMailAddress = txtDeptMailAddress.Text

        If chkDeptIsActive.Checked = True Then
            DepartmentInfo.IsActive = True
        Else
            DepartmentInfo.IsActive = False
        End If

        DepartmentInfo.EntryBy = Session("LoginUserID")

        Dim Check As Integer = DepartmentData.fnInsertDepartment(DepartmentInfo)

        If Check = 1 Then
            MessageBox("Department Inserted Successfully.")
            ClearDeptInputForm()
            ShowDetailsDepartmentList()
        Else
            MessageBox("Error Found.")
        End If

    End Sub

    Protected Sub ClearDeptInputForm()
        txtDeptName.Text = ""
        txtDeptCode.Text = ""
        drpDeptHead.SelectedIndex = -1
        txtDeptMailAddress.Text = ""
        chkDeptIsActive.Checked = False

        btnAddDept.Visible = True
        btnUpdateDepartment.Visible = False
        hdFldDepartmentID.Value = ""
        grdAvailableDept.SelectedIndex = -1
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "DeptDef~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then
            ShowUserList()
            ShowDetailsDepartmentList()
            btnAddDept.Visible = True
            btnUpdateDepartment.Visible = False
        End If
    End Sub

    Protected Sub ShowUserList()
        drpDeptHead.DataTextField = "UserName"
        drpDeptHead.DataValueField = "UniqueUserID"
        drpDeptHead.DataSource = UserData.fnShowUserList()
        drpDeptHead.DataBind()

        Dim A As New ListItem()

        A.Text = "N\A"
        A.Value = "N\A"

        drpDeptHead.Items.Insert(0, A)
    End Sub

    Protected Sub ShowDetailsDepartmentList()
        grdAvailableDept.DataSource = DepartmentData.fnGetDetailsDepartmentList()
        grdAvailableDept.DataBind()
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearDeptInputForm()
    End Sub

    Protected Sub btnUpdateDepartment_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateDepartment.Click
        Dim DepartmentInfo As New clsDepartment()

        DepartmentInfo.DepartmentID = hdFldDepartmentID.Value
        DepartmentInfo.DepartmentName = txtDeptName.Text
        DepartmentInfo.DeptCode = txtDeptCode.Text
        DepartmentInfo.HODID = drpDeptHead.SelectedValue
        DepartmentInfo.DeptMailAddress = txtDeptMailAddress.Text

        If chkDeptIsActive.Checked = True Then
            DepartmentInfo.IsActive = True
        Else
            DepartmentInfo.IsActive = False
        End If

        DepartmentInfo.EntryBy = Session("LoginUserID")

        Dim Check As Integer = DepartmentData.fnUpdateDepartment(DepartmentInfo)

        If Check = 1 Then
            MessageBox("Updated Successfully.")
            ClearDeptInputForm()
            ShowDetailsDepartmentList()
        Else
            MessageBox("Error Found.")
        End If
    End Sub

    Protected Sub grdAvailableDept_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdAvailableDept.SelectedIndexChanged
        btnAddDept.Visible = False
        btnUpdateDepartment.Visible = True

        Dim lblDepartmentID As New System.Web.UI.WebControls.Label()
        Dim lblDepartmentName As New System.Web.UI.WebControls.Label()
        Dim lblDeptCode As New System.Web.UI.WebControls.Label()
        Dim lblHODID As New System.Web.UI.WebControls.Label()
        Dim lblDeptMailAddress As New System.Web.UI.WebControls.Label()
        Dim lblIsActive As New System.Web.UI.WebControls.Label()

        lblDepartmentID = grdAvailableDept.SelectedRow.FindControl("lblDepartmentID")
        lblDepartmentName = grdAvailableDept.SelectedRow.FindControl("lblDepartmentName")
        lblDeptCode = grdAvailableDept.SelectedRow.FindControl("lblDeptCode")
        lblHODID = grdAvailableDept.SelectedRow.FindControl("lblHODID")
        lblDeptMailAddress = grdAvailableDept.SelectedRow.FindControl("lblDeptMailAddress")
        lblIsActive = grdAvailableDept.SelectedRow.FindControl("lblIsActive")

        hdFldDepartmentID.Value = lblDepartmentID.Text
        txtDeptName.Text = lblDepartmentName.Text
        txtDeptCode.Text = lblDeptCode.Text
        drpDeptHead.SelectedValue = lblHODID.Text
        txtDeptMailAddress.Text = lblDeptMailAddress.Text

        If lblIsActive.Text = "Active" Then
            chkDeptIsActive.Checked = True
        Else
            chkDeptIsActive.Checked = False
        End If

    End Sub

End Class


Partial Class Administration_frmCreateUser
    Inherits System.Web.UI.Page

    Dim UserData As New clsUserDataAccess()
    Dim DepartmentData As New clsDepartmentDataAccess()
    Dim BranchData As New clsBranchDataAccess()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "MngUser~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then
            GetDepartmentList()
            GetBranchList()
            ShowUserList()
            GetDetailsUsersList()

            btnAddUser.Visible = True
            btnUpdateUser.Visible = False
        End If
    End Sub

    Protected Sub GetDetailsUsersList()
        grdDetailsUserList.DataSource = UserData.fnShowDetailsUsersList()
        grdDetailsUserList.DataBind()
    End Sub

    Protected Sub GetBranchList()
        drpBranch.DataTextField = "BranchName"
        drpBranch.DataValueField = "BranchID"
        drpBranch.DataSource = BranchData.fnGetBranchList()
        drpBranch.DataBind()

        Dim A As New ListItem
        A.Value = "N\A"
        A.Text = "N\A"

        drpBranch.Items.Insert(0, A)

    End Sub

    Protected Sub ShowUserList()
        drpSupervisor.DataTextField = "UserName"
        drpSupervisor.DataValueField = "UniqueUserID"
        drpSupervisor.DataSource = UserData.fnShowUserList()
        drpSupervisor.DataBind()

        Dim A As New ListItem()

        A.Text = "N\A"
        A.Value = "N\A"

        drpSupervisor.Items.Insert(0, A)
    End Sub

    Protected Sub GetDepartmentList()
        drpDeptList.DataTextField = "DepartmentName"
        drpDeptList.DataValueField = "DepartmentID"
        drpDeptList.DataSource = DepartmentData.fnGetDepartmentList()
        drpDeptList.DataBind()

        Dim A As New ListItem
        A.Value = "N\A"
        A.Text = "N\A"

        drpDeptList.Items.Insert(0, A)

    End Sub

    Protected Sub btnAddUser_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddUser.Click

        Dim UserInfo As New clsUsers()

        UserInfo.UserName = txtUserName.Text
        UserInfo.DateOfBirth = txtDateOfBirth.Text
        UserInfo.UserID = txtUserID.Text
        UserInfo.UserPassword = txtPassword.Text
        UserInfo.Email = txtEmailAddress.Text
        UserInfo.UserType = drpUserType.SelectedValue
        UserInfo.Gender = drpGender.SelectedValue
        UserInfo.ContactNumber = txtContactNumber.Text
        UserInfo.SupervisorID = drpSupervisor.SelectedValue
        UserInfo.DepartmentID = drpDeptList.SelectedValue
        UserInfo.BranchID = drpBranch.SelectedValue

        If chkIsActiveUser.Checked = True Then
            UserInfo.IsActive = True
        Else
            UserInfo.IsActive = False
        End If

        UserInfo.EntryBy = Session("LoginUserID")

        Dim Check As Integer = UserData.fnInsertUsers(UserInfo)

        If Check = 1 Then
            MessageBox("User Inserted Successfully.")
            GetDetailsUsersList()
            ClearUserInputForm()
        Else
            MessageBox("Error Found.")
        End If
    End Sub

    Protected Sub ClearUserInputForm()
        txtUserName.Text = ""
        txtDateOfBirth.Text = ""
        txtUserID.Text = ""
        txtPassword.Text = ""
        txtEmailAddress.Text = ""
        drpUserType.SelectedIndex = -1
        drpGender.SelectedIndex = -1
        txtContactNumber.Text = ""
        drpSupervisor.SelectedIndex = -1
        drpDeptList.SelectedIndex = -1
        drpBranch.SelectedIndex = -1

        chkIsActiveUser.Checked = False

        btnAddUser.Visible = True
        btnUpdateUser.Visible = False

        hdFldUniqueUserID.Value = ""
        grdDetailsUserList.SelectedIndex = -1

    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnUpdateUser_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateUser.Click
        Dim UserInfo As New clsUsers()

        UserInfo.UniqueUserID = hdFldUniqueUserID.Value
        UserInfo.UserName = txtUserName.Text
        UserInfo.DateOfBirth = txtDateOfBirth.Text
        UserInfo.UserID = txtUserID.Text
        UserInfo.UserPassword = txtPassword.Text
        UserInfo.Email = txtEmailAddress.Text
        UserInfo.UserType = drpUserType.SelectedValue
        UserInfo.Gender = drpGender.SelectedValue
        UserInfo.ContactNumber = txtContactNumber.Text
        UserInfo.SupervisorID = drpSupervisor.SelectedValue
        UserInfo.DepartmentID = drpDeptList.SelectedValue
        UserInfo.BranchID = drpBranch.SelectedValue

        If chkIsActiveUser.Checked = True Then
            UserInfo.IsActive = True
        Else
            UserInfo.IsActive = False
        End If

        UserInfo.EntryBy = Session("LoginUserID")

        Dim Check As Integer = UserData.fnUpdateUsers(UserInfo)

        If Check = 1 Then
            MessageBox("User Inserted Successfully.")
            GetDetailsUsersList()
            ClearUserInputForm()
        Else
            MessageBox("Error Found.")
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearUserInputForm()
    End Sub

    Protected Sub grdDetailsUserList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdDetailsUserList.SelectedIndexChanged

        btnAddUser.Visible = False
        btnUpdateUser.Visible = True

        Dim lblUniqueUserID As New System.Web.UI.WebControls.Label()
        Dim lblUserName As New System.Web.UI.WebControls.Label()
        Dim lblUserID As New System.Web.UI.WebControls.Label()
        Dim lblUserPassword As New System.Web.UI.WebControls.Label()
        Dim lblDateOfBirth As New System.Web.UI.WebControls.Label()
        Dim lblEmail As New System.Web.UI.WebControls.Label()
        Dim lblUserType As New System.Web.UI.WebControls.Label()
        Dim lblGender As New System.Web.UI.WebControls.Label()
        Dim lblContactNumber As New System.Web.UI.WebControls.Label()
        Dim lblSupervisorID As New System.Web.UI.WebControls.Label()
        Dim lblDepartmentID As New System.Web.UI.WebControls.Label()
        Dim lblBranchID As New System.Web.UI.WebControls.Label()
        Dim lblIsActive As New System.Web.UI.WebControls.Label()

        lblUniqueUserID = grdDetailsUserList.SelectedRow.FindControl("lblUniqueUserID")
        lblUserName = grdDetailsUserList.SelectedRow.FindControl("lblUserName")
        lblUserID = grdDetailsUserList.SelectedRow.FindControl("lblUserID")
        lblUserPassword = grdDetailsUserList.SelectedRow.FindControl("lblUserPassword")
        lblDateOfBirth = grdDetailsUserList.SelectedRow.FindControl("lblDateOfBirth")
        lblEmail = grdDetailsUserList.SelectedRow.FindControl("lblEmail")
        lblUserType = grdDetailsUserList.SelectedRow.FindControl("lblUserType")
        lblGender = grdDetailsUserList.SelectedRow.FindControl("lblGender")
        lblContactNumber = grdDetailsUserList.SelectedRow.FindControl("lblContactNumber")
        lblSupervisorID = grdDetailsUserList.SelectedRow.FindControl("lblSupervisorID")
        lblDepartmentID = grdDetailsUserList.SelectedRow.FindControl("lblDepartmentID")
        lblBranchID = grdDetailsUserList.SelectedRow.FindControl("lblBranchID")
        lblIsActive = grdDetailsUserList.SelectedRow.FindControl("lblIsActive")

        hdFldUniqueUserID.Value = lblUniqueUserID.Text
        txtUserName.Text = lblUserName.Text
        txtDateOfBirth.Text = Convert.ToDateTime(lblDateOfBirth.Text)
        txtUserID.Text = lblUserID.Text
        txtPassword.Text = lblUserPassword.Text
        txtEmailAddress.Text = lblEmail.Text
        drpUserType.SelectedValue = lblUserType.Text
        drpGender.SelectedValue = lblGender.Text
        txtContactNumber.Text = lblContactNumber.Text
        drpSupervisor.SelectedValue = lblSupervisorID.Text
        drpDeptList.SelectedValue = lblDepartmentID.Text
        drpBranch.SelectedValue = lblBranchID.Text

        If lblIsActive.Text = "Active" Then
            chkIsActiveUser.Checked = True
        Else
            chkIsActiveUser.Checked = False
        End If

    End Sub


End Class

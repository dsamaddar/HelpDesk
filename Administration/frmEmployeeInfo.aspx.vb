
Partial Class Administration_frmEmployeeInfo
    Inherits System.Web.UI.Page

    Dim DeptData As New clsDepartmentDataAccess()
    Dim EmpData As New clsEmployeeInfoDataAccess()
    Dim ULCBranchData As New clsULCBranchDataAccess()
    Dim DesignationData As New clsDesignationDataAccess()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "EmpInfo~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then
            GetAllEmpDetails()
            ShowDepertment()
            ShowULCBranch()
            ShowSupervisorList()
            ShowDesignationOfficial()

            btnInsert.Enabled = True
            btnUpdate.Enabled = False
        End If
    End Sub

    Protected Sub ShowDesignationOfficial()
        ddlOfficialDesignation.DataTextField = "DesignationName"
        ddlOfficialDesignation.DataValueField = "DesignationID"
        ddlOfficialDesignation.DataSource = DesignationData.fnGetOfficialDesignation()
        ddlOfficialDesignation.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"

        ddlOfficialDesignation.Items.Insert(0, A)

    End Sub

    Protected Sub ShowDepertment()
        ddlDepartment.DataTextField = "DeptName"
        ddlDepartment.DataValueField = "DepartmentID"
        ddlDepartment.DataSource = DeptData.fnGetDeptList()
        ddlDepartment.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        ddlDepartment.Items.Insert(0, A)
    End Sub

    Protected Sub ShowULCBranch()
        ddlULCBranch.DataTextField = "ULCBranchName"
        ddlULCBranch.DataValueField = "ULCBranchID"
        ddlULCBranch.DataSource = ULCBranchData.fnGetULCBranch()
        ddlULCBranch.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        ddlULCBranch.Items.Insert(0, A)
    End Sub

    Protected Sub ShowSupervisorList()
        ddlCurrentSupervisor.DataTextField = "EmployeeName"
        ddlCurrentSupervisor.DataValueField = "EmployeeID"
        ddlCurrentSupervisor.DataSource = EmpData.fnGetEmployeeList()
        ddlCurrentSupervisor.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        ddlCurrentSupervisor.Items.Insert(0, A)
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub GetAllEmpDetails()
        grdEmployeeInfo.DataSource = EmpData.fnGetAllEmpDetails()
        grdEmployeeInfo.DataBind()
    End Sub

    Protected Sub grdEmployeeInfo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdEmployeeInfo.SelectedIndexChanged

        Dim lblEmployeeID, lblEmployeeName, lblUserID, lblUserType, lblUserPassword, lblEmpCode, lblDateOfBirth, lblJoiningDate, lblDesignationID, _
        lblDepartmentID, lblULCBranchID, lblCurrentSupervisor, lblEmpStatus, lblIsActive As New Label()

        lblEmployeeID = grdEmployeeInfo.SelectedRow.FindControl("lblEmployeeID")
        lblEmployeeName = grdEmployeeInfo.SelectedRow.FindControl("lblEmployeeName")
        lblUserID = grdEmployeeInfo.SelectedRow.FindControl("lblUserID")
        lblUserType = grdEmployeeInfo.SelectedRow.FindControl("lblUserType")
        lblUserPassword = grdEmployeeInfo.SelectedRow.FindControl("lblUserPassword")
        lblEmpCode = grdEmployeeInfo.SelectedRow.FindControl("lblEmpCode")
        lblDesignationID = grdEmployeeInfo.SelectedRow.FindControl("lblDesignationID")
        lblDepartmentID = grdEmployeeInfo.SelectedRow.FindControl("lblDepartmentID")
        lblULCBranchID = grdEmployeeInfo.SelectedRow.FindControl("lblULCBranchID")
        lblCurrentSupervisor = grdEmployeeInfo.SelectedRow.FindControl("lblCurrentSupervisor")
        lblEmpStatus = grdEmployeeInfo.SelectedRow.FindControl("lblEmpStatus")
        lblDateOfBirth = grdEmployeeInfo.SelectedRow.FindControl("lblDateOfBirth")
        lblJoiningDate = grdEmployeeInfo.SelectedRow.FindControl("lblJoiningDate")
        lblIsActive = grdEmployeeInfo.SelectedRow.FindControl("lblIsActive")

        Try
            hdFldEmployeeID.Value = lblEmployeeID.Text
            txtEmpName.Text = lblEmployeeName.Text
            txtUserID.Text = lblUserID.Text
            txtUserPassword.Attributes.Add("Value", lblUserPassword.Text)
            txtEmpCode.Text = lblEmpCode.Text
            ddlOfficialDesignation.SelectedValue = lblDesignationID.Text
            ddlDepartment.SelectedValue = lblDepartmentID.Text
            ddlULCBranch.SelectedValue = lblULCBranchID.Text
            ddlCurrentSupervisor.SelectedValue = lblCurrentSupervisor.Text
            drpEmpStatus.SelectedValue = lblEmpStatus.Text
            drpUserType.SelectedValue = lblUserType.Text
            txtDateOfBirth.Text = Convert.ToDateTime(lblDateOfBirth.Text)
            txtJoiningDate.Text = Convert.ToDateTime(lblJoiningDate.Text)

            If lblIsActive.Text = "YES" Then
                chkIsActive.Checked = True
            Else
                chkIsActive.Checked = False
            End If

            btnInsert.Enabled = False
            btnUpdate.Enabled = True

        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

    End Sub

    Protected Sub btnInsert_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInsert.Click

        Dim EmpInfo As New clsEmployeeInfo()

        Try
            EmpInfo.EmployeeName = txtEmpName.Text
            EmpInfo.EmpCode = txtEmpCode.Text
            EmpInfo.UserID = txtUserID.Text
            EmpInfo.UserPassword = txtUserPassword.Text
            EmpInfo.UserType = drpUserType.SelectedValue
            EmpInfo.DateOfBirth = Convert.ToDateTime(txtDateOfBirth.Text)
            EmpInfo.JoiningDate = Convert.ToDateTime(txtJoiningDate.Text)
            EmpInfo.DesignationID = ddlOfficialDesignation.SelectedValue
            EmpInfo.DepartmentID = ddlDepartment.SelectedValue
            EmpInfo.ULCBranchID = ddlULCBranch.SelectedValue
            EmpInfo.CurrentSupervisor = ddlCurrentSupervisor.SelectedValue
            EmpInfo.EmpStatus = drpEmpStatus.SelectedValue

            If chkIsActive.Checked = True Then
                EmpInfo.IsActive = True
            Else
                EmpInfo.IsActive = False
            End If

            EmpInfo.EntryBy = Session("UserID")

            Dim result As clsResult = EmpData.fnInsertEmployeeInfo(EmpInfo)

            If result.Success = True Then
                ClearForm()
                GetAllEmpDetails()
            End If

            MessageBox(result.Message)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
      
    End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click

        If hdFldEmployeeID.Value = "" Then
            MessageBox("Select An Employee First.")
            Exit Sub
        End If


        Dim EmpInfo As New clsEmployeeInfo()

        Try
            EmpInfo.EmployeeID = hdFldEmployeeID.Value
            EmpInfo.EmployeeName = txtEmpName.Text
            EmpInfo.EmpCode = txtEmpCode.Text
            EmpInfo.UserID = txtUserID.Text
            EmpInfo.UserPassword = txtUserPassword.Text
            EmpInfo.UserType = drpUserType.SelectedValue
            EmpInfo.DateOfBirth = Convert.ToDateTime(txtDateOfBirth.Text)
            EmpInfo.JoiningDate = Convert.ToDateTime(txtJoiningDate.Text)
            EmpInfo.DesignationID = ddlOfficialDesignation.SelectedValue
            EmpInfo.DepartmentID = ddlDepartment.SelectedValue
            EmpInfo.ULCBranchID = ddlULCBranch.SelectedValue
            EmpInfo.CurrentSupervisor = ddlCurrentSupervisor.SelectedValue
            EmpInfo.EmpStatus = drpEmpStatus.SelectedValue

            If chkIsActive.Checked = True Then
                EmpInfo.IsActive = True
            Else
                EmpInfo.IsActive = False
            End If

            EmpInfo.EntryBy = Session("LoginUserID")

            Dim result As clsResult = EmpData.fnUpdateEmpInfo(EmpInfo)

            If result.Success = True Then
                ClearForm()
                GetAllEmpDetails()
            End If

            MessageBox(result.Message)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try


    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearForm()
    End Sub

    Protected Sub ClearForm()
        txtEmpName.Text = ""
        txtEmpCode.Text = ""
        txtJoiningDate.Text = ""
        txtDateOfBirth.Text = ""
        txtUserID.Text = ""
        txtUserPassword.Text = ""

        ddlDepartment.SelectedIndex = -1
        ddlOfficialDesignation.SelectedIndex = -1
        ddlULCBranch.SelectedIndex = -1
        ddlCurrentSupervisor.SelectedIndex = -1

        grdEmployeeInfo.SelectedIndex = -1

        chkIsActive.Checked = False
        drpEmpStatus.SelectedIndex = -1
        drpUserType.SelectedIndex = -1

        btnInsert.Enabled = True
        btnUpdate.Enabled = False

    End Sub

End Class

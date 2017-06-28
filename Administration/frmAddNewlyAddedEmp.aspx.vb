
Partial Class Administration_frmAddNewlyAddedEmp
    Inherits System.Web.UI.Page

    Dim EmpData As New clsEmployeeInfoDataAccess()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "AddNewlyAddEmp~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then

            GetNewlyAddedEmpList()

        End If

    End Sub

    Protected Sub grdEmployeeInfo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdEmployeeInfo.SelectedIndexChanged

        Dim lblEmployeeID, lblEmployeeName, lblUserID, lblUserPassword, lblUserType, lblEmpCode, lblDateOfBirth, lblJoiningDate, _
        lblDesignationID, lblDepartmentID, lblULCBranchID, lblCurrentSupervisor, lblEmpStatus, lblMailAddress, lblMobileNo, lblIsActive, lblEntryBy As New Label

        lblEmployeeID = grdEmployeeInfo.SelectedRow.FindControl("lblEmployeeID")
        lblEmployeeName = grdEmployeeInfo.SelectedRow.FindControl("lblEmployeeName")
        lblUserID = grdEmployeeInfo.SelectedRow.FindControl("lblUserID")
        lblUserPassword = grdEmployeeInfo.SelectedRow.FindControl("lblUserPassword")
        lblUserType = grdEmployeeInfo.SelectedRow.FindControl("lblUserType")
        lblEmpCode = grdEmployeeInfo.SelectedRow.FindControl("lblEmpCode")
        lblDateOfBirth = grdEmployeeInfo.SelectedRow.FindControl("lblDateOfBirth")
        lblJoiningDate = grdEmployeeInfo.SelectedRow.FindControl("lblJoiningDate")
        lblDesignationID = grdEmployeeInfo.SelectedRow.FindControl("lblDesignationID")
        lblDepartmentID = grdEmployeeInfo.SelectedRow.FindControl("lblDepartmentID")
        lblULCBranchID = grdEmployeeInfo.SelectedRow.FindControl("lblULCBranchID")
        lblCurrentSupervisor = grdEmployeeInfo.SelectedRow.FindControl("lblCurrentSupervisor")
        lblEmpStatus = grdEmployeeInfo.SelectedRow.FindControl("lblEmpStatus")
        lblMailAddress = grdEmployeeInfo.SelectedRow.FindControl("lblMailAddress")
        lblMobileNo = grdEmployeeInfo.SelectedRow.FindControl("lblMobileNo")
        lblIsActive = grdEmployeeInfo.SelectedRow.FindControl("lblIsActive")
        lblEntryBy = grdEmployeeInfo.SelectedRow.FindControl("lblEntryBy")

        Dim EmpInfo As New clsEmployeeInfo()

        Try
            EmpInfo.EmployeeID = lblEmployeeID.Text
            EmpInfo.EmployeeName = lblEmployeeName.Text
            EmpInfo.UserID = lblUserID.Text
            EmpInfo.UserPassword = lblUserPassword.Text
            EmpInfo.UserType = lblUserType.Text
            EmpInfo.EmpCode = lblEmpCode.Text
            EmpInfo.DateOfBirth = lblDateOfBirth.Text
            EmpInfo.JoiningDate = lblJoiningDate.Text
            EmpInfo.DesignationID = lblDesignationID.Text
            EmpInfo.DepartmentID = lblDepartmentID.Text
            EmpInfo.ULCBranchID = lblULCBranchID.Text
            EmpInfo.CurrentSupervisor = lblCurrentSupervisor.Text
            EmpInfo.EmpStatus = lblEmpStatus.Text
            EmpInfo.MailAddress = lblMailAddress.Text
            EmpInfo.MobileNo = lblMobileNo.Text

            If lblIsActive.Text = "YES" Then
                EmpInfo.IsActive = True
            Else
                EmpInfo.IsActive = False
            End If

            EmpInfo.EntryBy = lblEntryBy.Text

            Dim result As clsResult = EmpData.fnAddNewlyAddedEmp(EmpInfo)

            If result.Success = True Then
                GetNewlyAddedEmpList()
                ClearSelection()
            End If

            MessageBox(result.Message)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
       
    End Sub

    Protected Sub ClearSelection()
        grdEmployeeInfo.SelectedIndex = -1
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub GetNewlyAddedEmpList()
        Dim EmpIDList As String = ""
        EmpIDList = EmpData.fnGetAllEmpIDList()

        grdEmployeeInfo.DataSource = EmpData.fnGetNewlyAddedEmp(EmpIDList)
        grdEmployeeInfo.DataBind()
    End Sub

End Class

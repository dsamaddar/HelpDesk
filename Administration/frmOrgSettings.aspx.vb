
Partial Class Administration_frmOrgSettings
    Inherits System.Web.UI.Page

    Dim EmployeeData As New EmployeeSettingsDataAccess()
    Dim DepartmentData As New clsDepartmentDataAccess()

    Protected Sub btnInsertDesignation_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInsertDesignation.Click
        Dim UserID As String
        UserID = Session("LoginUserID")

        Dim Employee As New clsEmployee()

        Employee.DesignationName = txtDesignationName.Text
        Employee.DesignationLabel = ddlDesigLabel.SelectedValue
        If ddlDesigLabel.SelectedValue = "0" Then
            MessageBox("Please Select Designation Label")
            Exit Sub
        End If
        Employee.DesignationType = rdoDesignationType.SelectedValue
        Employee.HealthPlanID = ddlHealthPlan.SelectedValue
        Employee.intOrder = txtOrder.Text

        If chkIsDesigActive.Checked = True Then
            Employee.isActive = True
        Else
            Employee.isActive = False
        End If

        Employee.EntryBy = UserID

        Dim check As Integer = EmployeeData.fnInsertDesignation(Employee)

        If check = 1 Then
            ClearDesignation()
            ShowDesignation()
            MessageBox("Inserted.")
            ShowDesignationForGrid()
        Else
            MessageBox("Error Found.")
        End If
    End Sub

    Protected Sub btnCancelSelection_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelSelection.Click
        ClearDesignation()
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub
    Protected Sub ClearDesignation()
        grdDesignation.SelectedIndex = -1
        btnInsertDesignation.Visible = True
        btnUpdateDesignation.Visible = False
        txtDesignationName.Text = ""
        ddlDesigLabel.SelectedValue = 0
        txtOrder.Text = ""
        chkIsDesigActive.Checked = False
        ddlHealthPlan.SelectedIndex = 0
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "DesigDef~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then
            ShowDesignation()
            ShowDesignationForGrid()
            btnUpdateDesignation.Visible = False
            GetHealthPlanType()
        End If

    End Sub

    Protected Sub ShowDesignation()
        drpAvailableDesignation.DataTextField = "DesignationName"
        drpAvailableDesignation.DataValueField = "DesignationID"
        drpAvailableDesignation.DataSource = EmployeeData.fnGetDesignationList()
        drpAvailableDesignation.DataBind()
    End Sub

    Protected Sub ShowDesignationForGrid()
        grdDesignation.DataSource = EmployeeData.fnGetDesignationList()
        grdDesignation.DataBind()
    End Sub
    Protected Sub GetHealthPlanType()
        ddlHealthPlan.DataTextField = "HealthPlanName"
        ddlHealthPlan.DataValueField = "HealthPlanID"
        ddlHealthPlan.DataSource = EmployeeData.fnGetHealthPlanList()
        ddlHealthPlan.DataBind()
    End Sub

    Protected Sub grdDesignation_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdDesignation.SelectedIndexChanged
        ddlDesigLabel.SelectedValue = 0
        rdoDesignationType.SelectedValue = 0

        Dim lblDesignationName As New System.Web.UI.WebControls.Label()
        lblDesignationName = grdDesignation.SelectedRow.FindControl("lblDesignationName")

        Dim lblintOrder As New System.Web.UI.WebControls.Label()
        lblintOrder = grdDesignation.SelectedRow.FindControl("lblintOrder")

        Dim lblisActive As New System.Web.UI.WebControls.Label()
        lblisActive = grdDesignation.SelectedRow.FindControl("lblisActive")

        Dim lblDesignationType As New System.Web.UI.WebControls.Label()
        lblDesignationType = grdDesignation.SelectedRow.FindControl("lblDesignationType")

        Dim lblDesignationLabel As New System.Web.UI.WebControls.Label()
        lblDesignationLabel = grdDesignation.SelectedRow.FindControl("lblDesignationLabel")

        Dim lblHealthPlanName As New System.Web.UI.WebControls.Label()
        lblHealthPlanName = grdDesignation.SelectedRow.FindControl("lblHealthPlanName")

        Dim lblHealthPlanID As New System.Web.UI.WebControls.Label()
        lblHealthPlanID = grdDesignation.SelectedRow.FindControl("lblHealthPlanID")


        txtDesignationName.Text = lblDesignationName.Text
        ddlDesigLabel.SelectedValue = lblDesignationLabel.Text
        rdoDesignationType.SelectedValue = lblDesignationType.Text
        txtOrder.Text = lblintOrder.Text
        ddlHealthPlan.SelectedValue = lblHealthPlanID.Text

        If lblisActive.Text = "Active" Then
            chkIsDesigActive.Checked = True
        Else
            chkIsDesigActive.Checked = False
        End If

        btnInsertDesignation.Visible = False
        btnUpdateDesignation.Visible = True
    End Sub

    Protected Sub btnUpdateDesignation_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateDesignation.Click
        Dim lblDesignationID As New System.Web.UI.WebControls.Label()
        lblDesignationID = grdDesignation.SelectedRow.FindControl("lblDesignationID")

        Dim UserID As String
        UserID = Session("LoginUserID")

        Dim Employee As New clsEmployee()

        Employee.DesignationID = lblDesignationID.Text
        Employee.DesignationName = txtDesignationName.Text
        Employee.DesignationLabel = ddlDesigLabel.SelectedValue
        If ddlDesigLabel.SelectedValue = "0" Then
            MessageBox("Please Select Designation Label")
            Exit Sub
        End If
        Employee.DesignationType = rdoDesignationType.SelectedValue
        Employee.HealthPlanID = ddlHealthPlan.SelectedValue
        Employee.intOrder = txtOrder.Text

        If chkIsDesigActive.Checked = True Then
            Employee.isActive = 1
        Else
            Employee.isActive = 0
        End If

        Employee.EntryBy = UserID

        Dim check As Integer = EmployeeData.fnUpdateDesignation(Employee)

        If check = 1 Then
            ClearDesignation()
            ShowDesignation()
            MessageBox("Updated.")
            ShowDesignationForGrid()
            btnUpdateDesignation.Visible = False
            btnInsertDesignation.Visible = True
        Else
            MessageBox("Error Found.")
            btnUpdateDesignation.Visible = True
            btnInsertDesignation.Visible = False
        End If
    End Sub

End Class

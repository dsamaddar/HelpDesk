
Partial Class Administration_frmBranchManagement
    Inherits System.Web.UI.Page

    Dim UserData As New clsUserDataAccess()
    Dim DepartmentData As New clsDepartmentDataAccess()
    Dim BranchData As New clsBranchDataAccess()

    Protected Sub btnBranchInput_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBranchInput.Click

        Dim BranchInfo As New clsBranchInfo()

        BranchInfo.BranchName = txtBranchName.Text
        BranchInfo.BranchCode = txtBranchCode.Text
        BranchInfo.HOBranch = drpHOBranch.SelectedValue
        BranchInfo.Address = txtBranchAddress.Text
        BranchInfo.ContactNumber = txtContactNumber.Text
        BranchInfo.BranchMailAddress = txtBranchMailAddress.Text

        If chkIsActiveBranch.Checked = True Then
            BranchInfo.IsActive = True
        Else
            BranchInfo.IsActive = False
        End If

        BranchInfo.EntryBy = Session("LoginUserID")

        Dim Check As Integer = BranchData.fnInsertBranchInfo(BranchInfo)

        If Check = 1 Then
            MessageBox("Branch Inserted Successfully.")
            ClearBranchInfo()
            ShowDetailsBranchList()
        Else
            MessageBox("Error Found")
        End If

    End Sub

    Protected Sub ClearBranchInfo()
        txtBranchName.Text = ""
        txtBranchCode.Text = ""
        drpHOBranch.SelectedIndex = -1
        txtBranchAddress.Text = ""
        txtContactNumber.Text = ""
        txtBranchMailAddress.Text = ""
        chkIsActiveBranch.Checked = False

        btnBranchInput.Visible = True
        btnUpdateBranch.Visible = False

        grdBranchList.SelectedIndex = -1
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnUpdateBranch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateBranch.Click
        Dim BranchInfo As New clsBranchInfo()

        BranchInfo.BranchID = hdFldBranchID.Value
        BranchInfo.BranchName = txtBranchName.Text
        BranchInfo.BranchCode = txtBranchCode.Text
        BranchInfo.HOBranch = drpHOBranch.SelectedValue
        BranchInfo.Address = txtBranchAddress.Text
        BranchInfo.ContactNumber = txtContactNumber.Text
        BranchInfo.BranchMailAddress = txtBranchMailAddress.Text

        If chkIsActiveBranch.Checked = True Then
            BranchInfo.IsActive = True
        Else
            BranchInfo.IsActive = False
        End If

        BranchInfo.EntryBy = Session("LoginUserID")

        Dim Check As Integer = BranchData.fnUpdateBranchInfo(BranchInfo)

        If Check = 1 Then
            MessageBox("Branch Updated Successfully.")
            ClearBranchInfo()
            ShowDetailsBranchList()
        Else
            MessageBox("Error Found")
        End If
    End Sub

    Protected Sub btnCancelBranchInput_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelBranchInput.Click
        ClearBranchInfo()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "MngBranch~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then
            btnUpdateBranch.Visible = False
            btnBranchInput.Visible = True
            ShowUserList()
            ShowDetailsBranchList()
        End If
    End Sub

    Protected Sub ShowDetailsBranchList()
        grdBranchList.DataSource = BranchData.fnGetDetailsBranchList()
        grdBranchList.DataBind()
    End Sub

    Protected Sub ShowUserList()
        drpHOBranch.DataTextField = "UserName"
        drpHOBranch.DataValueField = "UniqueUserID"
        drpHOBranch.DataSource = UserData.fnShowUserList()
        drpHOBranch.DataBind()

        Dim A As New ListItem()

        A.Text = "N\A"
        A.Value = "N\A"

        drpHOBranch.Items.Insert(0, A)
    End Sub

    Protected Sub grdBranchList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdBranchList.SelectedIndexChanged

        btnBranchInput.Visible = False
        btnUpdateBranch.Visible = True

        Dim lblBranchID As New System.Web.UI.WebControls.Label()
        Dim lblBranchName As New System.Web.UI.WebControls.Label()
        Dim lblBranchCode As New System.Web.UI.WebControls.Label()
        Dim lblHOBranch As New System.Web.UI.WebControls.Label()
        Dim lblAddress As New System.Web.UI.WebControls.Label()
        Dim lblContactNumber As New System.Web.UI.WebControls.Label()
        Dim lblBranchMailAddress As New System.Web.UI.WebControls.Label()
        Dim lblIsActive As New System.Web.UI.WebControls.Label()

        lblBranchID = grdBranchList.SelectedRow.FindControl("lblBranchID")
        lblBranchName = grdBranchList.SelectedRow.FindControl("lblBranchName")
        lblBranchCode = grdBranchList.SelectedRow.FindControl("lblBranchCode")
        lblHOBranch = grdBranchList.SelectedRow.FindControl("lblHOBranch")
        lblAddress = grdBranchList.SelectedRow.FindControl("lblAddress")
        lblContactNumber = grdBranchList.SelectedRow.FindControl("lblContactNumber")
        lblBranchMailAddress = grdBranchList.SelectedRow.FindControl("lblBranchMailAddress")
        lblIsActive = grdBranchList.SelectedRow.FindControl("lblIsActive")

        hdFldBranchID.Value = lblBranchID.Text

        txtBranchName.Text = lblBranchName.Text
        txtBranchCode.Text = lblBranchCode.Text
        drpHOBranch.SelectedValue = lblHOBranch.Text
        txtBranchAddress.Text = lblAddress.Text
        txtContactNumber.Text = lblContactNumber.Text
        txtBranchMailAddress.Text = lblBranchMailAddress.Text

        If lblIsActive.Text = "Active" Then
            chkIsActiveBranch.Checked = True
        Else
            chkIsActiveBranch.Checked = False
        End If


    End Sub

End Class

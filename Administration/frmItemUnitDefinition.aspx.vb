
Partial Class Administration_frmItemUnitDefinition
    Inherits System.Web.UI.Page

    Dim UnitTypeData As New clsUnitTypeDataAccess()

    Protected Sub btnCancelAddUnitType_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelAddUnitType.Click
        btnAddUnitType.Visible = True
        btnUpdateUnitType.Visible = False
        ClearUnitTypeEntry()
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnAddUnitType_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddUnitType.Click

        Dim UnitType As New clsUnitType()

        UnitType.UnitType = txtUnitType.Text
        UnitType.EntryBy = Session("LoginUserID")

        If chkUnitTypeIsActive.Checked = True Then
            UnitType.IsActive = True
        Else
            UnitType.IsActive = False
        End If

        Dim Check As Integer = UnitTypeData.fnInsertUnitType(UnitType)

        If Check = 1 Then
            MessageBox("Successfully Inserted.")
            ShowDetailsUnitTypeList()
            ClearUnitTypeEntry()
        Else
            MessageBox("Error Found.")
        End If

    End Sub

    Protected Sub ClearUnitTypeEntry()
        btnUpdateUnitType.Visible = False
        btnAddUnitType.Visible = True
        hdFldUnitTypeID.Value = ""
        grdAvailableUnitType.SelectedIndex = -1
        txtUnitType.Text = ""
        chkUnitTypeIsActive.Checked = False
    End Sub

 

    Protected Sub ShowDetailsUnitTypeList()
        grdAvailableUnitType.DataSource = UnitTypeData.fnShowDetailsUnitTypeList()
        grdAvailableUnitType.DataBind()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "MngItmUnit~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then
            ShowDetailsUnitTypeList()
            btnUpdateUnitType.Visible = False
        End If
    End Sub


    Protected Sub btnUpdateUnitType_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateUnitType.Click
        Dim UnitType As New clsUnitType()

        UnitType.UnitTypeID = hdFldUnitTypeID.Value
        UnitType.UnitType = txtUnitType.Text
        UnitType.EntryBy = Session("LoginUserID")

        If chkUnitTypeIsActive.Checked = True Then
            UnitType.IsActive = True
        Else
            UnitType.IsActive = False
        End If

        Dim Check As Integer = UnitTypeData.fnUpdateUnitType(UnitType)

        If Check = 1 Then
            MessageBox("Successfully Updated.")
            ShowDetailsUnitTypeList()
            ClearUnitTypeEntry()
        Else
            MessageBox("Error Found.")
        End If
    End Sub

    Protected Sub grdAvailableUnitType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdAvailableUnitType.SelectedIndexChanged
        btnAddUnitType.Visible = False
        btnUpdateUnitType.Visible = True

        Dim lblUnitTypeID As New System.Web.UI.WebControls.Label()
        Dim lblUnitType As New System.Web.UI.WebControls.Label()
        Dim lblIsActive As New System.Web.UI.WebControls.Label()
        Dim lblEntryBy As New System.Web.UI.WebControls.Label()

        lblUnitTypeID = grdAvailableUnitType.SelectedRow.FindControl("lblUnitTypeID")
        lblUnitType = grdAvailableUnitType.SelectedRow.FindControl("lblUnitType")
        lblIsActive = grdAvailableUnitType.SelectedRow.FindControl("lblIsActive")
        lblEntryBy = grdAvailableUnitType.SelectedRow.FindControl("lblEntryBy")

        hdFldUnitTypeID.Value = lblUnitTypeID.Text
        txtUnitType.Text = lblUnitType.Text

        If lblIsActive.Text = "Active" Then
            chkUnitTypeIsActive.Checked = True
        Else
            chkUnitTypeIsActive.Checked = False
        End If

    End Sub

End Class

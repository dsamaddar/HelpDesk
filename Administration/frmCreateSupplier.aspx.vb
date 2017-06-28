
Partial Class Administration_frmCreateSupplier
    Inherits System.Web.UI.Page

    Dim SupplierData As New clsSupplierDataAccess()

    Protected Sub btnAddSupplier_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddSupplier.Click

        Dim SupplierInfo As New clsSupplier()

        SupplierInfo.SupplierName = txtSupplierName.Text
        SupplierInfo.Address = txtSupplierAddresss.Text
        SupplierInfo.ContactPerson = txtContactPerson.Text
        SupplierInfo.ContactNumber = txtContactNumber.Text
        SupplierInfo.AboutSupplier = txtAboutSupplier.Text
        SupplierInfo.Company_Phone_Mobile = txtCompanyMobile.Text
        SupplierInfo.Fax = txtFax.Text
        SupplierInfo.Email = txtEmail.Text
        SupplierInfo.EntryBy = Session("LoginUserID")

        If chkIsBlackListed.Checked = True Then
            SupplierInfo.IsBlackListed = True
        Else
            SupplierInfo.IsBlackListed = False
        End If

        Dim Check As Integer = SupplierData.fnInsertSupplier(SupplierInfo)

        If Check = 1 Then
            MessageBox("Inserted Successfully.")
            GetSupplierDetails()
            ClearSupplierInputForm()
        Else
            MessageBox("Error Found.")
        End If

    End Sub

    Protected Sub ClearSupplierInputForm()
        txtSupplierName.Text = ""
        txtSupplierAddresss.Text = ""
        txtContactPerson.Text = ""
        txtContactNumber.Text = ""
        txtAboutSupplier.Text = ""
        txtCompanyMobile.Text = ""
        txtFax.Text = ""
        txtEmail.Text = ""
        chkIsBlackListed.Checked = False
        grdAvailableSupplierInfo.SelectedIndex = -1

        btnAddSupplier.Visible = True
        btnUpdateSupplier.Visible = False

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

        If InStr(MenuIDs, "SupplierDef~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then
            GetSupplierDetails()

            btnAddSupplier.Visible = True
            btnUpdateSupplier.Visible = False
        End If
    End Sub

    Protected Sub GetSupplierDetails()
        grdAvailableSupplierInfo.DataSource = SupplierData.fnGetSupplierDetails()
        grdAvailableSupplierInfo.DataBind()
    End Sub

    Protected Sub btnCancelInputSupplier_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelInputSupplier.Click
        ClearSupplierInputForm()
    End Sub

    Protected Sub btnUpdateSupplier_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateSupplier.Click

        Dim SupplierInfo As New clsSupplier()

        SupplierInfo.SupplierID = hdFldSupplierID.Value
        SupplierInfo.SupplierName = txtSupplierName.Text
        SupplierInfo.Address = txtSupplierAddresss.Text
        SupplierInfo.ContactPerson = txtContactPerson.Text
        SupplierInfo.ContactNumber = txtContactNumber.Text
        SupplierInfo.AboutSupplier = txtAboutSupplier.Text
        SupplierInfo.Company_Phone_Mobile = txtCompanyMobile.Text
        SupplierInfo.Fax = txtFax.Text
        SupplierInfo.Email = txtEmail.Text
        SupplierInfo.EntryBy = Session("LoginUserID")

        If chkIsBlackListed.Checked = True Then
            SupplierInfo.IsBlackListed = True
        Else
            SupplierInfo.IsBlackListed = False
        End If

        Dim Check As Integer = SupplierData.fnUpdateSupplier(SupplierInfo)

        If Check = 1 Then
            MessageBox("Updated Successfully.")
            GetSupplierDetails()
            ClearSupplierInputForm()
        Else
            MessageBox("Error Found.")
        End If
    End Sub

    Protected Sub grdAvailableSupplierInfo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdAvailableSupplierInfo.SelectedIndexChanged

        Dim lblSupplierID, lblSupplierName, lblAddress, lblContactPerson, lblContactNumber, lblAboutSupplier As New System.Web.UI.WebControls.Label()
        Dim lblIsBlackListed, lblCompanyContactNumber, lblFax, lblEmail As New System.Web.UI.WebControls.Label()


        lblSupplierID = grdAvailableSupplierInfo.SelectedRow.FindControl("lblSupplierID")
        hdFldSupplierID.Value = lblSupplierID.Text

        lblSupplierName = grdAvailableSupplierInfo.SelectedRow.FindControl("lblSupplierName")
        lblAddress = grdAvailableSupplierInfo.SelectedRow.FindControl("lblAddress")
        lblContactPerson = grdAvailableSupplierInfo.SelectedRow.FindControl("lblContactPerson")
        lblContactNumber = grdAvailableSupplierInfo.SelectedRow.FindControl("lblContactNumber")
        lblAboutSupplier = grdAvailableSupplierInfo.SelectedRow.FindControl("lblAboutSupplier")
        lblCompanyContactNumber = grdAvailableSupplierInfo.SelectedRow.FindControl("lblCompanyContactNumber")
        lblFax = grdAvailableSupplierInfo.SelectedRow.FindControl("lblFax")
        lblEmail = grdAvailableSupplierInfo.SelectedRow.FindControl("lblEmail")
        lblIsBlackListed = grdAvailableSupplierInfo.SelectedRow.FindControl("lblIsBlackListed")

        txtSupplierName.Text = lblSupplierName.Text
        txtSupplierAddresss.Text = lblAddress.Text
        txtContactPerson.Text = lblContactPerson.Text
        txtContactNumber.Text = lblContactNumber.Text
        txtAboutSupplier.Text = lblAboutSupplier.Text
        txtCompanyMobile.Text = lblCompanyContactNumber.Text
        txtFax.Text = lblFax.Text
        txtEmail.Text = lblEmail.Text

        If lblIsBlackListed.Text = "YES" Then
            chkIsBlackListed.Checked = True
        Else
            chkIsBlackListed.Checked = False
        End If

        btnAddSupplier.Visible = False
        btnUpdateSupplier.Visible = True

    End Sub

End Class

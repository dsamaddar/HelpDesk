
Partial Class Procurement_frmInvoiceInput
    Inherits System.Web.UI.Page

    Dim SupplierData As New clsSupplierDataAccess()
    Dim InvoiceData As New clsInvoiceDataAccess()
    'Dim UserData As New clsUserDataAccess()
    Dim EmpData As New clsEmployeeInfoDataAccess()

    Protected Sub btnGenerateInvoice_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGenerateInvoice.Click

        If drpSupplier.SelectedValue = "N\A" Then
            MessageBox("Select A Supplier First.")
            Exit Sub
        End If

        If drpApprover.SelectedValue = "N\A" Then
            MessageBox("Select Invoice Approver.")
            Exit Sub
        End If

        Dim Invoice As New clsInvoice()

        Try
            Invoice.InvoiceNo = txtInvoiceNumber.Text
            Invoice.SupplierID = drpSupplier.SelectedValue
            Invoice.InvoiceDate = txtPurchaseDate.Text
            Invoice.InvoiceCost = txtInvoiceCost.Text
            Invoice.ApproverID = drpApprover.SelectedValue
            Invoice.EntryBy = Session("LoginUserID")

            Dim Check As Integer = InvoiceData.fnInsertInvoice(Invoice)

            If Check = 1 Then
                MessageBox("Invoice Inserted.")
                ClearInvoiceForm()
                ShowInvoiceDetails()
            Else
                MessageBox("Error Found.")
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
       

    End Sub

    Protected Sub ClearInvoiceForm()
        txtInvoiceNumber.Text = ""
        drpSupplier.SelectedIndex = -1
        txtPurchaseDate.Text = ""
        txtInvoiceCost.Text = ""
        drpApprover.SelectedIndex = -1

        grdInvoiceList.SelectedIndex = -1

        grdInvoiceList.DataSource = ""
        grdInvoiceList.DataBind()
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnCancelInvoiceInput_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelInvoiceInput.Click
        ClearInvoiceForm()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "GenInv~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then
            ShowSupplierInfo()
            ShowUserList()
            ShowInvoiceDetails()
        End If
    End Sub

    Protected Sub ShowInvoiceDetails()
        grdInvoiceList.DataSource = InvoiceData.fnGetDetailsInvoiceList()
        grdInvoiceList.DataBind()
    End Sub

    Protected Sub ShowSupplierInfo()
        drpSupplier.DataValueField = "SupplierID"
        drpSupplier.DataTextField = "SupplierName"
        drpSupplier.DataSource = SupplierData.fnGetSupplier()
        drpSupplier.DataBind()

        Dim A As New ListItem

        A.Text = "N\A"
        A.Value = "N\A"
        drpSupplier.Items.Insert(0, A)

    End Sub

    Protected Sub ShowUserList()
        drpApprover.DataTextField = "EmployeeName"
        drpApprover.DataValueField = "EmployeeID"
        drpApprover.DataSource = EmpData.fnGetActiveEmpList()
        drpApprover.DataBind()

        Dim A As New ListItem()

        A.Text = "N\A"
        A.Value = "N\A"

        drpApprover.Items.Insert(0, A)
    End Sub

End Class

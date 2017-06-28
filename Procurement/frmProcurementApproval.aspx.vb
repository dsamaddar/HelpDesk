
Partial Class Procurement_frmProcurementApproval
    Inherits System.Web.UI.Page

    Dim InvoiceData As New clsInvoiceDataAccess()
    Dim InvoiceItemData As New clsInvoiceItemDataAccess()
    Dim TotalCost As Double = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "ProcApproval~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then
            ShowInvoicesToApprove()
            btnApprove.Enabled = False
            btnReject.Enabled = False
        End If
    End Sub

    Protected Sub ShowInvoicesToApprove()
        Dim ApproverID As String = Session("EmployeeID")
        grdInvoicesToApprove.DataSource = InvoiceData.fnGetDetailsInvLstToApprove(ApproverID)
        grdInvoicesToApprove.DataBind()
    End Sub

    Protected Sub grdInvoicesToApprove_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdInvoicesToApprove.SelectedIndexChanged
        Dim lblInvoiceID, lblInvoiceNo, lblSupplierName, lblInvoiceDate, lblInvoiceCost, lblSubmittedBy, lblSubmissionDate As New System.Web.UI.WebControls.Label()

        lblInvoiceID = grdInvoicesToApprove.SelectedRow.FindControl("lblInvoiceID")
        lblInvoiceNo = grdInvoicesToApprove.SelectedRow.FindControl("lblInvoiceNo")
        lblSupplierName = grdInvoicesToApprove.SelectedRow.FindControl("lblSupplierName")
        lblInvoiceDate = grdInvoicesToApprove.SelectedRow.FindControl("lblInvoiceDate")
        lblInvoiceCost = grdInvoicesToApprove.SelectedRow.FindControl("lblInvoiceCost")
        lblSubmittedBy = grdInvoicesToApprove.SelectedRow.FindControl("lblSubmittedBy")
        lblSubmissionDate = grdInvoicesToApprove.SelectedRow.FindControl("lblSubmissionDate")


        lblSupplier.Text = lblSupplierName.Text
        lblFrmInvoiceNo.Text = lblInvoiceNo.Text
        lblPurchaseDate.Text = lblInvoiceDate.Text
        lblTotalCost.Text = lblInvoiceCost.Text
        lblPreparedBy.Text = lblSubmittedBy.Text
        lblPreparationDate.Text = lblSubmissionDate.Text

        grdInvoiceItems.DataSource = InvoiceItemData.fnGetItemsByInvoiceAtApp(lblInvoiceID.Text)
        grdInvoiceItems.DataBind()

        btnApprove.Enabled = True
        btnReject.Enabled = True

    End Sub

    Protected Sub grdInvoiceItems_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdInvoiceItems.RowDataBound
        Try
            Dim lblQuantity, lblUnitPrice As New System.Web.UI.WebControls.Label()

            If e.Row.RowType = DataControlRowType.DataRow Then

                lblQuantity = e.Row.FindControl("lblQuantity")
                lblUnitPrice = e.Row.FindControl("lblUnitPrice")

                TotalCost += (Convert.ToDouble(lblQuantity.Text) * Convert.ToDouble(lblUnitPrice.Text))
            End If

            If e.Row.RowType = DataControlRowType.Footer Then
                e.Row.Cells(4).Text = " Total : "
                e.Row.Cells(5).Text = String.Format("{0:N2}", TotalCost)
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApprove.Click

        Dim lblInvoiceID As New System.Web.UI.WebControls.Label()
        lblInvoiceID = grdInvoicesToApprove.SelectedRow.FindControl("lblInvoiceID")

        Dim InvoiceInfo As New clsInvoice()

        InvoiceInfo.InvoiceID = lblInvoiceID.Text
        InvoiceInfo.ApprovedBy = Session("LoginUserID")

        Dim Check As Integer = InvoiceData.fnApproveInvoice(InvoiceInfo)

        If Check = 1 Then
            MessageBox("Invoice Approved")
            ClearProcureApprovalForm()
        Else
            MessageBox("Error Found At Approval.")
        End If

    End Sub

    Protected Sub btnReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReject.Click

        Dim lblInvoiceID As New System.Web.UI.WebControls.Label()
        lblInvoiceID = grdInvoicesToApprove.SelectedRow.FindControl("lblInvoiceID")

        Dim InvoiceInfo As New clsInvoice()

        InvoiceInfo.InvoiceID = lblInvoiceID.Text
        InvoiceInfo.RejectedBy = Session("LoginUserID")

        Dim Check As Integer = InvoiceData.fnRejectInvoice(InvoiceInfo)

        If Check = 1 Then
            MessageBox("Invoice Rejected")
            ClearProcureApprovalForm()
        Else
            MessageBox("Error Found At Approval.")
        End If

    End Sub

    Protected Sub ClearProcureApprovalForm()
        grdInvoicesToApprove.SelectedIndex = -1
        ShowInvoicesToApprove()

        lblSupplier.Text = "N\A"
        lblFrmInvoiceNo.Text = "N\A"
        lblPurchaseDate.Text = "N\A"
        lblTotalCost.Text = "0"
        lblPreparedBy.Text = "N\A"
        lblPreparationDate.Text = "N\A"

        grdInvoiceItems.DataSource = ""
        grdInvoiceItems.DataBind()

        btnApprove.Enabled = False
        btnReject.Enabled = False

    End Sub

    Protected Sub btnCancelSelection_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelSelection.Click
        ClearProcureApprovalForm()
    End Sub

End Class

Imports System.IO
Imports System.IO.StreamWriter

Partial Class AcceptRequisition_frmDeliveredRequisition
    Inherits System.Web.UI.Page

    Dim ItemRequisitionData As New clsItemRequisitionDataAccess()

    Protected Sub drpDeliveryEntryPoint_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpDeliveryEntryPoint.SelectedIndexChanged


    End Sub

    Protected Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub GetRequisitionByEntryPoint(ByVal DeliveryEntryPoint As String, ByVal DateFrom As DateTime, ByVal DateTo As DateTime)
        grdPendingReqListToDeliver.DataSource = ItemRequisitionData.fnGetReqByDeliveryEntryPoint(DeliveryEntryPoint, DateFrom, DateTo)
        grdPendingReqListToDeliver.DataBind()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "DeliveredReq~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If


        If Not IsPostBack Then
            GetDeliveryEntryPoint()
        End If
    End Sub

    Protected Sub GetDeliveryEntryPoint()
        drpDeliveryEntryPoint.DataTextField = "DeliveryEntryPoint"
        drpDeliveryEntryPoint.DataValueField = "DeliveryEntryPoint"
        drpDeliveryEntryPoint.DataSource = ItemRequisitionData.fnGetDeliveryEntryPoint()
        drpDeliveryEntryPoint.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"

        drpDeliveryEntryPoint.Items.Insert(0, A)

    End Sub

    Protected Sub btnExportDeliveredRequisition_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExportDeliveredRequisition.Click
        ExportToExcel(grdPendingReqListToDeliver)
    End Sub

    Protected Sub ExportToExcel(ByVal gridview As System.Web.UI.WebControls.GridView)
        Try
            Dim sw As New StringWriter()
            Dim hw As New System.Web.UI.HtmlTextWriter(sw)
            Dim frm As HtmlForm = New HtmlForm()

            Page.Response.AddHeader("content-disposition", "attachment;ProcurementReport.xls")
            Page.Response.ContentType = "application/vnd.ms-excel"
            Page.Response.Charset = ""
            Page.EnableViewState = False
            frm.Attributes("runat") = "server"
            Controls.Add(frm)
            frm.Controls.Add(gridview)
            frm.RenderControl(hw)
            Response.Write(sw.ToString())
            Response.End()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

    End Sub

    Protected Sub btnProcessReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcessReport.Click
        grdPendingReqListToDeliver.DataSource = ""
        grdPendingReqListToDeliver.DataBind()

        Dim DateFrom, DateTo As DateTime

        Try
            If (txtDateFrom.Text = "" And txtDateTo.Text <> "") Or (txtDateFrom.Text <> "" And txtDateTo.Text = "") Then
                MessageBox("Date From & Date To Both Parameters Required.")
                Exit Sub
            End If

            If txtDateFrom.Text = "" Then
                DateFrom = "1/1/1900"
            Else
                DateFrom = txtDateFrom.Text
            End If

            If txtDateTo.Text = "" Then
                DateTo = "1/1/2099"
            Else
                DateTo = txtDateTo.Text
            End If

            GetRequisitionByEntryPoint(drpDeliveryEntryPoint.SelectedValue, DateFrom, DateTo)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try


    End Sub

End Class

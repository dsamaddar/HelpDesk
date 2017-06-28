Imports System.IO
Imports System.IO.StreamWriter


Partial Class FillupWarehouse_frmItemBalanceStatus
    Inherits System.Web.UI.Page

    Dim ItemData As New clsItemDataAccess()
    Dim InvoiceItemData As New clsInvoiceItemDataAccess()
    Dim WarehouseItemData As New clsWarehouseItemDataAccess()

    Dim ItemBalance As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "ItmBalStat~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then
            GetInventoryItemDetails()
        End If
    End Sub

    Protected Sub GetInventoryItemDetails()
        grdInventoryItems.DataSource = ItemData.fnGetItemListDetails()
        grdInventoryItems.DataBind()
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

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub grdInventoryItems_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdInventoryItems.SelectedIndexChanged

        Dim lblItemID As New System.Web.UI.WebControls.Label()

        lblItemID = grdInventoryItems.SelectedRow.FindControl("lblItemID")

        grdProcurementHistory.DataSource = InvoiceItemData.fnGetProcurementInfoByItem(lblItemID.Text)
        grdProcurementHistory.DataBind()

        grdWarehouseBalance.DataSource = WarehouseItemData.fnWarehouseItemBalanceByItem(lblItemID.Text)
        grdWarehouseBalance.DataBind()

    End Sub


    Protected Sub grdWarehouseBalance_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdWarehouseBalance.RowDataBound


        Dim lblWarehouseItmBalance As New System.Web.UI.WebControls.Label()
        If e.Row.RowType = DataControlRowType.DataRow Then

            lblWarehouseItmBalance = e.Row.FindControl("lblWarehouseItmBalance")
            ItemBalance += Convert.ToInt32(lblWarehouseItmBalance.Text)
        End If

        If e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(1).Text = "Total:"
            e.Row.Cells(3).Text = ItemBalance.ToString
        End If

    End Sub

    Protected Sub btnExportInventoryItems_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExportInventoryItems.Click
        ExportToExcel(grdInventoryItems)
    End Sub

    Protected Sub btnExportProcurementHistory_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExportProcurementHistory.Click
        ExportToExcel(grdProcurementHistory)
    End Sub

    Protected Sub btnExportWarehouseItmBalance_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExportWarehouseItmBalance.Click
        ExportToExcel(grdWarehouseBalance)
    End Sub
End Class

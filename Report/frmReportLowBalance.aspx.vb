Imports System.IO
Imports System.IO.StreamWriter

Partial Class Report_frmReportLowBalance
    Inherits System.Web.UI.Page

    Dim ItemData As New clsItemDataAccess()
    Dim WarehouseItemData As New clsWarehouseItemDataAccess()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "RptlowBal~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then
            GetLowBalanceItemListInfo()
        End If
    End Sub

    Protected Sub GetLowBalanceItemListInfo()
        grdLowBalanceReport.DataSource = ItemData.fnGetLowBalanceItemList()
        grdLowBalanceReport.DataBind()

        If grdLowBalanceReport.Rows.Count > 0 Then
            ShowWarehouseBalanceByItems()
        End If

    End Sub

    Protected Sub ShowWarehouseBalanceByItems()

        Dim lblItemID, lblLowBalanceReport, lblBalance As New System.Web.UI.WebControls.Label()
        Dim grdWarehouseBalance As New System.Web.UI.WebControls.GridView()



        For Each rw As GridViewRow In grdLowBalanceReport.Rows
            lblItemID = rw.FindControl("lblItemID")
            lblLowBalanceReport = rw.FindControl("lblLowBalanceReport")
            lblBalance = rw.FindControl("lblBalance")

            If Convert.ToInt32(lblBalance.Text) < Convert.ToInt32(lblLowBalanceReport.Text) Then
                lblBalance.ForeColor = Drawing.Color.Red
                lblBalance.Font.Bold = True
            End If

            grdWarehouseBalance = rw.FindControl("grdWarehouseBalance")

            grdWarehouseBalance.DataSource = WarehouseItemData.fnWarehouseItemBalanceByItem(lblItemID.Text)
            grdWarehouseBalance.DataBind()
        Next


    End Sub

    Protected Sub btnExportLowBalanceRpt_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExportLowBalanceRpt.Click
        ExportToExcel(grdLowBalanceReport)
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

    Protected Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

End Class

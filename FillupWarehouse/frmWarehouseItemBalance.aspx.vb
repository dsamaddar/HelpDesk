Imports System.IO
Imports System.IO.StreamWriter


Partial Class FillupWarehouse_frmWarehouseItemBalance
    Inherits System.Web.UI.Page

    Dim WarehouseData As New clsWarehouseDataAccess()
    Dim WarehouseItemData As New clsWarehouseItemDataAccess()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "WareBal~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then
            GetWarehouseList()
        End If
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub GetWarehouseList()
        drpWarehouseList.DataTextField = "WarehouseName"
        drpWarehouseList.DataValueField = "WarehouseID"
        drpWarehouseList.DataSource = WarehouseData.fnGetWarehouseList()
        drpWarehouseList.DataBind()

        Dim A As New ListItem

        A.Text = "N\A"
        A.Value = "N\A"
        drpWarehouseList.Items.Insert(0, A)

    End Sub

    Protected Sub drpWarehouseList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpWarehouseList.SelectedIndexChanged

        grdWarehouseBalance.DataSource = ""
        grdWarehouseBalance.DataBind()

        If drpWarehouseList.SelectedValue <> "N\A" Then
            grdWarehouseBalance.DataSource = WarehouseItemData.fnGetWarehouseItemBalance(drpWarehouseList.SelectedValue)
            grdWarehouseBalance.DataBind()
        End If

    End Sub

    Protected Sub btnExportProcurementHistory_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExportProcurementHistory.Click
        ExportToExcel(grdWarehouseBalance)
    End Sub

    Protected Sub ExportToExcel(ByVal gridview As System.Web.UI.WebControls.GridView)
        Try
            Dim sw As New StringWriter()
            Dim hw As New System.Web.UI.HtmlTextWriter(sw)
            Dim frm As HtmlForm = New HtmlForm()

            Page.Response.AddHeader("content-disposition", "attachment;WarehouseBalance.xls")
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

End Class

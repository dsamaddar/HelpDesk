Imports System.IO
Imports System.IO.StreamWriter

Partial Class Report_frmReportRequisition
    Inherits System.Web.UI.Page

    Dim ItemData As New clsItemDataAccess()
    Dim UserData As New clsUserDataAccess()
    Dim DepartmentData As New clsDepartmentDataAccess()
    Dim BranchData As New clsBranchDataAccess()
    Dim ItemRequisitionData As New clsItemRequisitionDataAccess()

    Protected Sub btnShowReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShowReport.Click
        Dim ItemRequisitionInfo As New clsItemRequisition()
        If txtRequisitionDateFrom.Text <> "" And txtRequisitionDateTo.Text = "" Then
            MessageBox("Date To Cann't Be Empty.")
            Exit Sub
        End If

        If txtRequisitionDateFrom.Text = "" And txtRequisitionDateTo.Text <> "" Then
            MessageBox("Date From Cann't Be Empty.")
            Exit Sub
        End If

        If txtRequisitionDateFrom.Text = "" Or txtRequisitionDateTo.Text = "" Then
            ItemRequisitionInfo.DateFrom = "1/1/1900"
            ItemRequisitionInfo.DateTo = "1/1/2099"
        End If

        If txtRequisitionDateFrom.Text <> "" And txtRequisitionDateTo.Text <> "" Then
            If Convert.ToDateTime(txtRequisitionDateFrom.Text) > Convert.ToDateTime(txtRequisitionDateTo.Text) Then
                MessageBox("Invalid Date Parameter. From must be lower Than To Date")
                Exit Sub
            End If
            ItemRequisitionInfo.DateFrom = Convert.ToDateTime(txtRequisitionDateFrom.Text)
            ItemRequisitionInfo.DateTo = Convert.ToDateTime(txtRequisitionDateTo.Text)
        End If

        ItemRequisitionInfo.ULCBranchID = drpBranch.SelectedValue
        ItemRequisitionInfo.Status = drpRequisitionStatus.Text
        ItemRequisitionInfo.DepartmentID = drpDeptList.SelectedValue
        ItemRequisitionInfo.EmployeeID = drpUserList.SelectedValue
        ItemRequisitionInfo.ItemID = drpInventoryItems.SelectedValue

        grdQueryResult.DataSource = ItemRequisitionData.fnShowRequisitionReport(ItemRequisitionInfo)
        grdQueryResult.DataBind()
    End Sub

    Protected Sub ShowItemList()
        drpInventoryItems.DataTextField = "ItemName"
        drpInventoryItems.DataValueField = "ItemID"
        drpInventoryItems.DataSource = ItemData.fnGetItemList()
        drpInventoryItems.DataBind()

        Dim A As New ListItem

        A.Text = "N\A"
        A.Value = "N\A"

        drpInventoryItems.Items.Insert(0, A)

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "RptRequisition~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then
            GetBranchList()
            GetDepartmentList()
            InitializeUserList()
            GetRequisitionStatus()
            ShowItemList()
            txtRequisitionDateFrom.Text = Now.Month.ToString() + "/1/" + Now.Year.ToString()
            txtRequisitionDateTo.Text = Now.Date
        End If
    End Sub

    Protected Sub GetRequisitionStatus()
        drpRequisitionStatus.DataTextField = "Status"
        drpRequisitionStatus.DataValueField = "Status"
        drpRequisitionStatus.DataSource = ItemRequisitionData.fnGetRequisitionStatus()
        drpRequisitionStatus.DataBind()

        Dim A As New ListItem()

        A.Text = "N\A"
        A.Value = "N\A"

        drpRequisitionStatus.Items.Insert(0, A)
    End Sub

    Protected Sub GetBranchList()
        drpBranch.DataTextField = "ULCBranchName"
        drpBranch.DataValueField = "ULCBranchID"
        drpBranch.DataSource = BranchData.fnGetBranchList()
        drpBranch.DataBind()

        Dim A As New ListItem
        A.Value = "N\A"
        A.Text = "N\A"

        drpBranch.Items.Insert(0, A)

    End Sub

    Protected Sub ShowUserList(ByVal DepartmentID As String)

        drpUserList.DataSource = ""
        drpUserList.DataBind()

        drpUserList.DataTextField = "EmployeeName"
        drpUserList.DataValueField = "EmployeeID"
        drpUserList.DataSource = UserData.fnGetReqRemDeptWiseUser(DepartmentID)
        drpUserList.DataBind()

        Dim A As New ListItem()

        A.Text = "N\A"
        A.Value = "N\A"

        drpUserList.Items.Insert(0, A)
    End Sub

    Protected Sub InitializeUserList()
        Dim A As New ListItem
        A.Value = "N\A"
        A.Text = "N\A"

        drpUserList.Items.Insert(0, A)
    End Sub

    Protected Sub GetDepartmentList()

        drpDeptList.DataSource = ""
        drpDeptList.DataBind()

        drpDeptList.DataTextField = "DeptName"
        drpDeptList.DataValueField = "DepartmentID"
        drpDeptList.DataSource = DepartmentData.fnGetDepartmentList()
        drpDeptList.DataBind()

        Dim A As New ListItem
        A.Value = "N\A"
        A.Text = "N\A"

        drpDeptList.Items.Insert(0, A)

    End Sub


    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click

    End Sub

    Protected Sub ClearForm()
        txtRequisitionDateFrom.Text = ""
        txtRequisitionDateTo.Text = ""
        drpUserList.SelectedIndex = -1
        drpDeptList.SelectedIndex = -1
        drpBranch.SelectedIndex = -1

        grdQueryResult.DataSource = ""
        grdQueryResult.DataBind()

    End Sub

    Protected Sub btnExport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExport.Click
        ExportToExcel(grdQueryResult)
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

    Protected Sub drpDeptList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpDeptList.SelectedIndexChanged
        ShowUserList(drpDeptList.SelectedValue)
    End Sub
End Class

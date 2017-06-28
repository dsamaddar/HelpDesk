
Partial Class Administration_frmWarehouseManagement
    Inherits System.Web.UI.Page

    'Dim BranchData As New clsBranchDataAccess()
    Dim ULCBranchData As New clsULCBranchDataAccess()
    Dim WarehouseData As New clsWarehouseDataAccess()

    Protected Sub btnAddWarehouse_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddWarehouse.Click

        If drpBranch.SelectedValue = "N\A" Then
            MessageBox("Select A Branch First.")
            Exit Sub
        End If

        Dim WarehouseInfo As New clsWarehouse()

        WarehouseInfo.WarehouseName = txtWarehouseName.Text
        WarehouseInfo.WarehouseCode = txtWarehouseCode.Text
        WarehouseInfo.BranchID = drpBranch.SelectedValue
        WarehouseInfo.Location = txtLocation.Text
        WarehouseInfo.Details = txtDetails.Text

        If chkIsWarehouseActive.Checked = True Then
            WarehouseInfo.IsActive = True
        Else
            WarehouseInfo.IsActive = False
        End If

        WarehouseInfo.EntryBy = Session("LoginUserID")

        Dim Check As Integer = WarehouseData.fnInsertWarehouse(WarehouseInfo)

        If Check = 1 Then
            MessageBox("Warehouse Inserted.")
            ClearWarehouseForm()
            GetDetailsWarehouseList()
        Else
            MessageBox("Error Found.")
        End If

    End Sub

    Protected Sub GetBranchList()
        drpBranch.DataTextField = "ULCBranchName"
        drpBranch.DataValueField = "ULCBranchID"
        drpBranch.DataSource = ULCBranchData.fnGetULCBranch()
        drpBranch.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        drpBranch.Items.Insert(0, A)
    End Sub

    Protected Sub GetDetailsWarehouseList()
        grdDetailsWarehouseList.DataSource = WarehouseData.fnGetDetailsWarehouseList()
        grdDetailsWarehouseList.DataBind()
    End Sub

    Protected Sub ClearWarehouseForm()

        txtWarehouseName.Text = ""
        txtWarehouseCode.Text = ""
        drpBranch.SelectedIndex = -1
        txtDetails.Text = ""
        txtLocation.Text = ""

        btnAddWarehouse.Visible = True
        btnUpdateWarehouse.Visible = False

        grdDetailsWarehouseList.SelectedIndex = -1

        chkIsWarehouseActive.Checked = False

    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearWarehouseForm()
    End Sub

    Protected Sub btnUpdateWarehouse_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateWarehouse.Click
        If drpBranch.SelectedValue = "N\A" Then
            MessageBox("Select A Branch First.")
            Exit Sub
        End If

        Dim WarehouseInfo As New clsWarehouse()

        WarehouseInfo.WarehouseID = hdFldWareHouseID.Value
        WarehouseInfo.WarehouseName = txtWarehouseName.Text
        WarehouseInfo.WarehouseCode = txtWarehouseCode.Text
        WarehouseInfo.BranchID = drpBranch.SelectedValue
        WarehouseInfo.Location = txtLocation.Text
        WarehouseInfo.Details = txtDetails.Text

        If chkIsWarehouseActive.Checked = True Then
            WarehouseInfo.IsActive = True
        Else
            WarehouseInfo.IsActive = False
        End If

        WarehouseInfo.EntryBy = Session("LoginUserID")

        Dim Check As Integer = WarehouseData.fnUpdateWarehouse(WarehouseInfo)

        If Check = 1 Then
            MessageBox("Updated Successfully.")
            ClearWarehouseForm()
            GetDetailsWarehouseList()
        Else
            MessageBox("Error Found.")
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "MngWarehouse~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then
            btnAddWarehouse.Visible = True
            btnUpdateWarehouse.Visible = False
            GetBranchList()
            GetDetailsWarehouseList()
        End If
    End Sub

    Protected Sub grdDetailsWarehouseList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdDetailsWarehouseList.SelectedIndexChanged
        btnUpdateWarehouse.Visible = True
        btnAddWarehouse.Visible = False

        Dim lblWarehouseID, lblWarehouseName, lblWarehouseCode, lblBranchID, lblLocation, lblDetails, lblIsActive As New System.Web.UI.WebControls.Label()

        lblWarehouseID = grdDetailsWarehouseList.SelectedRow.FindControl("lblWarehouseID")
        lblWarehouseName = grdDetailsWarehouseList.SelectedRow.FindControl("lblWarehouseName")
        lblWarehouseCode = grdDetailsWarehouseList.SelectedRow.FindControl("lblWarehouseCode")
        lblBranchID = grdDetailsWarehouseList.SelectedRow.FindControl("lblBranchID")
        lblLocation = grdDetailsWarehouseList.SelectedRow.FindControl("lblLocation")
        lblDetails = grdDetailsWarehouseList.SelectedRow.FindControl("lblDetails")
        lblIsActive = grdDetailsWarehouseList.SelectedRow.FindControl("lblIsActive")

        hdFldWareHouseID.Value = lblWarehouseID.Text
        txtWarehouseName.Text = lblWarehouseName.Text
        txtWarehouseCode.Text = lblWarehouseCode.Text
        drpBranch.SelectedValue = lblBranchID.Text
        txtLocation.Text = lblLocation.Text
        txtDetails.Text = lblDetails.Text

        If lblIsActive.Text = "YES" Then
            chkIsWarehouseActive.Checked = True
        Else
            chkIsWarehouseActive.Checked = False
        End If

    End Sub

End Class

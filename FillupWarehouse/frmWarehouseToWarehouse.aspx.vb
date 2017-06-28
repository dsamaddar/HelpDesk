Imports System
Imports System.Data
Imports System.Data.SqlClient

Partial Class FillupWarehouse_frmWarehouseToWarehouse
    Inherits System.Web.UI.Page

    Dim WarehouseData As New clsWarehouseDataAccess()
    Dim WarehouseItemData As New clsWarehouseItemDataAccess()

    Protected Function FormatWarehouseToWarehouse() As DataTable
        Dim dt As DataTable = New DataTable()
        dt.Columns.Add("SourceWarehouseID", System.Type.GetType("System.String"))
        dt.Columns.Add("SourceWarehouse", System.Type.GetType("System.String"))
        dt.Columns.Add("DestWarehouseID", System.Type.GetType("System.String"))
        dt.Columns.Add("DestWarehouse", System.Type.GetType("System.String"))
        dt.Columns.Add("ItemID", System.Type.GetType("System.String"))
        dt.Columns.Add("ItemName", System.Type.GetType("System.String"))
        dt.Columns.Add("TransferQuantity", System.Type.GetType("System.Decimal"))
        Return dt
    End Function

    Protected Sub drpSourceWarehouse_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpSourceWarehouse.SelectedIndexChanged
        grdSourceWarehouseBalance.DataSource = ""
        grdSourceWarehouseBalance.DataBind()

        If drpSourceWarehouse.SelectedValue <> "N\A" Then
            grdSourceWarehouseBalance.DataSource = WarehouseItemData.fnGetWarehouseItemBalance(drpSourceWarehouse.SelectedValue)
            grdSourceWarehouseBalance.DataBind()
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "WareToWare~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If


        If Not IsPostBack Then

            Session("dtWareToWareBalTransfer") = ""

            Dim dtWareToWareBalTransfer As DataTable = New DataTable()
            dtWareToWareBalTransfer = FormatWarehouseToWarehouse()
            Session("dtWareToWareBalTransfer") = dtWareToWareBalTransfer

            GetWarehouseList()

            btnTransfer.Enabled = False
        End If
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnADDToCart_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnADDToCart.Click

        If drpSourceWarehouse.SelectedValue = drpDestinationWarehouse.SelectedValue Then
            MessageBox("Souce And Destination Warehouse Cann't be Same.")
            Exit Sub
        End If

        If drpSourceWarehouse.SelectedValue = "N\A" Or drpDestinationWarehouse.SelectedValue = "N\A" Then
            MessageBox("Select Valid Warehouse.")
            Exit Sub
        End If

        If grdSourceWarehouseBalance.SelectedIndex = -1 Then
            MessageBox("Select An Item From Source.")
            Exit Sub
        End If

        If Convert.ToInt32(txtAvailableBalance.Text) < Convert.ToInt32(txtTransferBalance.Text) Then
            txtTransferBalance.Text = ""
            MessageBox("Transfer Balance Excedes Available Balance.")
            Exit Sub
        End If

        If Convert.ToInt32(txtTransferBalance.Text) <= 0 Then
            MessageBox("Transfer Balance Cann't be Less Than Or Equal To 0.")
            txtTransferBalance.Text = ""
            Exit Sub
        End If

        Dim lblSrcItemID, lblSrcItemName As New System.Web.UI.WebControls.Label()
        lblSrcItemID = grdSourceWarehouseBalance.SelectedRow.FindControl("lblSrcItemID")
        lblSrcItemName = grdSourceWarehouseBalance.SelectedRow.FindControl("lblSrcItemName")

        Dim WareToWareBalTranInfo As New clsWareToWareBalTransfer()

        WareToWareBalTranInfo.SourceWarehouseID = drpSourceWarehouse.SelectedValue
        WareToWareBalTranInfo.SourceWarehouse = drpSourceWarehouse.SelectedItem.Text
        WareToWareBalTranInfo.DestWarehouseID = drpDestinationWarehouse.SelectedValue
        WareToWareBalTranInfo.DestWarehouse = drpDestinationWarehouse.SelectedItem.Text
        WareToWareBalTranInfo.ItemID = lblSrcItemID.Text
        WareToWareBalTranInfo.ItemName = lblSrcItemName.Text
        WareToWareBalTranInfo.TransferQuantity = Convert.ToInt32(txtTransferBalance.Text)

        Dim dtWareToWareBalTransfer As DataTable = New DataTable()
        dtWareToWareBalTransfer = AddToCartWareToWare(WareToWareBalTranInfo)
        Session("dtWareToWareBalTransfer") = dtWareToWareBalTransfer

        grdDestinationWarehouseBalance.DataSource = dtWareToWareBalTransfer
        grdDestinationWarehouseBalance.DataBind()

        If grdDestinationWarehouseBalance.Rows.Count > 0 Then
            btnTransfer.Enabled = True
        Else
            btnTransfer.Enabled = False
        End If

        ClearAddToCartInfo()

    End Sub

    Protected Function AddToCartWareToWare(ByVal WareToWareBalTranInfo As clsWareToWareBalTransfer) As DataTable

        Dim dtWareToWareBalTransfer As DataTable = New DataTable()
        dtWareToWareBalTransfer = Session("dtWareToWareBalTransfer")

        '' Chq If Item Already Exists

        If ChqItemAlreadyExists(WareToWareBalTranInfo) = 1 Then
            MessageBox("Item Already In The List.")
            Return dtWareToWareBalTransfer
        End If

        Dim dr As DataRow
        dr = dtWareToWareBalTransfer.NewRow()
        dr("SourceWarehouseID") = WareToWareBalTranInfo.SourceWarehouseID
        dr("SourceWarehouse") = WareToWareBalTranInfo.SourceWarehouse
        dr("DestWarehouseID") = WareToWareBalTranInfo.DestWarehouseID
        dr("DestWarehouse") = WareToWareBalTranInfo.DestWarehouse
        dr("ItemID") = WareToWareBalTranInfo.ItemID
        dr("ItemName") = WareToWareBalTranInfo.ItemName
        dr("TransferQuantity") = WareToWareBalTranInfo.TransferQuantity

        dtWareToWareBalTransfer.Rows.Add(dr)
        dtWareToWareBalTransfer.AcceptChanges()
        Return dtWareToWareBalTransfer

    End Function

    Protected Sub ClearAddToCartInfo()
        txtAvailableBalance.Text = ""
        txtTransferBalance.Text = ""
        grdSourceWarehouseBalance.SelectedIndex = -1
    End Sub

    Protected Function ChqItemAlreadyExists(ByVal WareToWareBalTranInfo As clsWareToWareBalTransfer) As Integer

        Dim lblSourceWarehouseID, lblDestWarehouseID, lblDestItemID As New System.Web.UI.WebControls.Label()

        For Each rw As GridViewRow In grdDestinationWarehouseBalance.Rows
            lblSourceWarehouseID = rw.FindControl("lblSourceWarehouseID")
            lblDestWarehouseID = rw.FindControl("lblDestWarehouseID")
            lblDestItemID = rw.FindControl("lblDestItemID")

            If lblSourceWarehouseID.Text = WareToWareBalTranInfo.SourceWarehouseID And lblDestWarehouseID.Text = WareToWareBalTranInfo.DestWarehouseID And lblDestItemID.Text = WareToWareBalTranInfo.ItemID Then
                Return 1
            End If

        Next

        Return 0

    End Function

    Protected Sub GetWarehouseList()
        drpSourceWarehouse.DataTextField = "WarehouseName"
        drpSourceWarehouse.DataValueField = "WarehouseID"
        drpSourceWarehouse.DataSource = WarehouseData.fnGetWarehouseList()
        drpSourceWarehouse.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        drpSourceWarehouse.Items.Insert(0, A)

        drpDestinationWarehouse.DataTextField = "WarehouseName"
        drpDestinationWarehouse.DataValueField = "WarehouseID"
        drpDestinationWarehouse.DataSource = WarehouseData.fnGetWarehouseList()
        drpDestinationWarehouse.DataBind()

        drpDestinationWarehouse.Items.Insert(0, A)

    End Sub

    Protected Sub grdSourceWarehouseBalance_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdSourceWarehouseBalance.SelectedIndexChanged

        txtAvailableBalance.Text = ""
        txtTransferBalance.Text = ""

        Dim AvailableItemBalance As Integer = 0
        Dim lblSrcItemID, lblSrcBalance As New System.Web.UI.WebControls.Label()
        lblSrcItemID = grdSourceWarehouseBalance.SelectedRow.FindControl("lblSrcItemID")
        lblSrcBalance = grdSourceWarehouseBalance.SelectedRow.FindControl("lblSrcBalance")

        If Convert.ToInt32(lblSrcBalance.Text) = 0 Then
            MessageBox("You Cann't Select This Item. Balance Is 0.")
            grdSourceWarehouseBalance.SelectedIndex = -1
            Exit Sub
        End If

        AvailableItemBalance = Convert.ToInt32(lblSrcBalance.Text)

        Dim lblSourceWarehouseID, lblDestItemID, lblDestTransferQuantity As New System.Web.UI.WebControls.Label()

        If grdDestinationWarehouseBalance.Rows.Count > 0 Then
            For Each rw As GridViewRow In grdDestinationWarehouseBalance.Rows
                lblSourceWarehouseID = rw.FindControl("lblSourceWarehouseID")
                lblDestItemID = rw.FindControl("lblDestItemID")
                lblDestTransferQuantity = rw.FindControl("lblDestTransferQuantity")

                If lblSourceWarehouseID.Text = drpSourceWarehouse.SelectedValue And lblDestItemID.Text = lblSrcItemID.Text Then
                    AvailableItemBalance -= Convert.ToInt32(lblDestTransferQuantity.Text)
                End If

            Next
        End If

        txtAvailableBalance.Text = AvailableItemBalance.ToString()


    End Sub

    Protected Sub grdDestinationWarehouseBalance_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles grdDestinationWarehouseBalance.RowDeleting

        Dim i As Integer
        Dim dtWareToWareBalTransfer As DataTable = New DataTable()

        dtWareToWareBalTransfer = Session("dtWareToWareBalTransfer")

        i = e.RowIndex

        dtWareToWareBalTransfer.Rows(i).Delete()
        dtWareToWareBalTransfer.AcceptChanges()

        Session("dtWareToWareBalTransfer") = dtWareToWareBalTransfer

        grdDestinationWarehouseBalance.DataSource = dtWareToWareBalTransfer
        grdDestinationWarehouseBalance.DataBind()

        If grdDestinationWarehouseBalance.Rows.Count > 0 Then
            btnTransfer.Enabled = True
        Else
            btnTransfer.Enabled = False
        End If

    End Sub

    Protected Sub btnTransfer_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnTransfer.Click

        Dim WTWBalTrans As New clsWareToWareBalTransfer()
        Dim WareToWareBalTransList As String = ""
        Dim lblSourceWarehouseID, lblDestWarehouseID, lblDestItemID, lblDestTransferQuantity As New System.Web.UI.WebControls.Label()

        For Each rw As GridViewRow In grdDestinationWarehouseBalance.Rows
            lblSourceWarehouseID = rw.FindControl("lblSourceWarehouseID")
            lblDestWarehouseID = rw.FindControl("lblDestWarehouseID")
            lblDestItemID = rw.FindControl("lblDestItemID")
            lblDestTransferQuantity = rw.FindControl("lblDestTransferQuantity")

            WareToWareBalTransList += lblSourceWarehouseID.Text & "~" & lblDestWarehouseID.Text & "~" & lblDestItemID.Text & "~" & lblDestTransferQuantity.Text & "~|"
        Next

        WTWBalTrans.WareToWareBalTransList = WareToWareBalTransList
        WTWBalTrans.EntryBy = Session("LoginUserID")

        Dim Check As Integer = WarehouseItemData.fnWareToWareBalTransferList(WTWBalTrans)

        If Check = 1 Then
            MessageBox("Transfered Successfully.")
            ClearForm()
        Else
            MessageBox("Error Found.")
        End If

    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearForm()
    End Sub

    Protected Sub ClearForm()
        Session("dtWareToWareBalTransfer") = ""

        Dim dtWareToWareBalTransfer As DataTable = New DataTable()
        dtWareToWareBalTransfer = FormatWarehouseToWarehouse()
        Session("dtWareToWareBalTransfer") = dtWareToWareBalTransfer

        grdDestinationWarehouseBalance.DataSource = ""
        grdDestinationWarehouseBalance.DataBind()

        grdSourceWarehouseBalance.DataSource = ""
        grdSourceWarehouseBalance.DataBind()

        drpDestinationWarehouse.SelectedIndex = -1
        drpSourceWarehouse.SelectedIndex = -1

        txtAvailableBalance.Text = ""
        txtTransferBalance.Text = ""

        btnTransfer.Enabled = False
    End Sub

End Class

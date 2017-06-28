
Partial Class Procurement_frmMakeProcurementRequest
    Inherits System.Web.UI.Page

    Dim ItemData As New clsItemDataAccess()

    Protected Sub btnAddItems_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddItems.Click

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ShowItemList()
        End If
    End Sub

    Protected Sub ShowItemList()
        drpItemList.DataTextField = "ItemName"
        drpItemList.DataValueField = "ItemID"
        drpItemList.DataSource = ItemData.fnGetItemList()
        drpItemList.DataBind()

        Dim A As New ListItem

        A.Text = "N\A"
        A.Value = "N\A"

        drpItemList.Items.Insert(0, A)

    End Sub

End Class

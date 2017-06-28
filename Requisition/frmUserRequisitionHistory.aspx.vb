
Partial Class Requisition_frmUserRequisitionHistory
    Inherits System.Web.UI.Page

    Dim ItemRequisitionData As New clsItemRequisitionDataAccess()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "ReqHistory~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then
            GetRequisitionHistoryByUser()
        End If
    End Sub

    Protected Sub GetRequisitionHistoryByUser()
        Dim ItemReqInfo As New clsItemRequisition()

        ItemReqInfo.EmployeeID = Session("EmployeeID")
        grdUserRequisitionList.DataSource = ItemRequisitionData.fnGetReqHistoryByUserID(ItemReqInfo)
        grdUserRequisitionList.DataBind()
    End Sub


End Class


Partial Class Requisition_frmReturnRequisition
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "ReqHistory~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

    End Sub

End Class

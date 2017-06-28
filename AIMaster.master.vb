
Partial Class AIMaster
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            Try
                lblLoggedInUser.Text = "Welcome " + Session("EmployeeName")

                Dim mnu As New Menu
                Dim MenuIDs As String

                mnu = Me.FindControl("mnuControl")
                MenuIDs = Session("PermittedMenus")

                mnu.Items(0).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "ItmReq~"), True, False)
                mnu.Items(0).ChildItems(1).Enabled = IIf(InStr(MenuIDs, "AppReq~"), True, False)
                mnu.Items(0).ChildItems(2).Enabled = IIf(InStr(MenuIDs, "OnDemandReq~"), True, False)

                mnu.Items(1).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "AcptReq~"), True, False)
                mnu.Items(1).ChildItems(1).Enabled = IIf(InStr(MenuIDs, "AdvAcptReq~"), True, False)
                mnu.Items(1).ChildItems(2).Enabled = IIf(InStr(MenuIDs, "DelReq~"), True, False)

                mnu.Items(2).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "GenInv~"), True, False)
                mnu.Items(2).ChildItems(1).Enabled = IIf(InStr(MenuIDs, "ProcInput~"), True, False)
                mnu.Items(2).ChildItems(2).Enabled = IIf(InStr(MenuIDs, "ProcApproval~"), True, False)

                mnu.Items(3).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "ProcToWare~"), True, False)
                mnu.Items(3).ChildItems(1).Enabled = IIf(InStr(MenuIDs, "WareToWare~"), True, False)

                mnu.Items(4).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "ReqHistory~"), True, False)
                mnu.Items(4).ChildItems(1).Enabled = IIf(InStr(MenuIDs, "DeliveredReq~"), True, False)
                mnu.Items(4).ChildItems(2).Enabled = IIf(InStr(MenuIDs, "RptProcurement~"), True, False)
                mnu.Items(4).ChildItems(3).Enabled = IIf(InStr(MenuIDs, "RptRequisition~"), True, False)
                mnu.Items(4).ChildItems(4).Enabled = IIf(InStr(MenuIDs, "RptlowBal~"), True, False)
                mnu.Items(4).ChildItems(5).Enabled = IIf(InStr(MenuIDs, "WareBal~"), True, False)
                mnu.Items(4).ChildItems(6).Enabled = IIf(InStr(MenuIDs, "ItmBalStat~"), True, False)

                'mnu.Items(0).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "DesigDef~"), True, False)
                'mnu.Items(5).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "MngBranch~"), True, False)
                'mnu.Items(5).ChildItems(1).Enabled = IIf(InStr(MenuIDs, "DeptDef~"), True, False)
                mnu.Items(5).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "MngWarehouse~"), True, False)
                mnu.Items(5).ChildItems(1).Enabled = IIf(InStr(MenuIDs, "MngItm~"), True, False)
                mnu.Items(5).ChildItems(2).Enabled = IIf(InStr(MenuIDs, "MngItmUnit~"), True, False)
                mnu.Items(5).ChildItems(3).Enabled = IIf(InStr(MenuIDs, "SupplierDef~"), True, False)
                'mnu.Items(5).ChildItems(4).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "MngUser~"), True, False)
                mnu.Items(5).ChildItems(4).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "MngRole~"), True, False)
                mnu.Items(5).ChildItems(4).ChildItems(1).Enabled = IIf(InStr(MenuIDs, "MngPermission~"), True, False)
                mnu.Items(5).ChildItems(4).ChildItems(2).Enabled = IIf(InStr(MenuIDs, "UsrWiseRole~"), True, False)
                mnu.Items(5).ChildItems(5).Enabled = IIf(InStr(MenuIDs, "EmpInfo~"), True, False)
                mnu.Items(5).ChildItems(6).Enabled = IIf(InStr(MenuIDs, "AddNewlyAddEmp~"), True, False)
                mnu.Items(5).ChildItems(7).Enabled = IIf(InStr(MenuIDs, "EmpSync~"), True, False)
            Catch ex As Exception
                MessageBox(ex.Message)
            End Try
        End If
    End Sub



    Protected Sub lnkBtnLogOut_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkBtnLogOut.Click
        Session("UniqueUserID") = ""
        Session("EmployeeName") = ""
        Session("LoginUserID") = ""
        Session("PermittedMenus") = ""

        Response.Redirect("~\frmAILogin.aspx")

    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

End Class


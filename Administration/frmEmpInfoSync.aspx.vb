
Partial Class Administration_frmEmpInfoSync
    Inherits System.Web.UI.Page

    Dim EmpData As New clsEmployeeInfoDataAccess()

    Protected Sub bynSync_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles bynSync.Click

        Dim EmpInfo As New clsEmployeeInfo()
        Dim result As New clsResult()
        Dim lblEmployeeID As New Label
        Dim chkSelectEmp As New CheckBox
        Dim Exists As Boolean = False
        Dim str As String = ""

        For Each dr As GridViewRow In grdEmployeeInfo.Rows
            chkSelectEmp = dr.FindControl("chkSelectEmp")
            If chkSelectEmp.Checked = True Then
                Exists = True

                lblEmployeeID = dr.FindControl("lblEmployeeID")
                EmpInfo = EmpData.fnGetEmpInfoForChaser(lblEmployeeID.Text)

                result = EmpData.fnSyncEmpInfo(EmpInfo)

                If result.Success = True Then
                    chkSelectEmp.Checked = False
                Else
                    Exit For
                End If


            End If

        Next

        If Exists = False Then
            MessageBox("Select An Employee First.")
            Exit Sub
        Else
            MessageBox(result.Message)
            GetAllEmpDetails()
        End If

    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "EmpSync~") = 0 Then
            Response.Redirect("~\frmAILogin.aspx")
        End If

        If Not IsPostBack Then
            GetAllEmpDetails()
        End If
    End Sub

    Protected Sub GetAllEmpDetails()
        grdEmployeeInfo.DataSource = EmpData.fnGetAllEmpDetails()
        grdEmployeeInfo.DataBind()
    End Sub

    Protected Sub chkSelectHeader_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim chkSelectHeader, chkSelectEmp As CheckBox
        chkSelectHeader = grdEmployeeInfo.HeaderRow.FindControl("chkSelectHeader")

        If chkSelectHeader.Checked = True Then
            For Each dr As GridViewRow In grdEmployeeInfo.Rows
                chkSelectEmp = dr.FindControl("chkSelectEmp")
                chkSelectEmp.Checked = True
            Next
        Else
            For Each dr As GridViewRow In grdEmployeeInfo.Rows
                chkSelectEmp = dr.FindControl("chkSelectEmp")
                chkSelectEmp.Checked = False
            Next
        End If

    End Sub

End Class

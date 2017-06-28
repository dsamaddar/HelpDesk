
Partial Class frmAILogin
    Inherits System.Web.UI.Page

    Dim EmpData As New clsEmployeeInfoDataAccess()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Session("UniqueUserID") = ""
            Session("EmployeeName") = ""
            Session("LoginUserID") = ""
            Session("PermittedMenus") = ""
        End If
    End Sub

    Protected Sub btnLogin_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLogin.Click

        Dim EmpInfo As New clsEmployeeInfo()

        EmpInfo.UserID = txtUserID.Text
        EmpInfo.UserPassword = txtPassword.Text

        Try
            EmpInfo = EmpData.fnCheckUserLogin(EmpInfo)

            If EmpInfo.UserID = "" Or EmpInfo.EmployeeName = "" Or EmpInfo.EmployeeID = "" Then
                MessageBox("Incorrect UserID/Password")
                txtUserID.Text = ""
                txtPassword.Text = ""
            Else
                Session("EmployeeID") = EmpInfo.EmployeeID
                Session("EmployeeName") = EmpInfo.EmployeeName
                Session("LoginUserID") = EmpInfo.UserID
                Session("UserType") = EmpInfo.UserType
                Session("PermittedMenus") = EmpInfo.PermittedMenus

                If EmpInfo.UserType = "Admin" Then
                    Response.Redirect("~\frmAIHome.aspx")
                Else
                    Response.Redirect("~\Requisition\frmRequisitionGen.aspx")
                End If

            End If
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

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        txtUserID.Text = ""
        txtPassword.Text = ""
    End Sub

End Class

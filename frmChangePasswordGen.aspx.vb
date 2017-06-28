
Partial Class frmChangePasswordGen
    Inherits System.Web.UI.Page

    Dim UserData As New clsUserDataAccess()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txtOldPassword.Attributes.Add("value", "")
            txtNewPassword.Attributes("value") = ""
            txtConfirmPassword.Attributes("value") = ""
        End If
    End Sub

    Protected Sub btnChangePassword_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnChangePassword.Click
        If txtNewPassword.Text <> txtConfirmPassword.Text Then
            MessageBox("Password Mismatch.")
            txtNewPassword.Text = ""
            txtConfirmPassword.Text = ""
            Exit Sub
        End If

        Dim IsValid As Integer = 0

        Dim UserInfo As New clsUsers()
        UserInfo.EmployeeID = Session("EmployeeID")
        UserInfo.UserPassword = txtOldPassword.Text
        UserInfo.ChangedPassword = txtNewPassword.Text

        IsValid = UserData.fnValidateOldPassword(UserInfo)

        If IsValid = 0 Then
            MessageBox("Existing Password is Invalid now. Please ReLogin With New Password.")
            ClearChangePasswdForm()
            Exit Sub
        Else
            Dim Check As Integer = UserData.fnChangePassword(UserInfo)

            If Check = 1 Then
                MessageBox("Password Changed Successfully.")
                ClearChangePasswdForm()
            Else
                MessageBox("Error Found In Changing Password.")
            End If
        End If
    End Sub

    Protected Sub ClearChangePasswdForm()
        txtConfirmPassword.Text = ""
        txtNewPassword.Text = ""
        txtOldPassword.Text = ""
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearChangePasswdForm()
    End Sub
End Class

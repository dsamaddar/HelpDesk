<%@ Page Language="VB" AutoEventWireup="false" CodeFile="frmAILogin.aspx.vb" Inherits="frmAILogin" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>.:Help Desk:Login:.</title>
    <link href="Sources/css/AICssClass.css" rel="stylesheet" type="text/css" />
    <link href="Sources/css/ValidatorStyle.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <table style="width: 100%;">
        <tr align="center">
            <td style="width: 10%">
            </td>
            <td>
                <asp:Image ID="Image1" runat="server" Height="100px" ImageUrl="~/Sources/images/helpdeskrefl.jpg"
                    Width="100%" />
            </td>
            <td style="width: 10%">
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
            <td>
                <table style="width: 100%;">
                    <tr align="center">
                        <td style="background-color: #009900; color: #FFFFFF; font-weight: bold; font-style: normal;
                            font-size: x-large;">
                            Use Your Windows ID to Login
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Panel ID="pnlLogin" runat="server" Width="500px">
                                <table style="width: 100%;">
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:ScriptManager ID="ScriptManager1" runat="server">
                                            </asp:ScriptManager>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td class="label">
                                            User ID
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtUserID" runat="server" Width="200px" CssClass="InputTxtBox"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqFldUserID" runat="server" ErrorMessage="User ID Required"
                                                ControlToValidate="txtUserID" Display="None" ValidationGroup="LogInValidation"></asp:RequiredFieldValidator>
                                            <cc1:ValidatorCalloutExtender ID="reqFldUserID_ValidatorCalloutExtender" runat="server"
                                                Enabled="True" TargetControlID="reqFldUserID" CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png"
                                                WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                            </cc1:ValidatorCalloutExtender>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td class="label">
                                            Password
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPassword" runat="server" CssClass="InputTxtBox" Width="200px"
                                                TextMode="Password"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqFldPassword" runat="server" ErrorMessage="Password Required"
                                                ControlToValidate="txtPassword" Display="None" ValidationGroup="LogInValidation"></asp:RequiredFieldValidator>
                                            <cc1:ValidatorCalloutExtender ID="reqFldPassword_ValidatorCalloutExtender" runat="server"
                                                Enabled="True" TargetControlID="reqFldPassword" CssClass="customCalloutStyle"
                                                CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                            </cc1:ValidatorCalloutExtender>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="styled-button-1"
                                                ValidationGroup="LogInValidation" />
                                            &nbsp;<asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="styled-button-1" />
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
            <td>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>

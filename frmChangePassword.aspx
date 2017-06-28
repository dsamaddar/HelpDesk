<%@ Page Language="VB" Theme="CommonSkin"  MasterPageFile="~/AIMaster.master" AutoEventWireup="false" CodeFile="frmChangePassword.aspx.vb" Inherits="frmChangePassword" title=".:Help Desk:Change Password:." %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width:100%;">
        <tr align="center" >
            <td>
                <asp:Panel ID="pnlChangePassword" runat="server" Width="100%" 
                    SkinID="pnlInner" >
                    <table style="width:100%;">
                        <tr align="left" >
                            <td colspan="4">
                                <div class="widgettitle">Change Password<asp:ScriptManager ID="ScriptManager1" 
                                        runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width:20px"></td>
                            <td style="width:150px;"></td>
                            <td style="width:230px"></td>
                            <td></td>
                        </tr>
                        <tr align="left" >
                            <td>
                            </td>
                            <td class="label">
                                Old password</td>
                            <td>
                                <asp:TextBox ID="txtOldPassword" runat="server" CssClass="InputTxtBox" 
                                    TextMode="Password" Width="200px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldOldPassword" runat="server" 
                                    ControlToValidate="txtOldPassword" ErrorMessage="Old Password Required" 
                                    ValidationGroup="ChangePassword" Display="None"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldOldPassword_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldOldPassword"  CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png" >
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left" >
                            <td>
                            </td>
                            <td class="label">
                                New Password</td>
                            <td>
                                <asp:TextBox ID="txtNewPassword" runat="server" CssClass="InputTxtBox" 
                                    TextMode="Password" Width="200px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldNewPassword" runat="server" 
                                    ControlToValidate="txtNewPassword" ErrorMessage="New Password Required" 
                                    ValidationGroup="ChangePassword" Display="None"></asp:RequiredFieldValidator>
                              
                                <cc1:ValidatorCalloutExtender ID="reqFldNewPassword_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldNewPassword" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png" >
                                </cc1:ValidatorCalloutExtender>
                                &nbsp;<asp:RegularExpressionValidator ID="regExpNewPassword" runat="server" 
                                    ControlToValidate="txtNewPassword" Display="None" 
                                    ErrorMessage="Validates a strong password. It must be between 6 and 15 characters, contain at least one digit and one alphabetic character, and must not contain special characters." 
                                    ValidationExpression="(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{6,15})$" 
                                    ValidationGroup="ChangePassword"></asp:RegularExpressionValidator>
                                <cc1:ValidatorCalloutExtender ID="regExpNewPassword_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" 
                                    TargetControlID="regExpNewPassword" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                              
                            </td>
                        </tr>
                        <tr align="left" >
                            <td>
                            </td>
                            <td class="label">
                                Confirm Password</td>
                            <td>
                                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="InputTxtBox" 
                                    TextMode="Password" Width="200px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldConfirmPassword" runat="server" 
                                    ControlToValidate="txtConfirmPassword" ErrorMessage="Confirm Password Required" 
                                    ValidationGroup="ChangePassword" Display="None"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldConfirmPassword_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldConfirmPassword"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png" >
                                </cc1:ValidatorCalloutExtender>
                                &nbsp;<asp:RegularExpressionValidator ID="regExpConfirmPassword" runat="server" 
                                    ControlToValidate="txtConfirmPassword" Display="None" 
                                    ErrorMessage="Validates a strong password. It must be between 6 and 15 characters, contain at least one digit and one alphabetic character, and must not contain special characters." 
                                    ValidationExpression="(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{6,15})$" 
                                    ValidationGroup="ChangePassword"></asp:RegularExpressionValidator>
                                <cc1:ValidatorCalloutExtender ID="regExpNewPassword_ValidatorCalloutExtender2" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" 
                                    TargetControlID="regExpNewPassword" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnChangePassword" runat="server" CssClass="styled-button-1" 
                                    Text="Change Password" ValidationGroup="ChangePassword" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" 
                                    Text="Cancel" />
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr  align="center" >
            <td>
            </td>
        </tr>
    </table>
</asp:Content>


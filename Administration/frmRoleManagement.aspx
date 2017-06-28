<%@ Page Language="VB" Theme="CommonSkin"  MasterPageFile="~/AIMaster.master" AutoEventWireup="false" CodeFile="frmRoleManagement.aspx.vb" Inherits="Administration_frmRoleManagement" title=".:Help Desk:Role Management:." %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width:100%;">
        <tr align="center" >
            <td>
                <asp:Panel ID="pnlRoleManagement" runat="server" Width="100%" 
                    SkinID="pnlInner">
                    <table style="width:100%;">
                        <tr align="left" >
                            <td colspan="4">
                                <div class="widgettitle">Role Management<asp:ScriptManager ID="ScriptManager1" 
                                        runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width:20px">
                                &nbsp;</td>
                            <td style="width:150px">
                                &nbsp;</td>
                            <td style="width:230px">
                                <asp:HiddenField ID="hdFldRoleID" runat="server" />
                            </td>
                            <td style="width:300px">
                                &nbsp;</td>
                        </tr>
                        <tr align="left" >
                            <td>
                            </td>
                            <td class="label">
                                Role Name</td>
                            <td>
                                <asp:TextBox ID="txtRoleName" runat="server" CssClass="InputTxtBox" 
                                    Width="200px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldRoleName" runat="server" 
                                    ControlToValidate="txtRoleName" Display="None" 
                                    ErrorMessage="Role Name Required" ValidationGroup="AddRole"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldRoleName_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldRoleName">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left" >
                            <td>
                            </td>
                            <td class="label">
                                Is Active</td>
                            <td>
                                <asp:CheckBox ID="chkRoleIsActive" runat="server" Text="Is Active" 
                                    CssClass="chkText" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left" >
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnInserRole" runat="server" Text="Insert Role" 
                                    CssClass="styled-button-1" ValidationGroup="AddRole" />
                                &nbsp;<asp:Button ID="btnUpdateRole" runat="server" Text="Update Role" 
                                    CssClass="styled-button-1" Visible="False" ValidationGroup="AddRole" />
                                &nbsp;<asp:Button ID="btnCancelSelection" runat="server" Text="Cancel" 
                                    CssClass="styled-button-1" />
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center" >
            <td>
                <asp:Panel ID="pnlRoleList" runat="server" SkinID="pnlInner" Width="100%">
                    <div style="max-height:300px;max-width:680px;overflow:auto">
                        <asp:GridView ID="grdRoleList" runat="server" AutoGenerateColumns="False" 
                            CellPadding="4" ForeColor="#333333" GridLines="None" CssClass="mGrid">
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <Columns>
                                <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                            CommandName="Select" Text="Select"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="RoleID" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRoleID" runat="server" Text='<%# Bind("RoleID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("RoleID") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="RoleName">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRoleName" runat="server" Text='<%# Bind("RoleName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("RoleName") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="isActive">
                                    <ItemTemplate>
                                        <asp:Label ID="lblisActive" runat="server" Text='<%# Bind("isActive") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("isActive") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CreatedBy">
                                    <ItemTemplate>
                                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("CreatedBy") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("CreatedBy") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CreatedDate">
                                    <ItemTemplate>
                                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("CreatedDate") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("CreatedDate") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <EditRowStyle BackColor="#999999" />
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center" >
            <td>
                </td>
        </tr>
    </table>
</asp:Content>


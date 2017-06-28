<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/AIMaster.master" AutoEventWireup="false"
    CodeFile="frmCreateSupplier.aspx.vb" Inherits="Administration_frmCreateSupplier"
    Title=".:Help Desk:Supplier Input:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlSupplierInput" runat="server" Width="100%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widgettitle">
                                    Supplier Input
                                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                                &nbsp;
                            </td>
                            <td style="width: 150px">
                                &nbsp;
                            </td>
                            <td style="width: 250px">
                                <asp:HiddenField ID="hdFldSupplierID" runat="server" />
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldSupplierName" runat="server" ControlToValidate="txtSupplierName"
                                    Display="None" ErrorMessage="Supplier Name Required" ValidationGroup="AddSupplier"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldSupplierName_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldSupplierName" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldContactNumber" runat="server" ControlToValidate="txtContactNumber"
                                    Display="None" ErrorMessage="Contact Number Required" ValidationGroup="AddSupplier"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldContactNumber_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldContactNumber" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Supplier Name
                            </td>
                            <td>
                                <asp:TextBox ID="txtSupplierName" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldContactperson" runat="server" ControlToValidate="txtContactPerson"
                                    Display="None" ErrorMessage="Contact Person Required" ValidationGroup="AddSupplier"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldContactperson_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldContactperson" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldAboutSupplier" runat="server" ControlToValidate="txtAboutSupplier"
                                    Display="None" ErrorMessage="About Supplier" ValidationGroup="AddSupplier"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldAboutSupplier_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldAboutSupplier" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Contact Person
                            </td>
                            <td>
                                <asp:TextBox ID="txtContactPerson" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                            <td class="label">
                                Contact Number
                            </td>
                            <td>
                                <asp:TextBox ID="txtContactNumber" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Company Phone\Mobile
                            </td>
                            <td>
                                <asp:TextBox ID="txtCompanyMobile" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                            <td class="label">
                                Fax
                            </td>
                            <td>
                                <asp:TextBox ID="txtFax" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label" align="right">
                                E-Mail
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldSupplierAddress" runat="server" ControlToValidate="txtSupplierAddresss"
                                    Display="None" ErrorMessage="Supplier Address Required" ValidationGroup="AddSupplier"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldSupplierAddress_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldSupplierAddress" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                Address
                            </td>
                            <td>
                                <asp:TextBox ID="txtSupplierAddresss" runat="server" CssClass="InputTxtBox" Height="50px"
                                    TextMode="MultiLine" Width="200px"></asp:TextBox>
                            </td>
                            <td class="label">
                                About Supplier
                            </td>
                            <td>
                                <asp:TextBox ID="txtAboutSupplier" runat="server" CssClass="InputTxtBox" Height="50px"
                                    TextMode="MultiLine" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Black Listed
                            </td>
                            <td>
                                <asp:CheckBox ID="chkIsBlackListed" runat="server" CssClass="chkText" Text="Is Black Listed" />
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnAddSupplier" runat="server" CssClass="styled-button-1" Text="ADD Supplier"
                                    ValidationGroup="AddSupplier" />
                                &nbsp;<asp:Button ID="btnUpdateSupplier" runat="server" CssClass="styled-button-1"
                                    Text="Update" ValidationGroup="AddSupplier" />
                                &nbsp;
                            </td>
                            <td>
                                <asp:Button ID="btnCancelInputSupplier" runat="server" CssClass="styled-button-1"
                                    Text="Cancel" />
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlAvailableSupplierInfo" runat="server" SkinID="pnlInner" 
                    Width="100%">
                    <div style="max-height: 300px; max-width: 100%; overflow: auto">
                        <asp:GridView ID="grdAvailableSupplierInfo" runat="server" AutoGenerateColumns="False"
                            CellPadding="4" ForeColor="#333333" GridLines="None" CssClass="mGrid">
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <Columns>
                                <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                            Text="Select"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SupplierID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSupplierID" runat="server" Text='<%# Bind("SupplierID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Supplier">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSupplierName" runat="server" Text='<%# Bind("SupplierName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Address">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAddress" runat="server" Text='<%# Bind("Address") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Contact Person">
                                    <ItemTemplate>
                                        <asp:Label ID="lblContactPerson" runat="server" Text='<%# Bind("ContactPerson") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Contact Number">
                                    <ItemTemplate>
                                        <asp:Label ID="lblContactNumber" runat="server" Text='<%# Bind("ContactNumber") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="About Supplier">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAboutSupplier" runat="server" Text='<%# Bind("AboutSupplier") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Company Contact">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCompanyContactNumber" runat="server" Text='<%# Bind("CompanyContactNumber") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fax">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFax" runat="server" Text='<%# Bind("Fax") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Email">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEmail" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Black Listed">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsBlackListed" runat="server" Text='<%# Bind("IsBlackListed") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EntryBy">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEntryBy" runat="server" Text='<%# Bind("EntryBy") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EntryDate">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEntryDate" runat="server" Text='<%# Bind("EntryDate") %>'></asp:Label>
                                    </ItemTemplate>
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
        <tr align="center">
            <td>
            </td>
        </tr>
    </table>
</asp:Content>

<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/AIMaster.master" AutoEventWireup="false" CodeFile="frmBranchManagement.aspx.vb" Inherits="Administration_frmBranchManagement" title=".:Help Desk:Branch Management:." %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width:100%;">
        <tr align="center" >
            <td>
                &nbsp;</td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr align="center" >
            <td>
                &nbsp;</td>
            <td>
                <asp:Panel ID="pnlBranchInput" runat="server" Width="750px" SkinID="pnlInner" >
                    <table style="width:100%;">
                        <tr align="left" >
                            <td colspan="5">
                                <div class="widgettitle">Branch Management</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width:20px">
                                &nbsp;</td>
                            <td style="width:150px">
                                &nbsp;</td>
                            <td style="width:230px">
                                <asp:HiddenField ID="hdFldBranchID" runat="server" />
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr  align="left" >
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                Branch Name</td>
                            <td>
                                <asp:TextBox ID="txtBranchName" runat="server" CssClass="InputTxtBox" 
                                    Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldBranchName" runat="server" 
                                    ControlToValidate="txtBranchName" Display="None" 
                                    ErrorMessage="Branch Name Required" ValidationGroup="AddBranch"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldBranchName_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" TargetControlID="reqFldBranchName" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr  align="left" >
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                Code</td>
                            <td>
                                <asp:TextBox ID="txtBranchCode" runat="server" CssClass="InputTxtBox" 
                                    Width="200px" ></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldBranchCode" runat="server" 
                                    ControlToValidate="txtBranchCode" Display="None" 
                                    ErrorMessage="Branch Code Required" ValidationGroup="AddBranch"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldBranchCode_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" TargetControlID="reqFldBranchCode" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr  align="left" >
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                Head Of Branch</td>
                            <td>
                                <asp:DropDownList ID="drpHOBranch" runat="server" CssClass="InputTxtBox" 
                                    Width="200px">
                                </asp:DropDownList>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldHOBranch" runat="server" 
                                    ControlToValidate="drpHOBranch" Display="None" 
                                    ErrorMessage="Head Of Branch Required" ValidationGroup="AddBranch"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldHOBranch_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" TargetControlID="reqFldHOBranch" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr  align="left" >
                            <td>
                            </td>
                            <td class="label">
                                Address</td>
                            <td>
                                <asp:TextBox ID="txtBranchAddress" runat="server" CssClass="InputTxtBox" 
                                    Height="50px" TextMode="MultiLine" Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldBranchAddress" runat="server" 
                                    ControlToValidate="txtBranchAddress" Display="None" 
                                    ErrorMessage="Branch Address Required" ValidationGroup="AddBranch"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldBranchAddress_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" 
                                    TargetControlID="reqFldBranchAddress" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr  align="left" >
                            <td>
                            </td>
                            <td class="label">
                                Contact Number</td>
                            <td>
                                <asp:TextBox ID="txtContactNumber" runat="server" CssClass="InputTxtBox" 
                                    Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldBranchContactNumber" runat="server" 
                                    ControlToValidate="txtContactNumber" Display="None" 
                                    ErrorMessage="Branch Contact Number Required" ValidationGroup="AddBranch"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldBranchContactNumber_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" 
                                    TargetControlID="reqFldBranchContactNumber" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                Branch Mail Address</td>
                            <td>
                                <asp:TextBox ID="txtBranchMailAddress" runat="server" CssClass="InputTxtBox" 
                                    Width="200px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqFldBranchMailAddress" runat="server" 
                                    ControlToValidate="txtBranchMailAddress" Display="None" 
                                    ErrorMessage="Branch Mail Address Required" ValidationGroup="AddBranch"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldBranchMailAddress_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" 
                                    TargetControlID="reqFldBranchMailAddress" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr  align="left" >
                            <td>
                            </td>
                            <td class="label">
                                Branch Activity</td>
                            <td>
                                <asp:CheckBox ID="chkIsActiveBranch" runat="server" CssClass="chkText" 
                                    Text="Is Active" />
                            </td>
                            <td>
                                </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnBranchInput" runat="server" Text="ADD Branch" 
                                    CssClass="styled-button-1" ValidationGroup="AddBranch" />
                                &nbsp;<asp:Button ID="btnUpdateBranch" runat="server" Text="Update" 
                                    CssClass="styled-button-1" ValidationGroup="AddBranch" />
                                &nbsp;<asp:Button ID="btnCancelBranchInput" runat="server" Text="Cancel" 
                                    CssClass="styled-button-1" />
                            </td>
                            <td>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr align="center">
                            <td colspan="5">
                                <div style="max-width:680px;max-height:300px;overflow:auto">
                                    <asp:GridView ID="grdBranchList" runat="server" AutoGenerateColumns="False" 
                                        CellPadding="4" ForeColor="#333333" GridLines="None" CssClass="mGrid">
                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                                        CommandName="Select" Text="Select"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="BranchID" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBranchID" runat="server" Text='<%# Bind("BranchID") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("BranchID") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Branch">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBranchName" runat="server" Text='<%# Bind("BranchName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("BranchName") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Code">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBranchCode" runat="server" Text='<%# Bind("BranchCode") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("BranchCode") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="HOBranch" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblHOBranch" runat="server" Text='<%# Bind("HOBranch") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("HOBranch") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="HOBr">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("HOBr") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("HOBr") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Address">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAddress" runat="server" Text='<%# Bind("Address") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Address") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Contact Number">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblContactNumber" runat="server" 
                                                        Text='<%# Bind("ContactNumber") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("ContactNumber") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Branch Mail">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBranchMailAddress" runat="server" 
                                                        Text='<%# Bind("BranchMailAddress") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox10" runat="server" 
                                                        Text='<%# Bind("BranchMailAddress") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="IsActive">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIsActive" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("IsActive") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Entry By">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEntryBy" runat="server" Text='<%# Bind("EntryBy") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("EntryBy") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="EntryDate">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEntryDate" runat="server" Text='<%# Bind("EntryDate") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("EntryDate") %>'></asp:TextBox>
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
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr align="center" >
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>


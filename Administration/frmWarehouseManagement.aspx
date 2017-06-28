<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/AIMaster.master" AutoEventWireup="false"
    CodeFile="frmWarehouseManagement.aspx.vb" Inherits="Administration_frmWarehouseManagement"
    Title=".:Help Desk:Warehouse Management:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlWarehouseManagement" runat="server" Width="100%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="4">
                                <div class="widgettitle">
                                    Warehouse Management<asp:ScriptManager ID="ScriptManager1" runat="server">
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
                            <td style="width: 300px">
                                <asp:HiddenField ID="hdFldWareHouseID" runat="server" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Warehouse Name
                            </td>
                            <td>
                                <asp:TextBox ID="txtWarehouseName" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                            <td style="margin-left: 40px">
                                <asp:RequiredFieldValidator ID="reqFldWarehouseName" runat="server" ControlToValidate="txtWarehouseName"
                                    Display="None" ErrorMessage="Warehouse Name Required" ValidationGroup="AddWarehouse"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldWarehouseName_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldWarehouseName" CloseImageUrl="~/Sources/images/valClose.png"
                                    CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Warehouse Code
                            </td>
                            <td>
                                <asp:TextBox ID="txtWarehouseCode" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                            <td style="margin-left: 40px">
                                <asp:RequiredFieldValidator ID="reqFldWarehouseCode" runat="server" Display="None"
                                    ErrorMessage="Warehouse Code Required" ValidationGroup="AddWarehouse" ControlToValidate="txtWarehouseCode"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldWarehouseCode_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldWarehouseCode" CloseImageUrl="~/Sources/images/valClose.png"
                                    CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Branch
                            </td>
                            <td>
                                <asp:DropDownList ID="drpBranch" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td style="margin-left: 40px">
                                <asp:RequiredFieldValidator ID="reqFldBranchInfo" runat="server" ControlToValidate="drpBranch"
                                    Display="None" ErrorMessage="Branch Required" ValidationGroup="AddWarehouse"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Location
                            </td>
                            <td>
                                <asp:TextBox ID="txtLocation" runat="server" CssClass="InputTxtBox" Height="50px"
                                    TextMode="MultiLine" Width="250px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldWarehouseLocation" runat="server" ControlToValidate="txtLocation"
                                    Display="None" ErrorMessage="Location Required" ValidationGroup="AddWarehouse"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldWarehouseLocation_ValidatorCalloutExtender"
                                    runat="server" Enabled="True" TargetControlID="reqFldWarehouseLocation" CloseImageUrl="~/Sources/images/valClose.png"
                                    CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Details
                            </td>
                            <td>
                                <asp:TextBox ID="txtDetails" runat="server" CssClass="InputTxtBox" Height="50px"
                                    TextMode="MultiLine" Width="250px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldDetails" runat="server" ControlToValidate="txtDetails"
                                    Display="None" ErrorMessage="Details Required" ValidationGroup="AddWarehouse"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldDetails_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldDetails" CloseImageUrl="~/Sources/images/valClose.png"
                                    CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Is Active
                            </td>
                            <td>
                                <asp:CheckBox ID="chkIsWarehouseActive" runat="server" CssClass="chkText" Text="Is Warehouse Active" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnAddWarehouse" runat="server" CssClass="styled-button-1" Text="ADD Warehouse"
                                    ValidationGroup="AddWarehouse" />
                                &nbsp;<asp:Button ID="btnUpdateWarehouse" runat="server" CssClass="styled-button-1"
                                    Text="Update" Visible="False" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" Text="Cancel" />
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
                &nbsp;
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlShowWarehouse" runat="server" Width="100%" SkinID="pnlInner">
                    <div>
                        <asp:GridView ID="grdDetailsWarehouseList" runat="server" AutoGenerateColumns="False"
                            CellPadding="4" ForeColor="#333333" GridLines="None" CssClass="mGrid">
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <Columns>
                                <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                            Text="Select"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="WarehouseID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblWarehouseID" runat="server" Text='<%# Bind("WarehouseID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="WarehouseName">
                                    <ItemTemplate>
                                        <asp:Label ID="lblWarehouseName" runat="server" Text='<%# Bind("WarehouseName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Code">
                                    <ItemTemplate>
                                        <asp:Label ID="lblWarehouseCode" runat="server" Text='<%# Bind("WarehouseCode") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="BranchID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBranchID" runat="server" Text='<%# Bind("BranchID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="BranchName">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBranchName" runat="server" Text='<%# Bind("BranchName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Location">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLocation" runat="server" Text='<%# Bind("Location") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDetails" runat="server" Text='<%# Bind("Details") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="IsActive">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsActive" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
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

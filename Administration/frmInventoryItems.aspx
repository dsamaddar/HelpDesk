<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/AIMaster.master" AutoEventWireup="false"
    CodeFile="frmInventoryItems.aspx.vb" Inherits="Administration_frmInventoryItems"
    Title=".:Help Desk:Item Definition:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlItemInput" runat="server" Width="100%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="4">
                                <div class="widgettitle">
                                    .: Item Definition :.<asp:ScriptManager ID="ScriptManager1" runat="server">
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
                            <td style="width: 230px">
                                <asp:HiddenField ID="hdFldItemID" runat="server" />
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
                                Item Name
                            </td>
                            <td>
                                <asp:TextBox ID="txtItemName" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                &nbsp;
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldItemName" runat="server" ControlToValidate="txtItemName"
                                    Display="None" ErrorMessage="Item Name Required" ValidationGroup="ItemInput"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldItemName_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldItemName" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Item Code
                            </td>
                            <td>
                                <asp:TextBox ID="txtItemCode" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                &nbsp;
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldItemCode" runat="server" ControlToValidate="txtItemCode"
                                    Display="None" ErrorMessage="Item Code Required" ValidationGroup="ItemInput"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldItemCode_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldItemCode" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Unit Type
                            </td>
                            <td>
                                <asp:DropDownList ID="drpUnitType" runat="server" Width="200px" CssClass="InputTxtBox">
                                </asp:DropDownList>
                                &nbsp;
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldUnitTypeItemInput" runat="server" ControlToValidate="drpUnitType"
                                    Display="None" ErrorMessage="Unit Type Required" ValidationGroup="ItemInput"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldUnitTypeItemInput_ValidatorCalloutExtender"
                                    runat="server" Enabled="True" TargetControlID="reqFldUnitTypeItemInput" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Low Balance Report
                            </td>
                            <td>
                                <asp:TextBox ID="txtLowBalanceReport" runat="server" CssClass="InputTxtBox" Width="120px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldLowBalanceReport" runat="server" ControlToValidate="txtLowBalanceReport"
                                    Display="None" ErrorMessage="Low Balance Report Required" ValidationGroup="ItemInput"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldLowBalanceReport_ValidatorCalloutExtender"
                                    runat="server" Enabled="True" TargetControlID="reqFldLowBalanceReport" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left" visible="false">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td>
                                <asp:TextBox ID="txtMaxRequisition" runat="server" CssClass="InputTxtBox" Width="120px"
                                    Visible="False">10000</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldMaxRequisition" runat="server" ControlToValidate="txtMaxRequisition"
                                    Display="None" ErrorMessage="Max Allowable Requisition Required" ValidationGroup="ItemInput"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldMaxRequisition_ValidatorCalloutExtender"
                                    runat="server" Enabled="True" TargetControlID="reqFldMaxRequisition" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Active
                            </td>
                            <td>
                                <asp:CheckBox ID="chkItemIsActive" runat="server" CssClass="chkText" Text="Is Active" />
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
                                <asp:Button ID="btnAddItem" runat="server" CssClass="styled-button-1" Text="ADD Item"
                                    ValidationGroup="ItemInput" />
                                &nbsp;<asp:Button ID="btnUpdateInventoryItems" runat="server" CssClass="styled-button-1"
                                    Text="Update" />
                                &nbsp;<asp:Button ID="btnCancelInputItemType" runat="server" CssClass="styled-button-1"
                                    Text="Cancel" />
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
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <div style="max-height: 300px; max-width: 100%; overflow: auto">
                                    <asp:GridView ID="grdAvailableItems" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                        CssClass="mGrid" ForeColor="#333333" GridLines="None" Width="100%">
                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                                        Text="Select"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="ItemID" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblItemID" runat="server" Text='<%# Bind("ItemID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Item">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblItemName" runat="server" Text='<%# Bind("ItemName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Code">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblItemCode" runat="server" Text='<%# Bind("ItemCode") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="UnitTypeID" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitTypeID" runat="server" Text='<%# Bind("UnitTypeID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Unit">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("UnitType") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Low Balance">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("LowBalanceReport") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblLowBalanceReport" runat="server" Text='<%# Bind("LowBalanceReport") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Max Requisition" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMaxAllowableRequisition" runat="server" Text='<%# Bind("MaxAllowableRequisition") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Is Active">
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
                                                    <asp:Label ID="Label10" runat="server" Text='<%# Bind("EntryDate") %>'></asp:Label>
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
    </table>
</asp:Content>

<%@ Page Language="VB" Theme="CommonSkin"  MasterPageFile="~/AIMaster.master" AutoEventWireup="false" CodeFile="frmWarehouseToWarehouse.aspx.vb" Inherits="FillupWarehouse_frmWarehouseToWarehouse" title=".:Help Desk:Warehouse To Warehouse Balance Transfer:." %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width: 100%;">
    <tr align="center" >
        <td style="margin-left: 40px">
            <asp:Panel ID="pnlWarehouseToWarehouse" runat="server" Width="100%" 
                SkinID="pnlInner" >
                <table style="width:100%;">
                    <tr align="left" >
                        <td colspan="5">
                            <div class="widgettitle">Warehouse To Warehouse Balance Transfer<asp:ScriptManager 
                                    ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
                            </div>
                        </td>
                    </tr>
                    <tr align="left" >
                        <td style="width:20px">
                            &nbsp;</td>
                        <td style="width:150px">
                            &nbsp;</td>
                        <td style="width:150px">
                            &nbsp;</td>
                        <td style="width:230px">
                            &nbsp;</td>
                        <td style="width:230px">
                            &nbsp;</td>
                    </tr>
                    <tr align="left" >
                        <td>
                            &nbsp;</td>
                        <td class="label">
                            &nbsp;</td>
                        <td class="label">
                            Source Warehouse</td>
                        <td>
                            <asp:DropDownList ID="drpSourceWarehouse" runat="server" CssClass="InputTxtBox" 
                                Width="200px" AutoPostBack="True">
                            </asp:DropDownList>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr align="left" >
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
    <tr align="center" >
        <td>
            <asp:Panel ID="pnlWarehouseItemBalance" runat="server" Width="100%" 
                SkinID="pnlInner">
                <table style="width:100%;">
                    <tr>
                        <td class="label" style="width:20px">
                            &nbsp;</td>
                        <td class="label" style="width:200px">
                            Source Balance</td>
                        <td>
                            </td>
                        <td class="label">
                            Destination</td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;</td>
                        <td >
                            <div style="max-height:200px;max-width:400px;overflow:auto">
                                <asp:GridView ID="grdSourceWarehouseBalance" runat="server" 
                                    AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" 
                                    GridLines="None" CssClass="mGrid">
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkBtnSrcSelectItm" runat="server" CausesValidation="False" 
                                                    CommandName="Select" Text="Select"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="ItemID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSrcItemID" runat="server" Text='<%# Bind("ItemID") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ItemID") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="ItemName">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSrcItemName" runat="server" Text='<%# Bind("ItemName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ItemName") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Balance">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSrcBalance" runat="server" Text='<%# Bind("Balance") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Balance") %>'></asp:TextBox>
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
                        <td valign="top">
                            <table style="width:100%;">
                                <tr align="left">
                                    <td class="label">
                                        Destination Warehouse</td>
                                    <td>
                                        <asp:DropDownList ID="drpDestinationWarehouse" runat="server" 
                                            CssClass="InputTxtBox" Width="200px">
                                        </asp:DropDownList>
                                        &nbsp;<asp:RequiredFieldValidator ID="reqFldDestinationWarehouse" runat="server" 
                                            ControlToValidate="drpDestinationWarehouse" Display="None" 
                                            ErrorMessage="Destination Warehouse Required" ValidationGroup="TransferBalance"></asp:RequiredFieldValidator>
                                        <cc1:ValidatorCalloutExtender ID="reqFldDestinationWarehouse_ValidatorCalloutExtender" 
                                            runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                            CssClass="customCalloutStyle" Enabled="True" 
                                            TargetControlID="reqFldDestinationWarehouse" 
                                            WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                        </cc1:ValidatorCalloutExtender>
                                    </td>
                                </tr>
                                <tr align="left">
                                    <td class="label">
                                        Available Balance</td>
                                    <td>
                                        <asp:TextBox ID="txtAvailableBalance" runat="server" CssClass="InputTxtBox" 
                                            Width="150px" ReadOnly="True"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="reqFldAvailableBalance" runat="server" 
                                            ControlToValidate="txtAvailableBalance" Display="None" 
                                            ErrorMessage="Available Balance Required" ValidationGroup="TransferBalance"></asp:RequiredFieldValidator>
                                        <cc1:ValidatorCalloutExtender ID="reqFldAvailableBalance_ValidatorCalloutExtender" 
                                            runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                            CssClass="customCalloutStyle" Enabled="True" 
                                            TargetControlID="reqFldAvailableBalance" 
                                            WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                        </cc1:ValidatorCalloutExtender>
                                    </td>
                                </tr>
                                <tr align="left">
                                    <td class="label">
                                        Transfer Balance</td>
                                    <td>
                                        <asp:TextBox ID="txtTransferBalance" runat="server" CssClass="InputTxtBox" 
                                            Width="150px"></asp:TextBox>
                                        &nbsp;<asp:RequiredFieldValidator ID="reqFldTransferBalance" runat="server" 
                                            ControlToValidate="txtTransferBalance" Display="None" 
                                            ErrorMessage="TransferBalance Required" ValidationGroup="TransferBalance"></asp:RequiredFieldValidator>
                                        <cc1:ValidatorCalloutExtender ID="reqFldTransferBalance_ValidatorCalloutExtender" 
                                            runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                            CssClass="customCalloutStyle" Enabled="True" 
                                            TargetControlID="reqFldTransferBalance" 
                                            WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                        </cc1:ValidatorCalloutExtender>
                                    </td>
                                </tr>
                                <tr align="left">
                                    <td>
                                        &nbsp;</td>
                                    <td>
                                        <asp:Button ID="btnADDToCart" runat="server" CssClass="styled-button-1" 
                                            Text="ADD To Cart" ValidationGroup="TransferBalance" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="left" >
                            <div style="max-height:200px;max-width:400px;overflow:auto">
                                <asp:GridView ID="grdDestinationWarehouseBalance" runat="server" 
                                    AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" 
                                    GridLines="None" CssClass="mGrid">
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="SourceWarehouseID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSourceWarehouseID" runat="server" Text='<%# Bind("SourceWarehouseID") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("SourceWarehouseID") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="SourceWarehouse">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSourceWarehouse" runat="server" Text='<%# Bind("SourceWarehouse") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("SourceWarehouse") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="DestWarehouseID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDestWarehouseID" runat="server" Text='<%# Bind("DestWarehouseID") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("DestWarehouseID") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Dest. Warehouse">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDestWarehouse" runat="server" Text='<%# Bind("DestWarehouse") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("DestWarehouse") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="ItemID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDestItemID" runat="server" Text='<%# Bind("ItemID") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("ItemID") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="ItemName">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDestItemName" runat="server" Text='<%# Bind("ItemName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("ItemName") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Transfer Quantity">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDestTransferQuantity" runat="server" Text='<%# Bind("TransferQuantity") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("TransferQuantity") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Delete" ShowHeader="False">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgbtnDelete" ImageUrl="~/Sources/icons/erase.png"   OnClientClick="if (!confirm('Are you Sure to Delete The Item From The List ?')) return false"    CommandName="Delete"  runat="server" />
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
                    <tr>
                        <td>
                            </td>
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
    <tr align="center" >
        <td>
            <asp:Panel ID="pnlSaveChanges" runat="server" Width="100%" SkinID="pnlInner">
                <table style="width:100%;">
                    <tr align="center" >
                        <td>
                            &nbsp;</td>
                        <td>
                            <asp:Button ID="btnTransfer" runat="server" CssClass="styled-button-1" 
                                Text="Transfer"  OnClientClick="if (!confirm('Are you Sure to Transfer The Items ?')) return false"  />
                            &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" 
                                Text="Cancel" />
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>
            </asp:Panel>
            </td>
    </tr>
</table>
</asp:Content>


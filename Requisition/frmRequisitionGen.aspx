<%@ Page Language="VB" Theme="CommonSkin"  MasterPageFile="~/AIMasterGen.master" AutoEventWireup="false" CodeFile="frmRequisitionGen.aspx.vb" Inherits="Requisition_frmRequisitionGen" title=".:Help Desk:Item Requisition:." %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width:100%;">
        <tr align="center" >
            <td>
                <asp:Panel ID="pnlItemRequisition" runat="server" Width="100%" 
                    SkinID="pnlInner" >
                    <table style="width:100%;">
                        <tr align="left" >
                            <td colspan="6">
                                <div class="widgettitle">Item Requisition<asp:ScriptManager ID="ScriptManager1" 
                                        runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left" >
                            <td>
                                </td>
                            <td>
                                </td>
                            <td>
                                </td>
                            <td>
                                </td>
                            <td>
                                </td>
                            <td>
                                </td>
                        </tr>
                        <tr align="left" >
                            <td style="width:20px">
                                </td>
                            <td style="width:150px" class="label">
                                Select Item</td>
                            <td style="width:230px">
                                <asp:DropDownList ID="drpItemList" runat="server" CssClass="InputTxtBox" 
                                    Width="200px" AutoPostBack="True">
                                </asp:DropDownList>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldInventoryItems" runat="server" 
                                    ErrorMessage="Select Inventory Items" Display="None" 
                                    ValidationGroup="AddRequisition" ControlToValidate="drpItemList"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldInventoryItems_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldInventoryItems"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png" >
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td class="label" style="width:150px">
                                &nbsp;</td>
                            <td style="width:230px">
                                <asp:Label ID="lblItemBalance" runat="server" CssClass="chkText" 
                                    Visible="False"></asp:Label>
                                <asp:Label ID="lblMaximumAllowableRequisition" runat="server" 
                                    CssClass="chkText" Visible="False"></asp:Label>
                            </td>
                            <td style="width:20px">
                                </td>
                        </tr>
                        <tr align="left" >
                            <td>
                                </td>
                            <td class="label">
                                Quantity</td>
                            <td>
                                <asp:TextBox ID="txtQuantity" runat="server" CssClass="InputTxtBox" 
                                    Width="120px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldQuantity" runat="server" 
                                    ErrorMessage="Quantity Required" Display="None" 
                                    ValidationGroup="AddRequisition" ControlToValidate="txtQuantity"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldQuantity_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldQuantity" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png" >
                                </cc1:ValidatorCalloutExtender>
                                &nbsp;<asp:RegularExpressionValidator ID="regExpQuantity" runat="server" 
                                    ControlToValidate="txtQuantity" Display="None" ErrorMessage="Numeric" 
                                    ValidationExpression="^[1-9][0-9]*" ValidationGroup="AddRequisition"></asp:RegularExpressionValidator>
                                <cc1:ValidatorCalloutExtender ID="regExpQuantity_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" TargetControlID="regExpQuantity" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td class="label">
                                Remarks</td>
                            <td>
                                <asp:TextBox ID="txtItemRequisitionRemarks" runat="server" 
                                    CssClass="InputTxtBox" Height="50px" TextMode="MultiLine" Width="200px"></asp:TextBox>
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
                                <asp:Button ID="btnAddRequisition" runat="server" CssClass="styled-button-1" 
                                    Text="ADD Requisition" ValidationGroup="AddRequisition" />
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
                <asp:Panel ID="pnlRequestedItemList" runat="server" Width="100%"  
                    SkinID="pnlInner" >
                    <div>
                        <asp:GridView ID="grdRequisitionList" runat="server" 
                            AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" 
                            GridLines="None">
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <Columns>
                                <asp:TemplateField HeaderText="ItemID" Visible="False">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ItemID") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblItemID" runat="server" Text='<%# Bind("ItemID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Item Name">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ItemName") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblItemName" runat="server" Text='<%# Bind("ItemName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Quantity">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Quantity") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblQuantity" runat="server" Text='<%# Bind("Quantity") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Remarks">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Remarks") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblRemarks" runat="server" Text='<%# Bind("Remarks") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete" ShowHeader="False">
                                    <ItemTemplate>
                                       <asp:ImageButton ID="imgbtnDelete" ImageUrl="~/Sources/icons/erase.png"   OnClientClick="if (!confirm('Are you Sure to Delete The Requisition ?')) return false"    CommandName="Delete"  runat="server" />
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
        <tr align="center" >
            <td>
                <asp:Panel ID="pnlSubmit" runat="server" Width="100%"  SkinID="pnlInner" >
                    <table style="width:100%;">
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td>
                                <asp:Button ID="btnSubmit" runat="server" CssClass="styled-button-1"  OnClientClick="if (!confirm('Are you Sure to Submit The Requisition ?')) return false" 
                                    Text="Submit" />
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                    </table>
                </asp:Panel>
                </td>
        </tr>
        <tr align="center" >
            <td>
                </td>
        </tr>
    </table>
</asp:Content>


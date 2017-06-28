<%@ Page Language="VB" Theme="CommonSkin"  MasterPageFile="~/AIMaster.master" AutoEventWireup="false" CodeFile="clsFillupWarehouse.aspx.vb" Inherits="FillupWarehouse_clsFillupWarehouse" title=".:Help Desk:Procurement To Warehouse:." %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width:100%;">
        <tr align="center" >
            <td>
                <asp:Panel ID="pnlApprovedProcurement" runat="server" Width="100%" 
                    SkinID="pnlInner" >
                    <table style="width:100%;">
                        <tr align="left" >
                            <td colspan="3">
                                <div class="widgettitle">Procurement To Warehouse Balance Transfer</div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td>
                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <div style="max-height:200px;max-width:780px;overflow:auto">
                                <asp:GridView ID="grdInvoiceUnAllocated" runat="server" 
                                    AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" 
                                    GridLines="None" EmptyDataText="No Unallocated Invoice Available" 
                                        CssClass="mGrid">
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sl">
                                            <ItemTemplate>
                                                <b><%#CType(Container, GridViewRow).RowIndex + 1%></b>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                                    CommandName="Select" Text="Select"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="InvoiceID" Visible="False">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("InvoiceID") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblInvoiceID" runat="server" Text='<%# Bind("InvoiceID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="InvoiceNo">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("InvoiceNo") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblInvoiceNo" runat="server" Text='<%# Bind("InvoiceNo") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="SupplierID" Visible="False">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("SupplierID") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblSupplierID" runat="server" Text='<%# Bind("SupplierID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="SupplierName">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("SupplierName") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblSupplierName" runat="server" 
                                                    Text='<%# Bind("SupplierName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="InvoiceDate">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("InvoiceDate") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblInvoiceDate" runat="server" Text='<%# Bind("InvoiceDate") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="InvoiceCost">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("InvoiceCost") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblInvoiceCost" runat="server" Text='<%# Bind("InvoiceCost") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="SubmittedBy" Visible="False">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("SubmittedBy") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblSubmittedBy" runat="server" Text='<%# Bind("SubmittedBy") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="SubmissionDate" Visible="False">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("SubmissionDate") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblSubmissionDate" runat="server" 
                                                    Text='<%# Bind("SubmissionDate") %>'></asp:Label>
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
                            <td>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center" >
            <td>
                <asp:Panel ID="pnlProcurementBalance" runat="server" SkinID="pnlInner" 
                    Width="100%">
                    <table style="width:100%;">
                        <tr align="left" >
                            <td style="width:20px">
                                &nbsp;</td>
                            <td style="width:150px">
                            </td>
                            <td style="width:230px">
                            </td>
                            <td style="width:150px">
                            </td>
                            <td style="width:230px">
                            </td>
                        </tr>
                        <tr align="left" >
                            <td>
                            </td>
                            <td class="label">
                                Inventory Items</td>
                            <td>
                                <asp:DropDownList ID="drpInventoryItems" runat="server" Width="200px" 
                                    CssClass="InputTxtBox" AutoPostBack="True">
                                </asp:DropDownList>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldInventoryItems" runat="server" 
                                    ControlToValidate="drpInventoryItems" Display="None" 
                                    ErrorMessage="Select Items" ValidationGroup="TransferBalance"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldInventoryItems_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldInventoryItems"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png" >
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td class="label">
                                Balance Remaining</td>
                            <td>
                                <asp:Label ID="lblItemBalanceRemaining" runat="server" CssClass="chkText" 
                                    Text="0"></asp:Label>
                            </td>
                        </tr>
                        <tr align="left" >
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                Transfer Quantity</td>
                            <td>
                                <asp:TextBox ID="txtTransferQuantity" runat="server" CssClass="InputTxtBox" 
                                    Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldTransferQuantity" runat="server" 
                                    ControlToValidate="txtTransferQuantity" Display="None" 
                                    ErrorMessage="Transfer Quantity Required" ValidationGroup="TransferBalance"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldTransferQuantity_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldTransferQuantity"  CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png" >
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td class="label">
                                Select Warehouse</td>
                            <td>
                                <asp:DropDownList ID="drpWarehouseList" runat="server" CssClass="InputTxtBox" 
                                    Width="200px">
                                </asp:DropDownList>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldWarehouse" runat="server" 
                                    ControlToValidate="drpWarehouseList" Display="None" 
                                    ErrorMessage="Select Warehouse" ValidationGroup="TransferBalance"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldWarehouse_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldWarehouse"  CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png" >
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                &nbsp;</td>
                            <td>
                                <asp:Label ID="lblWarningMsg" runat="server" CssClass="label" ForeColor="Red"></asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left" >
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnTransfer" runat="server" CssClass="styled-button-1" 
                                    Text="Transfer" ValidationGroup="TransferBalance" />
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
                <asp:Panel ID="pnlAllocationBalance" runat="server" Width="100%" 
                    SkinID="pnlInner" >
                    <table style="width:100%;">
                        <tr align="left" >
                            <td class="label">
                                &nbsp;</td>
                            <td class="label">
                                Allocation</td>
                            <td class="label">
                                Item Wise Allocation</td>
                        </tr>
                        <tr align="left" >
                            <td style="width:2.5%x" ></td>
                            <td style="width:47.5%" valign="top" >
                                <div style="max-height:200px;max-width:100%;overflow:auto">
                                <asp:GridView ID="grdAllocation" runat="server" AutoGenerateColumns="False" 
                                        CellPadding="4" ForeColor="#333333" GridLines="None" 
                                        EmptyDataText="No Data Available" CssClass="mGrid">
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="ItemID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblItemID" runat="server" Text='<%# Bind("ItemID") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ItemID") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="ItemName">
                                            <ItemTemplate>
                                                <asp:Label ID="lblItemName" runat="server" Text='<%# Bind("ItemName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ItemName") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="WarehouseID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblWarehouseID" runat="server" Text='<%# Bind("WarehouseID") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("WarehouseID") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="WarehouseName">
                                            <ItemTemplate>
                                                <asp:Label ID="lblWarehouseName" runat="server" Text='<%# Bind("WarehouseName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("WarehouseName") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Allocated">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAllocated" runat="server" Text='<%# Bind("Allocated") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Allocated") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Delete" ShowHeader="False">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgbtnDelete" runat="server" CommandName="Delete" 
                                                ImageUrl="~/Sources/icons/erase.png" 
                                                OnClientClick="if (!confirm('Are you Sure to Delete The Item From The List ?')) return false" />
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
                            <td style="width:50%" valign="top">
                                <div style="max-height:200px;max-width:100%;overflow:auto">
                                    <asp:GridView ID="grdItemWiseAllocation" runat="server" 
                                        AutoGenerateColumns="False" CellPadding="4" EmptyDataText="No Data Available" 
                                        ForeColor="#333333" GridLines="None" CssClass="mGrid">
                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="ItemID" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("ItemID") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ItemID") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="ItemName">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("ItemName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ItemName") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Allocated">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Allocated") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Allocated") %>'></asp:TextBox>
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
                        <tr>
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
                <asp:Panel ID="pnlSumit" runat="server" Width="100%" SkinID="pnlInner" >
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" 
                        CssClass="styled-button-1" OnClientClick="if (!confirm('Are you Sure to Submit The Allocation ?')) return false"  />
                    &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" 
                        Text="Cancel" />
                </asp:Panel>
            </td>
        </tr>
        <tr align="center" >
            <td>
                </td>
        </tr>
    </table>
</asp:Content>


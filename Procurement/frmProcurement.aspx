<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/AIMaster.master" AutoEventWireup="false"
    CodeFile="frmProcurement.aspx.vb" Inherits="frmProcurement" Title=".:Help Desk:Procurement Info:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td align="left">
                <div class="widgettitle">
                    Procurement Details</div>
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlInvoiceSelection" runat="server" Width="100%" SkinID="pnlInner">
                    <div>
                        <asp:GridView ID="grdInvoiceSelection" runat="server" AutoGenerateColumns="False"
                            CellPadding="4" ForeColor="#333333" GridLines="None" CssClass="mGrid">
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <Columns>
                                <asp:TemplateField HeaderText="Sl">
                                    <ItemTemplate>
                                        <b>
                                            <%#CType(Container, GridViewRow).RowIndex + 1%></b>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                            Text="Select"></asp:LinkButton>
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
                                        <asp:Label ID="lblSupplierName" runat="server" Text='<%# Bind("SupplierName") %>'></asp:Label>
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
                <asp:Panel ID="pnlInvoiceDetails" runat="server" Width="100%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td style="width: 20px">
                                &nbsp;
                            </td>
                            <td class="label" style="width: 150px">
                                Supplier
                            </td>
                            <td style="width: 230px">
                                <asp:Label ID="lblSupplier" runat="server" CssClass="chkText">N\A</asp:Label>
                            </td>
                            <td class="label" style="width: 150px">
                                Invoice No
                            </td>
                            <td style="width: 230px">
                                <asp:Label ID="lblFrmInvoiceNo" runat="server" CssClass="chkText">N\A</asp:Label>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Purchase Date
                            </td>
                            <td>
                                <asp:Label ID="lblPurchaseDate" runat="server" CssClass="chkText">N\A</asp:Label>
                            </td>
                            <td class="label">
                                Total Cost
                            </td>
                            <td>
                                <asp:Label ID="lblTotalCost" runat="server" CssClass="chkText">0</asp:Label>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <asp:HiddenField ID="hdFldInvoiceID" runat="server" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlProcurementInfo" runat="server" Width="100%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td style="width: 20px">
                                &nbsp;
                            </td>
                            <td style="width: 150px;" class="label">
                                Allocation Remaining
                            </td>
                            <td style="width: 230px">
                                <asp:Label ID="lblAllocationRemaining" runat="server" CssClass="Mandatorylabel" Text="0"></asp:Label>
                            </td>
                            <td style="width: 150px;">
                                &nbsp;
                            </td>
                            <td style="width: 230px">
                                &nbsp;
                            </td>
                        </tr>
                        <tr align="left">
                            <td class="label">
                                &nbsp;
                            </td>
                            <td class="label">
                                Item
                            </td>
                            <td>
                                <asp:DropDownList ID="drpItemList" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldItem" runat="server" ControlToValidate="drpItemList"
                                    Display="None" ErrorMessage="Select Item" ValidationGroup="AddInvItems"></asp:RequiredFieldValidator>
                            </td>
                            <td class="label">
                                Item Balance
                            </td>
                            <td>
                                <asp:Label ID="lblItemBalance" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr align="left">
                            <td class="label">
                                &nbsp;
                            </td>
                            <td class="label">
                                Quantity
                            </td>
                            <td>
                                <asp:TextBox ID="txtQuantity" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldQuantity" runat="server" ControlToValidate="txtQuantity"
                                    Display="None" ErrorMessage="Item Quantity Required" ValidationGroup="AddInvItems"></asp:RequiredFieldValidator>
                            </td>
                            <td class="label">
                                Unit Price
                            </td>
                            <td>
                                &nbsp;<asp:TextBox ID="txtUnitPrice" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldUnitPrice" runat="server" ControlToValidate="txtUnitPrice"
                                    Display="None" ErrorMessage="Unit Price Required" ValidationGroup="AddInvItems"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
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
                                &nbsp;
                            </td>
                            <td>
                                <asp:Button ID="btnAddItemPurchase" runat="server" Text="ADD Item" CssClass="styled-button-1"
                                    ValidationGroup="AddInvItems" />
                                &nbsp;<asp:Button ID="pnlCancelSelection" runat="server" Text="Cancel" CssClass="styled-button-1" />
                            </td>
                            <td>
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
                                &nbsp;
                            </td>
                            <td>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlProcurementDetails" runat="server" Width="100%" SkinID="pnlInner">
                    <div>
                        <asp:GridView ID="grdInvoiceItems" runat="server" AutoGenerateColumns="False" 
                            ShowFooter="True" CssClass="mGrid">
                            <Columns>
                                <asp:TemplateField HeaderText="Sl">
                                    <ItemTemplate>
                                        <b>
                                            <%#CType(Container, GridViewRow).RowIndex + 1%></b>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ItemID" Visible="False">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("ItemID") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblItemID" runat="server" Text='<%# Bind("ItemID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Item Name">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("ItemName") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblItemName" runat="server" Text='<%# Bind("ItemName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Quantity">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("Quantity") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblQuantity" runat="server" Text='<%# Bind("Quantity") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="UnitPrice">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("UnitPrice") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblUnitPrice" runat="server" Text='<%#Eval("UnitPrice", "{0:N2}") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total Price">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("TotalPrice") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblTotalPrice" runat="server" Text='<%#Eval("TotalPrice", "{0:N2}") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgbtnDelete" runat="server" CommandName="Delete" ImageUrl="~/Sources/icons/erase.png"
                                            OnClientClick="if (!confirm('Are you Sure to Delete The Item From The List ?')) return false" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlSubmitProcurement" runat="server" Width="100%" SkinID="pnlInner">
                    <asp:Button ID="btnSubmitProcurement" runat="server" Text="Submit" CssClass="styled-button-1" />
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
        </tr>
    </table>
</asp:Content>

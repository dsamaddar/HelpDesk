<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/AIMaster.master" AutoEventWireup="false"
    CodeFile="frmInvoiceInput.aspx.vb" Inherits="Procurement_frmInvoiceInput" Title=".:Help Desk:Invoice Input:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        /*Calendar Control CSS*/.MyCalendarCss .ajax__calendar_container
        {
            background-color: #DEF1F4;
            border: solid 1px #77D5F7;
        }
        .MyCalendarCss .ajax__calendar_header
        {
            background-color: #ffffff;
            margin-bottom: 4px;
        }
        .MyCalendarCss .ajax__calendar_title, .MyCalendarCss .ajax__calendar_next, .MyCalendarCss .ajax__calendar_prev
        {
            color: #004080;
            padding-top: 3px;
        }
        .MyCalendarCss .ajax__calendar_body
        {
            background-color: #ffffff;
            border: solid 1px #77D5F7;
        }
        .MyCalendarCss .ajax__calendar_dayname
        {
            text-align: center;
            font-weight: bold;
            margin-bottom: 4px;
            margin-top: 2px;
            color: #004080;
        }
        .MyCalendarCss .ajax__calendar_day
        {
            color: #004080;
            text-align: center;
        }
        .MyCalendarCss .ajax__calendar_hover .ajax__calendar_day, .MyCalendarCss .ajax__calendar_hover .ajax__calendar_month, .MyCalendarCss .ajax__calendar_hover .ajax__calendar_year, .MyCalendarCss .ajax__calendar_active
        {
            color: #004080;
            font-weight: bold;
            background-color: #DEF1F4;
        }
        .MyCalendarCss .ajax__calendar_today
        {
            font-weight: bold;
        }
        .MyCalendarCss .ajax__calendar_other, .MyCalendarCss .ajax__calendar_hover .ajax__calendar_today, .MyCalendarCss .ajax__calendar_hover .ajax__calendar_title
        {
            color: #bbbbbb;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlInvoiceInput" runat="server" Width="100%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="6">
                                <div class="widgettitle">
                                    Invoice Input<asp:ScriptManager ID="ScriptManager1" runat="server">
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
                                &nbsp;
                            </td>
                            <td style="width: 150px">
                                &nbsp;
                            </td>
                            <td style="width: 230px">
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
                            <td class="label">
                                Invoice No
                            </td>
                            <td>
                                <asp:TextBox ID="txtInvoiceNumber" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldInvoiceNo" runat="server" ControlToValidate="txtInvoiceNumber"
                                    Display="None" ErrorMessage="Invoice No Required" ValidationGroup="GenerateInvoice"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldInvoiceNo_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldInvoiceNo" CloseImageUrl="~/Sources/images/valClose.png"
                                    CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td class="label">
                                Supplier
                            </td>
                            <td>
                                <asp:DropDownList ID="drpSupplier" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldSupplier" runat="server" ControlToValidate="drpSupplier"
                                    Display="None" ErrorMessage="Supplier Required" ValidationGroup="GenerateInvoice"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldSupplier_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldSupplier" CloseImageUrl="~/Sources/images/valClose.png"
                                    CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
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
                                Purchase Date
                            </td>
                            <td>
                                <asp:TextBox ID="txtPurchaseDate" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtPurchaseDate_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtPurchaseDate" CssClass="MyCalendarCss">
                                </cc1:CalendarExtender>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldPurchaseDate" runat="server" ControlToValidate="txtPurchaseDate"
                                    Display="None" ErrorMessage="Purchase Date Required" ValidationGroup="GenerateInvoice"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldPurchaseDate_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldPurchaseDate" CloseImageUrl="~/Sources/images/valClose.png"
                                    CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td class="label">
                                Total Cost
                            </td>
                            <td>
                                <asp:TextBox ID="txtInvoiceCost" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqFldTotalCost" runat="server" ControlToValidate="txtInvoiceCost"
                                    Display="None" ErrorMessage="Total Cost Against Invoice Required" ValidationGroup="GenerateInvoice"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldTotalCost_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldTotalCost" CloseImageUrl="~/Sources/images/valClose.png"
                                    CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Select Approver
                            </td>
                            <td>
                                <asp:DropDownList ID="drpApprover" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
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
                                <asp:Button ID="btnGenerateInvoice" runat="server" CssClass="styled-button-1" Text="Generate Invoice"
                                    ValidationGroup="GenerateInvoice" OnClientClick="if (!confirm('Are you Sure to Generate The Invoice ?')) return false" />
                                &nbsp;<asp:Button ID="btnCancelInvoiceInput" runat="server" CssClass="styled-button-1"
                                    Text="Cancel" />
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
                <asp:Panel ID="pnlListOfInvoice" runat="server" Width="100%" SkinID="pnlInner">
                    <div style="max-height: 300px; max-width: 880px; overflow: auto">
                        <asp:GridView ID="grdInvoiceList" runat="server" AutoGenerateColumns="False" CellPadding="4"
                            ForeColor="#333333" GridLines="None" CssClass="mGrid">
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <Columns>
                                <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                            Text="Select"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="InvoiceID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("InvoiceID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="InvoiceNo">
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("InvoiceNo") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SupplierID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("SupplierID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SupplierName">
                                    <ItemTemplate>
                                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("SupplierName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="InvoiceDate">
                                    <ItemTemplate>
                                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("InvoiceDate") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="InvoiceCost">
                                    <ItemTemplate>
                                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("InvoiceCost") %>'></asp:Label>
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

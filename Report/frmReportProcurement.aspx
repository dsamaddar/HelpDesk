<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/AIMaster.master" AutoEventWireup="false"
    CodeFile="frmReportProcurement.aspx.vb" Inherits="Report_frmReportProcurement"
    Title=".:Help Desk:Procurement Report:." %>

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
                <asp:Panel ID="pnlProcurementRptParameter" runat="server" Width="100%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="7">
                                <div class="widgettitle">
                                    Procurement Report<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px;" class="label">
                                Invoice Number
                            </td>
                            <td style="width: 230px">
                                <asp:TextBox ID="txtInvoiceNumber" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                            <td style="width: 20px">
                                &nbsp;
                            </td>
                            <td style="width: 150px">
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
                                Purchase Date From
                            </td>
                            <td>
                                <asp:TextBox ID="txtPurchaseDateFrom" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtPurchaseDateFrom_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtPurchaseDateFrom" CssClass="MyCalendarCss">
                                </cc1:CalendarExtender>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                To
                            </td>
                            <td>
                                <asp:TextBox ID="txtPurchaseDateTo" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtPurchaseDateTo_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtPurchaseDateTo" CssClass="MyCalendarCss">
                                </cc1:CalendarExtender>
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
                                Select Item
                            </td>
                            <td>
                                <asp:DropDownList ID="drpInventoryItems" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Supplier
                            </td>
                            <td>
                                <asp:DropDownList ID="drpSupplier" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnShowReport" runat="server" CssClass="styled-button-1" Text="Show Report" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" Text="Cancel" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <asp:Button ID="btnExportReport" runat="server" CssClass="styled-button-1" Text="Export" />
                            </td>
                            <td>
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
                <asp:Panel ID="pnlQueryResult" runat="server" Width="100%" SkinID="pnlInner">
                    <div style="max-height: 500px; max-width: 100%; overflow: auto">
                        <asp:GridView ID="grdQueryResult" runat="server" AutoGenerateColumns="False" CellPadding="4"
                            ForeColor="#333333" GridLines="None" CssClass="mGrid">
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <Columns>
                                <asp:BoundField DataField="InvoiceID" HeaderText="InvoiceID" Visible="False" />
                                <asp:BoundField DataField="InvoiceNo" HeaderText="InvoiceNo" />
                                <asp:BoundField DataField="InvoiceDate" HeaderText="Invoice Date" />
                                <asp:BoundField DataField="InvoiceCost" HeaderText="Invoice Cost" />
                                <asp:BoundField DataField="SupplierID" HeaderText="SupplierID" Visible="False" />
                                <asp:BoundField DataField="SupplierName" HeaderText="Supplier" />
                                <asp:BoundField DataField="ItemID" HeaderText="ItemID" Visible="False" />
                                <asp:BoundField DataField="ItemName" HeaderText="Item" />
                                <asp:BoundField DataField="Unit" HeaderText="Unit" />
                                <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                                <asp:BoundField DataField="UnitPrice" HeaderText="Unit Price" />
                                <asp:BoundField DataField="PreparedBy" HeaderText="Prepared By" />
                                <asp:BoundField DataField="IsApproved" HeaderText="IsApproved" />
                                <asp:BoundField DataField="ApprovedBy" HeaderText="ApprovedBy" />
                                <asp:BoundField DataField="ApprovalDate" HeaderText="ApprovalDate" />
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

<%@ Page Language="VB" Theme="CommonSkin"  MasterPageFile="~/AIMaster.master" AutoEventWireup="false" CodeFile="frmMakeProcurementRequest.aspx.vb" Inherits="Procurement_frmMakeProcurementRequest" title=".:Help Desk:Make Procurement Request:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width:100%;">
        <tr align="center" >
            <td>
                <asp:Panel ID="pnlMakeProcRequest" runat="server" Width="100%" 
                    SkinID="pnlInner" >
                    <table style="width:100%;">
                        <tr align="left">
                            <td colspan="6">
                                <div class="widgettitle">Make Procurement Request</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width:20px">
                            </td>
                            <td style="width:150px">
                            </td>
                            <td style="width:200px">
                            </td>
                            <td style="width:20px">
                            </td>
                            <td style="width:150px">
                            </td>
                            <td style="width:200px">
                            </td>
                        </tr>
                        <tr align="left">
                            <td></td>
                            <td class="label">
                                Select Item</td>
                            <td>
                                <asp:DropDownList ID="drpItemList" runat="server" 
                                    CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                                &nbsp;</td>
                            <td class="label">
                                Required Quantity</td>
                            <td>
                                <asp:TextBox ID="txtRequiredQuantity" runat="server" Width="200px" 
                                    CssClass="InputTxtBox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td></td>
                            <td></td>
                            <td>
                                <asp:Button ID="btnAddItems" runat="server" CssClass="styled-button-1" 
                                    Text="Add Items" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" 
                                    Text="Cancel" />
                            </td>
                            <td>&nbsp;</td>
                            <td>
                            </td>
                            <td></td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center" >
            <td>
                <asp:Panel ID="pnlProcRequiredList" runat="server" Width="100%" 
                    SkinID="pnlInner" >
                    <div>
                        <asp:GridView ID="grdProcRequestList" runat="server" CssClass="mGrid">
                        </asp:GridView>
                    </div>
                   
                </asp:Panel>
            </td>
        </tr>
        <tr align="center" >
            <td>
            </td>
        </tr>
        </table>
</asp:Content>


<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/AIMaster.master" AutoEventWireup="false" MaintainScrollPositionOnPostback="true"
    CodeFile="frmAcceptRequisition.aspx.vb" Inherits="AcceptRequisition_frmAcceptRequisition"
    Title=".:Help Desk:Accept Requisition:." %>

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
        .modal-inner-wrapper
        {
            width: 340px;
            height: 340px;
            background-color: Gray;
        }
        .modal-inner-wrapper .content
        {
            width: 320px;
            height: 320px;
            background-color: #FFFFFF;
            border: solid 1px Gray;
            z-index: 9999;
            float: right;
            margin-top: 10px;
            margin-right: 10px;
        }
        .modal-inner-wrapper .content .close
        {
            float: right;
        }
        .modal-inner-wrapper .content .body
        {
            margin-top: 20px;
        }
        .rounded-corners
        {
            /*FOR OTHER MAJOR BROWSERS*/
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            -khtml-border-radius: 5px;
            border-radius: 5px; /*FOR IE*/
            behavior: url(border-radius.htc);
        }
        .rel
        {
            position: relative;
            z-index: inherit;
            zoom: 1; /* For IE6 */
        }
        .modal-bg
        {
            background-color: Gray;
            filter: alpha(opacity=50);
            opacity: 0.6;
            z-index: 999;
        }
        .modal
        {
            position: absolute;
        }
    </style>
    <link href="../Sources/css/ModalPopupCSS.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        window.onload = function() {
            var strCook = document.cookie;
            if (strCook.indexOf("!~") != 0) {
                var intS = strCook.indexOf("!~");
                var intE = strCook.indexOf("~!");
                var strPos = strCook.substring(intS + 2, intE);
                document.getElementById("divRequisition").scrollTop = strPos;
                }
        }
        function SetDivPosition() {
            var intY = document.getElementById("divRequisition").scrollTop;
            document.title = intY;
            document.cookie = "yPos=!~" + intY + "~!";
        }
    </script>

    <table style="width: 100%;">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlRequisitionSearch" runat="server" Width="100%" 
                    SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="6">
                                <div class="widgettitle">
                                    Accept Requisition<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 230px">
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 230px">
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px" class="label">
                                Select Warehouse
                            </td>
                            <td style="width: 230px">
                                <asp:DropDownList ID="drpWareHouseList" runat="server" CssClass="InputTxtBox" Width="200px"
                                    AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 230px">
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 230px">
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 230px">
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Date From
                            </td>
                            <td>
                                <asp:TextBox ID="txtDateFrom" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtDateFrom_CalendarExtender" runat="server" CssClass="MyCalendarCss"
                                    Enabled="True" TargetControlID="txtDateFrom">
                                </cc1:CalendarExtender>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Date To
                            </td>
                            <td>
                                <asp:TextBox ID="txtDateTo" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtDateTo_CalendarExtender" runat="server" CssClass="MyCalendarCss"
                                    Enabled="True" TargetControlID="txtDateTo">
                                </cc1:CalendarExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Branch
                            </td>
                            <td>
                                <asp:DropDownList ID="drpBranch" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Department
                            </td>
                            <td>
                                <asp:DropDownList ID="drpDepartment" runat="server" AutoPostBack="True" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                User
                            </td>
                            <td>
                                <asp:DropDownList ID="drpUserList" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Item
                            </td>
                            <td>
                                <asp:DropDownList ID="drpItemList" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnShowRequisition" runat="server" CssClass="styled-button-1" Text="Show Requisition" />
                                &nbsp;
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnCancelSearch" runat="server" CssClass="styled-button-1" Text="Cancel" />
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
                <asp:Panel ID="pnlRequisitionList" runat="server" SkinID="pnlInner" 
                    Width="100%">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <div  id="divRequisition" onscroll="SetDivPosition()" style="max-height: 300px; max-width: 100%; overflow: auto">
                                    <asp:GridView ID="grdRequisition" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                        ForeColor="#333333" GridLines="None" EmptyDataText="No Requisition Found" CssClass="mGrid">
                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkBtnSelectReq" runat="server" CausesValidation="False" CommandName="Select"
                                                        Text="Select"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="RequisitionID" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRequisitionID" runat="server" Text='<%# Bind("RequisitionID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="EmployeeID" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmployeeID" runat="server" Text='<%# Bind("EmployeeID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Employee">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmployeeName" runat="server" Text='<%# Bind("EmployeeName") %>'></asp:Label>
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
                                            <asp:TemplateField HeaderText="RequisitionDate">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("RequisitionDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Quantity">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblQuantity" runat="server" Text='<%# Bind("Quantity") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Balance">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBalance" runat="server" Text='<%# Bind("Balance") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Remarks">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRemarks" runat="server" Text='<%# Bind("Remarks") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="BranchID" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBranchID" runat="server" Text='<%# Bind("BranchID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Branch">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBranchName" runat="server" Text='<%# Bind("BranchName") %>'></asp:Label>
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
                <asp:LinkButton ID="lnkBtnSelectReq" runat="server">Approve / Reject</asp:LinkButton>
                <cc1:ModalPopupExtender ID="lnkBtnSelectReq_ModalPopupExtender" runat="server" BackgroundCssClass="modalBackground"
                    CancelControlID="imgBtnClose" DropShadow="true" DynamicServicePath="" Enabled="True"
                    OkControlID="" OnOkScript="" PopupControlID="pnlApproveReqPopup" TargetControlID="lnkBtnSelectReq">
                </cc1:ModalPopupExtender>
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlApproveReqPopup" runat="server" Width="550px" CssClass="modalPopup"
                    Style="display: none">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td style="width: 20px">
                                &nbsp;
                            </td>
                            <td style="width: 150px">
                                &nbsp;
                            </td>
                            <td style="width: 250px">
                                &nbsp;
                            </td>
                            <td style="width: 20px" valign="top" align="right">
                                <asp:ImageButton ID="imgBtnClose" runat="server" Height="20px" ImageUrl="~/Sources/icons/close.png"
                                    Width="20px" ToolTip="Close" />
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                                &nbsp;
                            </td>
                            <td style="width: 150px" class="label">
                                Warehouse
                            </td>
                            <td style="width: 250px">
                                <asp:Label ID="lblWarehouseName" runat="server" CssClass="chkText"></asp:Label>
                            </td>
                            <td style="width: 20px">
                                &nbsp;
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                User
                            </td>
                            <td>
                                <asp:Label ID="lblUserName" runat="server" CssClass="chkText"></asp:Label>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Item
                            </td>
                            <td>
                                <asp:Label ID="lblItem" runat="server" CssClass="chkText"></asp:Label>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Available Balance
                            </td>
                            <td>
                                <asp:Label ID="lblAvailableBalance" runat="server" CssClass="chkText"></asp:Label>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Requested Quantity
                            </td>
                            <td>
                                <asp:Label ID="lblRequestedQuantity" runat="server" CssClass="chkText"></asp:Label>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Approved Quantity
                            </td>
                            <td>
                                <asp:TextBox ID="txtAppovedQuantity" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                &nbsp;<asp:RegularExpressionValidator ID="regExpApprovedQuantity" runat="server"
                                    ControlToValidate="txtAppovedQuantity" ErrorMessage="Invalid" ValidationExpression="^[1-9][0-9]*"
                                    ValidationGroup="AcceptRequisition"></asp:RegularExpressionValidator>
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
                                <asp:RequiredFieldValidator ID="reqFldApprovedQuantity" runat="server" ControlToValidate="txtAppovedQuantity"
                                    ErrorMessage="Approved Quantity Required" ValidationGroup="AcceptRequisition"></asp:RequiredFieldValidator>
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
                                <asp:Label ID="lblRemarks" runat="server" CssClass="label" Text="Remarks"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtRemarks" runat="server" CssClass="InputTxtBox" Height="50px"
                                    TextMode="MultiLine" Width="200px"></asp:TextBox>
                            </td>
                            <td>
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
                                <asp:RequiredFieldValidator ID="reqFldRejectionRemarks" runat="server" ControlToValidate="txtRemarks"
                                    ErrorMessage="Rejection Remarks Required" ValidationGroup="RejectRequisition"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td align="left">
                                <asp:Button ID="btnAccept" runat="server" CssClass="styled-button-1" Text="Accept"
                                    ValidationGroup="AcceptRequisition" OnClientClick="if (!confirm('Are you Sure to Accept The Requisition ?')) return false"
                                    ToolTip="Accept Requisition" />
                                &nbsp;<asp:Button ID="btnReject" runat="server" CssClass="styled-button-1" Text="Reject"
                                    ValidationGroup="RejectRequisition" OnClientClick="if (!confirm('Are you Sure to Reject The Requisition ?')) return false"
                                    ToolTip="Reject Requisition" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" Text="Cancel"
                                    Visible="False" />
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
</asp:Content>

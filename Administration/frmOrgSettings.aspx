<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/AIMaster.master" AutoEventWireup="false"
    CodeFile="frmOrgSettings.aspx.vb" Inherits="Administration_frmOrgSettings" Title=".:Help Desk:Organization Settings:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../Sources/css/AICssClass.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        window.onload = function() {
            var strCook = document.cookie;
            if (strCook.indexOf("!~") != 0) {
                var intS = strCook.indexOf("!~");
                var intE = strCook.indexOf("~!");
                var strPos = strCook.substring(intS + 2, intE);
                document.getElementById("divgrd").scrollTop = strPos;
            }
        }
        function SetDivPosition() {
            var intY = document.getElementById("divgrd").scrollTop;
            document.title = intY;
            document.cookie = "yPos=!~" + intY + "~!";
        }

        window.scrollBy(100, 100); 
    </script>

    <table style="width: 100%;">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlDesignationSettings" runat="server" Width="100%" 
                    SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td align="left" colspan="4">
                                <div class="widgettitle">
                                    Create/Edit Designation<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label" style="width: 20px; height: 20px;">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label" style="width: 20px">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                <b>Designation Name</b>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtDesignationName" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldDesignationName" runat="server" ControlToValidate="txtDesignationName"
                                    Display="None" ErrorMessage="Required" ValidationGroup="InputDesignation"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldDesignationName_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldDesignationName" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                <b>Designation Label</b>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlDesigLabel" runat="server" CssClass="InputTxtBox">
                                    <asp:ListItem Selected="True" Value="0">-Select-</asp:ListItem>
                                    <asp:ListItem Value="Management">Management</asp:ListItem>
                                    <asp:ListItem Value="Non-Management">Non-Management</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                <b>Designation Type</b>
                            </td>
                            <td align="left">
                                <asp:RadioButtonList ID="rdoDesignationType" runat="server" CssClass="rbdText" RepeatDirection="Horizontal">
                                    <asp:ListItem Enabled="true">Official</asp:ListItem>
                                    <asp:ListItem>Functional</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                <b>Health Plan</b>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlHealthPlan" runat="server" CssClass="InputTxtBox">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                <b>Order</b>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtOrder" runat="server" CssClass="InputTxtBox" Width="50px"></asp:TextBox>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                <b>Is Active</b>
                            </td>
                            <td align="left">
                                <asp:CheckBox ID="chkIsDesigActive" runat="server" CssClass="chkText" Text="         Is Active  " />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                            </td>
                            <td align="left">
                                <asp:Button ID="btnInsertDesignation" runat="server" CssClass="styled-button-1" Text="Insert"
                                    ValidationGroup="InputDesignation" />
                                &nbsp;<asp:Button ID="btnUpdateDesignation" runat="server" CssClass="styled-button-1"
                                    Text="Update" ValidationGroup="InputDesignation" />
                                &nbsp;<asp:Button ID="btnCancelSelection" runat="server" CssClass="styled-button-1"
                                    Text="Cancel" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                            </td>
                            <td align="left">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                <b>Available Designation</b>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="drpAvailableDesignation" runat="server" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
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
                &nbsp
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlAvailableLeaveType" runat="server" SkinID="pnlInner" 
                    Width="100%">
                    <table style="width: 100%;">
                        <tr align="center">
                            <td>
                            </td>
                            <td>
                                <div style="max-height: 200px; max-width: 680px; overflow: auto" id="divgrd" onscroll="SetDivPosition()">
                                    <asp:GridView ID="grdDesignation" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                        ForeColor="#333333" GridLines="None" CssClass="mGrid">
                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                                        CssClass="linkbtn" Text="Select"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="DesignationID" Visible="False">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("DesignationID") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDesignationID" runat="server" Text='<%# Bind("DesignationID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Designation Name">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtDesignationName" runat="server" Text='<%# Bind("DesignationName") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDesignationName" runat="server" Text='<%# Bind("DesignationName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Designation Label">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtDesignationLabel" runat="server" Text='<%# Bind("DesignationLabel") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDesignationLabel" runat="server" Text='<%# Bind("DesignationLabel") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Designation Type">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("DesignationType") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDesignationType" runat="server" Text='<%# Bind("DesignationType") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="HealthPlanID" Visible="False">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("HealthPlanID") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblHealthPlanID" runat="server" Text='<%# Bind("HealthPlanID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="HealthPlanName">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("HealthPlanName") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblHealthPlanName" runat="server" Text='<%# Bind("HealthPlanName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Order">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("intOrder") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblintOrder" runat="server" Text='<%# Bind("intOrder") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("isActive") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblisActive" runat="server" Text='<%# Bind("isActive") %>'></asp:Label>
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
        <tr align="center">
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
</asp:Content>

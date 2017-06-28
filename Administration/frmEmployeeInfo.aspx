<%@ Page Language="VB" MasterPageFile="~/AIMaster.master" AutoEventWireup="false"
    CodeFile="frmEmployeeInfo.aspx.vb" Inherits="Administration_frmEmployeeInfo"
    Theme="CommonSkin" Title=".:Chaser:Employee List:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table width="100%">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlEmpBasicInfo" runat="server" Width="100%" SkinID="pnlInner">
                    <table width="100%">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widget-title">
                                    Employee Info<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                                <asp:RequiredFieldValidator ID="reqFldEmpName" runat="server" 
                                    ControlToValidate="txtEmpName" Display="None" 
                                    ErrorMessage="Required: Employee Name" ValidationGroup="EmpInfo"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldEmpName_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="../Sources/img/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" TargetControlID="reqFldEmpName" 
                                    WarningIconImageUrl="../Sources/img/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td style="width: 200px">
                                <asp:HiddenField ID="hdFldEmployeeID" runat="server" />
                            </td>
                            <td style="width: 150px">
                                &nbsp;</td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Name
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmpName" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                            <td class="label">
                                Employee Code
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmpCode" runat="server" CssClass="InputTxtBox" Width="120px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldEmpCode" runat="server" 
                                    ControlToValidate="txtEmpCode" Display="None" 
                                    ErrorMessage="Required: Employee Code" ValidationGroup="EmpInfo"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldEmpCode_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="../Sources/img/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" TargetControlID="reqFldEmpCode" 
                                    WarningIconImageUrl="../Sources/img/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                User ID
                            </td>
                            <td>
                                <asp:TextBox ID="txtUserID" runat="server" CssClass="InputTxtBox" Width="120px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqFldUserID" runat="server" 
                                    ControlToValidate="txtUserID" Display="None" ErrorMessage="Required: User ID" 
                                    ValidationGroup="EmpInfo"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldUserID_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="../Sources/img/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" TargetControlID="reqFldUserID" 
                                    WarningIconImageUrl="../Sources/img/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td class="label">
                                Password
                            </td>
                            <td>
                                <asp:TextBox ID="txtUserPassword" runat="server" CssClass="InputTxtBox" 
                                    Width="120px" TextMode="Password"></asp:TextBox>
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                User Type
                            </td>
                            <td>
                                <asp:DropDownList ID="drpUserType" runat="server" Width="120px" CssClass="InputTxtBox">
                                    <asp:ListItem>User</asp:ListItem>
                                    <asp:ListItem>Admin</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldPassword" runat="server" 
                                    ControlToValidate="txtUserPassword" Display="None" 
                                    ErrorMessage="Required: Password" ValidationGroup="EmpInfo"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldPassword_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="../Sources/img/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" TargetControlID="reqFldPassword" 
                                    WarningIconImageUrl="../Sources/img/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Date Of Birth
                            </td>
                            <td>
                                <asp:TextBox ID="txtDateOfBirth" runat="server" CssClass="InputTxtBox" Width="120px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtDateOfBirth_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtDateOfBirth">
                                </cc1:CalendarExtender>
                            </td>
                            <td class="label">
                                Joining Date
                            </td>
                            <td>
                                <asp:TextBox ID="txtJoiningDate" runat="server" CssClass="InputTxtBox" Width="120px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtJoiningDate_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtJoiningDate">
                                </cc1:CalendarExtender>
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldDateOfBirth" runat="server" 
                                    ControlToValidate="txtDateOfBirth" Display="None" 
                                    ErrorMessage="Required: Date Of Birth" ValidationGroup="EmpInfo"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldDateOfBirth_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="../Sources/img/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" 
                                    TargetControlID="reqFldDateOfBirth" 
                                    WarningIconImageUrl="../Sources/img/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td class="label">
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldJoiningDate" runat="server" 
                                    ControlToValidate="txtJoiningDate" Display="None" 
                                    ErrorMessage="Required: Joining Date" ValidationGroup="EmpInfo"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldJoiningDate_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="../Sources/img/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" 
                                    TargetControlID="reqFldJoiningDate" 
                                    WarningIconImageUrl="../Sources/img/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlOrgInfo" runat="server" Width="100%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Designation
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlOfficialDesignation" runat="server" AutoPostBack="True"
                                    CssClass="InputTxtBox" TabIndex="3" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                                Department
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Branch
                            </td>
                            <td style="margin-left: 40px">
                                <asp:DropDownList ID="ddlULCBranch" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                                Current Supervisor
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCurrentSupervisor" runat="server" CssClass="InputTxtBox"
                                    TabIndex="7" Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Is Active
                            </td>
                            <td>
                                <asp:CheckBox ID="chkIsActive" runat="server" CssClass="chkText" Text="(Check If YES)" />
                            </td>
                            <td class="label">
                                Status
                            </td>
                            <td>
                                <asp:DropDownList ID="drpEmpStatus" runat="server">
                                    <asp:ListItem>Active</asp:ListItem>
                                    <asp:ListItem>InActive</asp:ListItem>
                                    <asp:ListItem>Resigned</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlButtons" runat="server" SkinID="pnlInner" Width="100%">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnInsert" runat="server" CssClass="styled-button-1" 
                                    Text="Insert" ValidationGroup="EmpInfo" />
                                &nbsp;<asp:Button ID="btnUpdate" runat="server" CssClass="styled-button-1" 
                                    Text="Update" ValidationGroup="EmpInfo" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" Text="Cancel" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
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
        <tr align="center">
            <td>
                <div style="max-width: 80%; max-height: 500px; overflow: auto">
                    <asp:GridView ID="grdEmployeeInfo" runat="server" AutoGenerateColumns="False" CssClass="mGrid">
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:TemplateField HeaderText="EmployeeID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lblEmployeeID" runat="server" Text='<%# Bind("EmployeeID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="EmployeeName">
                                <ItemTemplate>
                                    <asp:Label ID="lblEmployeeName" runat="server" Text='<%# Bind("EmployeeName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="UserID">
                                <ItemTemplate>
                                    <asp:Label ID="lblUserID" runat="server" Text='<%# Bind("UserID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="UserPassword" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lblpassword" runat="server" Text="****"></asp:Label>
                                    <asp:Label ID="lblUserPassword" runat="server" Text='<%# Bind("UserPassword") %>'
                                        Visible="false"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="UserType">
                                <ItemTemplate>
                                    <asp:Label ID="lblUserType" runat="server" Text='<%# Bind("UserType") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="EmpCode">
                                <ItemTemplate>
                                    <asp:Label ID="lblEmpCode" runat="server" Text='<%# Bind("EmpCode") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DateOfBirth">
                                <ItemTemplate>
                                    <asp:Label ID="lblDateOfBirth" runat="server" Text='<%# Bind("DateOfBirth") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="JoiningDate">
                                <ItemTemplate>
                                    <asp:Label ID="lblJoiningDate" runat="server" Text='<%# Bind("JoiningDate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DesignationID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lblDesignationID" runat="server" Text='<%# Bind("DesignationID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Designation">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Designation") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DepartmentID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lblDepartmentID" runat="server" Text='<%# Bind("DepartmentID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Department">
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Department") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ULCBranchID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lblULCBranchID" runat="server" Text='<%# Bind("ULCBranchID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Branch">
                                <ItemTemplate>
                                    <asp:Label ID="Label18" runat="server" Text='<%# Bind("Branch") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="CurrentSupervisor" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lblCurrentSupervisor" runat="server" Text='<%# Bind("CurrentSupervisor") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Supervisor">
                                <ItemTemplate>
                                    <asp:Label ID="Label19" runat="server" Text='<%# Bind("Supervisor") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="EmpStatus">
                                <ItemTemplate>
                                    <asp:Label ID="lblEmpStatus" runat="server" Text='<%# Bind("EmpStatus") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="IsActive">
                                <ItemTemplate>
                                    <asp:Label ID="lblIsActive" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="EntryBy" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="Label16" runat="server" Text='<%# Bind("EntryBy") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="EntryDate" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="Label17" runat="server" Text='<%# Bind("EntryDate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>


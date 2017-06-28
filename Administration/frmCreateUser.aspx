<%@ Page Language="VB" Theme="CommonSkin"  MasterPageFile="~/AIMaster.master" AutoEventWireup="false" CodeFile="frmCreateUser.aspx.vb" Inherits="Administration_frmCreateUser" title=".:Help Desk:Create User:." %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width:100%;">
        <tr>
            <td style="width:100%">
                <div class="widgettitle">Create/Edit User<asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                </div>
            </td>
        </tr>
        <tr>
            <td style="width:100%">
                <asp:Panel ID="pnlCreateUser" runat="server" Width="100%" SkinID="pnlInner" >
                    <table style="width:100%;">
                        <tr align="left" >
                            <td style="width:20px">
                                &nbsp;</td>
                            <td style="width:150px;">
                                &nbsp;</td>
                            <td style="width:230px">
                                <asp:HiddenField ID="hdFldUniqueUserID" runat="server" />
                            </td>
                            <td style="width:150px;">
                                &nbsp;</td>
                            <td style="width:230px">
                                &nbsp;</td>
                            <td style="width:20px">
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                User Name</td>
                            <td>
                                <asp:TextBox ID="txtUserName" runat="server" CssClass="InputTxtBox" 
                                    Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldUserName" runat="server" 
                                    ControlToValidate="txtUserName" Display="None" ValidationGroup="AddUser" 
                                    ErrorMessage="User Name Required"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldUserName_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldUserName" CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td class="label">
                                &nbsp;</td>
                            <td>
                                <asp:TextBox ID="txtDateOfBirth" runat="server" CssClass="InputTxtBox" 
                                    Width="200px" Visible="False">1/1/1900</asp:TextBox>
                                <cc1:CalendarExtender ID="txtDateOfBirth_CalendarExtender" runat="server" 
                                    Enabled="True" TargetControlID="txtDateOfBirth">
                                </cc1:CalendarExtender>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldDateOfBirth" runat="server" 
                                    ControlToValidate="txtDateOfBirth" Display="None" 
                                    ValidationGroup="AddUser" ErrorMessage="Date Of Birth Required"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldDateOfBirth_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldDateOfBirth" CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                User ID</td>
                            <td>
                                <asp:TextBox ID="txtUserID" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldUserID" runat="server" 
                                    ControlToValidate="txtUserID" Display="None" ValidationGroup="AddUser" 
                                    ErrorMessage="User ID Required"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldUserID_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldUserID" CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td class="label">
                                Password</td>
                            <td>
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="InputTxtBox" 
                                    Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldPassword" runat="server" 
                                    ControlToValidate="txtPassword" ValidationGroup="AddUser" Display="None" 
                                    ErrorMessage="Password Required"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldPassword_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldPassword" CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                Email</td>
                            <td>
                                <asp:TextBox ID="txtEmailAddress" runat="server" CssClass="InputTxtBox" 
                                    Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldEmail" runat="server" 
                                    ControlToValidate="txtEmailAddress" ValidationGroup="AddUser" 
                                    Display="None" ErrorMessage="Email Required"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldEmail_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldEmail" CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td class="label">
                                &nbsp;</td>
                            <td>
                                <asp:DropDownList ID="drpUserType" runat="server" CssClass="InputTxtBox" 
                                    Width="200px" Visible="False">
                                    <asp:ListItem>User</asp:ListItem>
                                    <asp:ListItem>Admin</asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                Gender</td>
                            <td>
                                <asp:DropDownList ID="drpGender" runat="server" CssClass="InputTxtBox" 
                                    Width="80px">
                                    <asp:ListItem>Male</asp:ListItem>
                                    <asp:ListItem>Female</asp:ListItem>
                                    <asp:ListItem>Others</asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldGender" runat="server" 
                                    ControlToValidate="drpGender" ValidationGroup="AddUser" Display="None" 
                                    ErrorMessage="Gender Required"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldGender_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldGender" CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td class="label">
                                Contact Number</td>
                            <td>
                                <asp:TextBox ID="txtContactNumber" runat="server" CssClass="InputTxtBox" 
                                    Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldContactNumber" runat="server" 
                                    Display="None" ErrorMessage="Contact Number Required" 
                                    ControlToValidate="txtContactNumber" ValidationGroup="AddUser"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldContactNumber_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldContactNumber" CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                Supervisor</td>
                            <td>
                                <asp:DropDownList ID="drpSupervisor" runat="server" CssClass="InputTxtBox" 
                                    Width="200px">
                                </asp:DropDownList>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldSupervisor" runat="server" 
                                    ControlToValidate="drpSupervisor" ValidationGroup="AddUser" Display="None" 
                                    ErrorMessage="Supervisor Required"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldSupervisor_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldSupervisor"  CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td class="label">
                                Dept.</td>
                            <td>
                                <asp:DropDownList ID="drpDeptList" runat="server" CssClass="InputTxtBox" 
                                    Width="200px">
                                </asp:DropDownList>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldDepartment" runat="server" 
                                    Display="None" ErrorMessage="Department Required" 
                                    ValidationGroup="AddUser" ControlToValidate="drpDeptList"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldDepartment_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldDepartment"  CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                Active</td>
                            <td>
                                <asp:CheckBox ID="chkIsActiveUser" runat="server" Text="Is Active" 
                                    CssClass="chkText" />
                            </td>
                            <td class="label">
                                Branch</td>
                            <td>
                                <asp:DropDownList ID="drpBranch" runat="server" CssClass="InputTxtBox" 
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                &nbsp;</td>
                            <td>
                                <asp:Button ID="btnAddUser" runat="server" Text="ADD User" 
                                    ValidationGroup="AddUser" CssClass="styled-button-1" />
                                &nbsp;<asp:Button ID="btnUpdateUser" runat="server" CssClass="styled-button-1" 
                                    Text="Update" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                                    CssClass="styled-button-1" />
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;</td>
                            <td class="label">
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
        <tr>
            <td style="width:100%" align="center" >
                <asp:Panel ID="pnlAvailableUsers" runat="server" Width="100%" SkinID="pnlInner" >
                    <div style="max-height:300px;max-width:900px;overflow:auto">
                        <asp:GridView ID="grdDetailsUserList" runat="server" 
                            AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" 
                            GridLines="None" CssClass="mGrid">
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <Columns>
                                <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                            CommandName="Select" Text="Select"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="UniqueUserID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUniqueUserID" runat="server" Text='<%# Bind("UniqueUserID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("UniqueUserID") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="UserName">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUserName" runat="server" Text='<%# Bind("UserName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("UserName") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="UserID">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUserID" runat="server" Text='<%# Bind("UserID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("UserID") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="UserPassword">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUserPassword" Visible="false" runat="server" Text='<%# Bind("UserPassword") %>'></asp:Label>
                                        <asp:Label ID="Label1" runat="server" Text="*****"></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox4" TextMode="Password"  runat="server" Text='<%# Bind("UserPassword") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DateOfBirth" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDateOfBirth" runat="server" Text='<%# Bind("DateOfBirth") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("DateOfBirth") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Email">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEmail" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("Email") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="UserType" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUserType" runat="server" Text='<%# Bind("UserType") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("UserType") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Gender">
                                    <ItemTemplate>
                                        <asp:Label ID="lblGender" runat="server" Text='<%# Bind("Gender") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("Gender") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ContactNumber">
                                    <ItemTemplate>
                                        <asp:Label ID="lblContactNumber" runat="server" Text='<%# Bind("ContactNumber") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("ContactNumber") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SupervisorID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSupervisorID" runat="server" Text='<%# Bind("SupervisorID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("SupervisorID") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Supervisor" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblSupervisor" runat="server" Text='<%# Bind("Supervisor") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox16" runat="server" Text='<%# Bind("Supervisor") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="DepartmentID" Visible="false" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblDepartmentID" runat="server" Text='<%# Bind("DepartmentID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox17" runat="server" Text='<%# Bind("DepartmentID") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>                                
                                <asp:TemplateField HeaderText="Department">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDepartment" runat="server" Text='<%# Bind("Department") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox17" runat="server" Text='<%# Bind("Department") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="BranchID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBranchID" runat="server" Text='<%# Bind("BranchID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox13" runat="server" Text='<%# Bind("BranchID") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Branch">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBranch" runat="server" Text='<%# Bind("Branch") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox18" runat="server" Text='<%# Bind("Branch") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="IsActive">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsActive" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox12" runat="server" Text='<%# Bind("IsActive") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EntryBy">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEntryBy" runat="server" Text='<%# Bind("EntryBy") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox15" runat="server" Text='<%# Bind("EntryBy") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EntryDate">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEntryDate" runat="server" Text='<%# Bind("EntryDate") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox14" runat="server" Text='<%# Bind("EntryDate") %>'></asp:TextBox>
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
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>


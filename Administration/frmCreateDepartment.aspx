<%@ Page Language="VB" Theme="CommonSkin"  MasterPageFile="~/AIMaster.master" AutoEventWireup="false" CodeFile="frmCreateDepartment.aspx.vb" Inherits="Administration_frmCreateDepartment" title=".:Help Desk:Create Dept:." %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width:100%;">
        <tr align="center">
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
            <td></td>
            <td style="width:575px">
                <div class="widgettitle">Create/Edit Department</div>
            </td>
            <td></td>
        </tr>
        <tr  align="center" >
            <td>
                &nbsp;</td>
            <td>
                <asp:Panel ID="pnlCreateDept" runat="server" Width="700px" SkinID="pnlInner" >
                    <table style="width:100%;">
                        <tr align="left" >
                            <td style="width:20px">
                                &nbsp;</td>
                            <td style="width:150px">
                                &nbsp;</td>
                            <td style="width:230px">
                                <asp:HiddenField ID="hdFldDepartmentID" runat="server" />
                            </td>
                            <td style="width:180px">
                                &nbsp;</td>
                            <td style="width:20px">
                                &nbsp;</td>
                        </tr>
                        <tr align="left" >
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                Dept. Name</td>
                            <td>
                                <asp:TextBox ID="txtDeptName" runat="server" Width="200px" 
                                    CssClass="InputTxtBox"></asp:TextBox>
                                &nbsp;</td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldDeptName" runat="server" 
                                    ControlToValidate="txtDeptName" ValidationGroup="AddDept" Display="None" 
                                    ErrorMessage="Department Name Required"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldDeptName_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldDeptName" CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                Dept. Code</td>
                            <td>
                                <asp:TextBox ID="txtDeptCode" runat="server" Width="200px" 
                                    CssClass="InputTxtBox"></asp:TextBox>
                                &nbsp;</td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldDeptCode" runat="server" 
                                    ControlToValidate="txtDeptCode" ValidationGroup="AddDept" Display="None" 
                                    ErrorMessage="Department Code Required"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldDeptCode_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldDeptCode" CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                Dept. Head</td>
                            <td>
                                <asp:DropDownList ID="drpDeptHead" runat="server" Width="200px" 
                                    CssClass="InputTxtBox">
                                </asp:DropDownList>
                                &nbsp;</td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldDeptHead" runat="server" 
                                    ControlToValidate="drpDeptHead" ValidationGroup="AddDept" Display="None" 
                                    ErrorMessage="Department Head Required"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldDeptHead_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldDeptHead" CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                Dept. Mail Addr</td>
                            <td >
                                <asp:TextBox ID="txtDeptMailAddress" runat="server" CssClass="InputTxtBox" 
                                    Width="200px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldDeptMailAddress" runat="server" 
                                    ControlToValidate="txtDeptMailAddress" ValidationGroup="AddDept" 
                                    Display="None" ErrorMessage="Department Mail Address Required"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldDeptMailAddress_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="reqFldDeptMailAddress" CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                                &nbsp;<asp:RegularExpressionValidator ID="regExpValDeptMailAddress" runat="server" 
                                    ControlToValidate="txtDeptMailAddress" Display="None" 
                                    ErrorMessage="Invalid Mail Address" 
                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                                    ValidationGroup="AddDept"></asp:RegularExpressionValidator>
                                <cc1:ValidatorCalloutExtender ID="regExpValDeptMailAddress_ValidatorCalloutExtender" 
                                    runat="server" Enabled="True" TargetControlID="regExpValDeptMailAddress" CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td class="style1">
                                &nbsp;</td>
                            <td class="label">
                                Active</td>
                            <td>
                                <asp:CheckBox ID="chkDeptIsActive" runat="server" Text="Is Active" 
                                    CssClass="chkText" />
                            </td>
                            <td>
                                &nbsp;</td>
                            <td class="style1">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td>
                                </td>
                            <td align="left">
                                <asp:Button ID="btnAddDept" runat="server" Text="ADD" 
                                    ValidationGroup="AddDept" CssClass="styled-button-1" />
                                &nbsp;<asp:Button ID="btnUpdateDepartment" runat="server" CssClass="styled-button-1" 
                                    Text="Update" ValidationGroup="AddDept" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                                    CssClass="styled-button-1" />
                            </td>
                            <td align="left">
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td align="left">
                                &nbsp;</td>
                            <td align="left">
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr align="center" >
            <td>
                &nbsp;</td>
            <td>
                <asp:Panel ID="pnlAvailableDepartment" runat="server" Width="700px" 
                    SkinID="pnlInner" >
                    <div style="max-height:250px;max-width:680px;overflow:auto">
                        <asp:GridView ID="grdAvailableDept" runat="server" AutoGenerateColumns="False" 
                            CellPadding="4" ForeColor="#333333" GridLines="None" CssClass="mGrid">
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <Columns>
                                <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkBtnSelect" runat="server" CausesValidation="False" 
                                            CommandName="Select" Text="Select"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DepartmentID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDepartmentID" runat="server" Text='<%# Bind("DepartmentID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("DepartmentID") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Department">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDepartmentName" runat="server" Text='<%# Bind("DepartmentName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("DepartmentName") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Code">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDeptCode" runat="server" Text='<%# Bind("DeptCode") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("DeptCode") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="HODID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblHODID" runat="server" Text='<%# Bind("HODID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("HODID") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="HOD">
                                    <ItemTemplate>
                                        <asp:Label ID="lblHOD" runat="server" Text='<%# Bind("HOD") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("HOD") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Dept. Mail">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDeptMailAddress" runat="server" Text='<%# Bind("DeptMailAddress") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("DeptMailAddress") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Is Active">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsActive" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("IsActive") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EntryBy">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEntryBy" runat="server" Text='<%# Bind("EntryBy") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("EntryBy") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EntryDate">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEntryDate" runat="server" Text='<%# Bind("EntryDate") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("EntryDate") %>'></asp:TextBox>
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
            <td>
                &nbsp;</td>
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
</asp:Content>


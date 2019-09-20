<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Make.aspx.cs" Inherits="ColorMix.Admin.Make" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 80%; margin: 20px auto">
        <tr>
            <td>Car:&nbsp;<asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>&nbsp;
                <asp:Button ID="btnSearch" class="btn btn-info" runat="server" Text="Button" OnClick="btnSearch_Click" /></td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                    BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4"
                    OnPageIndexChanging="GridView1_PageIndexChanging"
                    OnRowCancelingEdit="GridView1_RowCancelingEdit"
                    OnRowDataBound="GridView1_RowDataBound" OnRowDeleting="GridView1_RowDeleting"
                    OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" Width="100%">
                    <RowStyle BackColor="White" ForeColor="#003399" />
                    <Columns>
                        <asp:CommandField ShowEditButton="True" />
                        <asp:CommandField ShowDeleteButton="True" />
                        <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True"
                            SortExpression="ID" />
                        <asp:TemplateField HeaderText="Make" SortExpression="Car">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtMake" runat="server" Text='<%# Bind("Car") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Car") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="IsCompnay?" SortExpression="IsCompany">
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkComp" runat="server" Checked='<%# Bind("IsCompany") %>'></asp:CheckBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkCompText" Enabled="False" runat="server" Checked='<%# Bind("IsCompany") %>'></asp:CheckBox>
                            </ItemTemplate>
                        </asp:TemplateField>



                    </Columns>
                    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
                <asp:LinkButton ID="lbtnAdd" runat="server" OnClick="lbtnAdd_Click">Add New</asp:LinkButton></td>
        </tr>
        <tr>

            <td>
                <asp:Panel ID="pnlAdd" runat="server" Visible="False">
                    Car:
            <asp:TextBox ID="txtCar" runat="server"></asp:TextBox>
                    <br />
                    <br />
                    <asp:CheckBox ID="chkCompany" runat="server" />
                    Is Company:
            
            <br />
                    <br />
                    <asp:LinkButton ID="lbtnSubmit" runat="server" OnClick="lbtnSubmit_Click">Save</asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;
            <asp:LinkButton ID="lbtnCancel" runat="server" OnClick="lbtnCancel_Click">Cancel</asp:LinkButton>

                </asp:Panel>
            </td>
        </tr>


    </table>
</asp:Content>

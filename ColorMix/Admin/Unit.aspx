<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Unit.aspx.cs" Inherits="ColorMix.Admin.Unit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 80%; margin: 20px auto">
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
                        <asp:TemplateField HeaderText="Unit" SortExpression="Name">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUnit" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
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
                <asp:LinkButton ID="lbtnAdd" runat="server" OnClick="lbtnAdd_Click">Add New</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlAdd" runat="server" Visible="False">
                    Unit:
            <asp:TextBox ID="txtUnit" runat="server"></asp:TextBox>
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

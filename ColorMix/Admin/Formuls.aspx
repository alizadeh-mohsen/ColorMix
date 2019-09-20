<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Formuls.aspx.cs" Inherits="ColorMix.Admin.Formul" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel  ID="Panel1" runat="server" DefaultButton="btnSearch">
        <table style="margin: 10px auto; width: 90%">
            <tr>

                <td>
                    <span style="width: 100px; display: block">Color Code:</span>
                    <asp:TextBox ID="txtCode"  runat="server"></asp:TextBox>
                </td>

            </tr>
            <tr>
                <td><span style="width: 100px; display: block">Make:</span>
                    <asp:DropDownList ID="ddlCar"  runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>

                <td><span style="width: 100px; display: block">Company:</span>
                    <asp:DropDownList ID="ddlCompany"  runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>

                <td><span style="width: 100px; display: block">Color Type:</span>
                    <asp:DropDownList ID="ddlColorType"  runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>

                <td><span style="width: 100px; display: block">Description:</span>
                    <asp:TextBox ID="txtDesc"  runat="server" Width="200px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    <asp:Button class="btn btn-primary" ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                    &nbsp;<asp:Button ID="btnClear" class="btn btn-primary" runat="server" Text="Clear" OnClick="btnClear_Click" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:GridView ID="SearchGrid" runat="server" AutoGenerateColumns="True" BackColor="White"
                        BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4"
                        OnPageIndexChanging="SearchGrid_PageIndexChanging" Width="100%" AllowPaging="True"
                        OnSelectedIndexChanged="SearchGrid_SelectedIndexChanged">
                        <RowStyle BackColor="White" ForeColor="#003399" />
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
                        </Columns>
                        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="red"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AddFormul.aspx.cs" Inherits="ColorMix.Admin.AddFormul" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 10%; margin: 20px auto">
        <tr>
            <td><span style="font-weight: bold; width: 100px; display: block">Make:</span>
                <asp:DropDownList ID="ddlMake" runat="server" Width="150px"></asp:DropDownList></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td><span style="font-weight: bold; width: 100px; display: block">Company:</span>
                <asp:DropDownList ID="ddlCompany" runat="server" Width="150px"></asp:DropDownList></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td><span style="font-weight: bold; width: 100px; display: block">Color Group:</span>
                <asp:DropDownList ID="ddlColorGroup" runat="server" Width="150px"></asp:DropDownList></td><td>&nbsp;</td>
        </tr>
        <tr>
            <td><span style="font-weight: bold; width: 100px; display: block">Color Code:</span>
                <asp:TextBox ID="txtColorCode" runat="server" Width="150px"></asp:TextBox></td><td>&nbsp;</td>
        </tr>
        <tr>
            <td><span style="font-weight: bold; width: 100px; display: block">Unit:</span>
                <asp:DropDownList ID="ddlUnit" runat="server" Width="150px"></asp:DropDownList></td><td>&nbsp;</td>
        </tr>
        <tr>
            <td><span style="font-weight: bold; width: 100px; display: block">Base Color:</span></td>
            <td><span style="font-weight: bold; width: 100px; display: block">Weight:</span></td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtBaseColor" runat="server" Width="100%"></asp:TextBox></td>
            <td>
                <asp:TextBox ID="txtWeight" runat="server" Width="140px"></asp:TextBox>
                <asp:Button ID="btnAdd" runat="server" OnClick="btnAdd_Click" Text="Add" />
            </td>
        </tr>

        <tr>
            <td>
                <asp:ListBox ID="lstBaseColor" runat="server" Height="200px" Width="100%" OnSelectedIndexChanged="lstBaseColor_SelectedIndexChanged"></asp:ListBox></td>
            <td>
                <asp:ListBox ID="lstWeight" runat="server" Height="200px" Width="150px" OnSelectedIndexChanged="lstWeight_SelectedIndexChanged"></asp:ListBox></td>
        </tr>
        <tr>
            <td><span style="font-weight: bold; width: 100px; display: block">Total:</span></td>
            <td>
                <asp:Label ID="lblTotal" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td><span style="font-weight: bold; width: 100px; display: block">Decsription:</span></td>
            <td></td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:TextBox ID="txtColorDesc" runat="server" Height="150px" TextMode="MultiLine" Width="400px"></asp:TextBox></td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="btnSave" Class="btn btn-primary" runat="server" Text="Button" OnClick="btnSave_Click" /></td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label></td>
        </tr>
    </table>
</asp:Content>

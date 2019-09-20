<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Notes.aspx.cs" Inherits="ColorMix.Admin.Notes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 80%; margin: 20px auto">
        <tr>
            <td>
                <asp:TextBox ID="txtNote" runat="server" Height="600px" TextMode="MultiLine" Width="900px" BackColor="#FFFFCC"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button Class="btn btn-primary" ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
            </td>
        </tr>
    </table>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="UpdateFormul.aspx.cs" Inherits="ColorMix.Admin.UpdateFormul" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="margin: 10px auto; width: 90%">
        <tr>
            <td >
                <asp:Button ID="btnDelete" class="btn btn-danger" runat="server" Text="Delete Formul" OnClientClick="if(!confirm('Delete ?')) return false;" OnClick="btnDelete_Click" />
                &nbsp;<asp:Button ID="btnSaveColor" class="btn btn-success" runat="server" Text="Update Color" OnClick="btnSaveColor_Click" />
                <asp:Button ID="btnSaveFomrul" class="btn btn-primary" runat="server" Text="Update Formul" OnClick="btnSaveFomrul_Click" />
                &nbsp;
            </td>
            <td><asp:Label ID="lblMessage" runat="server" Text="" ForeColor="red"></asp:Label></td>
        </tr>
        <tr>
            <td>
                <table style="width: 50%">
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td><span style="font-weight: bold; width: 100px; display: block">Color Code:</span><asp:TextBox ID="txtColorCode" runat="server" Width="150px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td><span style="font-weight: bold; width: 100px; display: block">Unit: </span>
                            <asp:DropDownList ID="ddlUnit" runat="server" Width="150px"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td><span style="font-weight: bold; width: 100px; display: block">Make: </span>
                            <asp:DropDownList ID="ddlMake" runat="server" Width="150px"></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td><span style="font-weight: bold; width: 100px; display: block">ColorType: </span>
                            <asp:DropDownList ID="ddlColorType" runat="server" Width="150px"></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td><span style="font-weight: bold; width: 100px; display: block">Last update:</span>
                            <asp:TextBox ID="txtDate" runat="server" TextMode="Date" Width="150px"></asp:TextBox>
                            <asp:Label ID="lblDate" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="chkLock" runat="server" Text="Lock" />
                        </td>
                    </tr>
                    <tr>
                        <td><span style="font-weight: bold; width: 100px; display: block">Description:</span>
                            <asp:TextBox ID="txtDesc" runat="server" Height="250px" TextMode="MultiLine" Width="400px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                </table>
            </td>
            <td>
                <table style="width: 50%">
                    <tr>
                        <td><strong>Base Color:</strong></td>

                        <td><strong>Weight:</strong><br />
                        </td>

                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtBaseColor" runat="server"></asp:TextBox>
                        </td>

                        <td>
                            <asp:TextBox ID="txtWeight" runat="server"></asp:TextBox>
                        </td>

                        <td>
                            <asp:Button ID="btnWeight" Class="btn btn-info" runat="server" OnClick="btnWeight_Click" Text="Add" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:ListBox ID="lstBaseColor" runat="server" OnSelectedIndexChanged="lstColor_SelectedIndexChanged" AutoPostBack="True" Height="250px" Width="100%"></asp:ListBox></td>
                        <td>
                            <asp:ListBox ID="lstWeight" runat="server" OnSelectedIndexChanged="lstWeight_SelectedIndexChanged" AutoPostBack="True" Height="250px" Width="100%"></asp:ListBox>

                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td><strong>
                            Total:</strong>
                            <asp:Label ID="lblTotal" runat="server" Text=""></asp:Label></td>

                        <td>&nbsp;</td>

                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>

                        <td>&nbsp;</td>

                    </tr>
                    <tr>
                        <td></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>



</asp:Content>

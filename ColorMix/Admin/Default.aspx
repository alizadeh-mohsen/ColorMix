<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ColorMix.Admin.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="icon" type="image/png" href="../Images/9.png" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="../CSS/font-awesome.css" rel="stylesheet" />
    <link href="../CSS/main.css" rel="stylesheet" />
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/jquery-1.10.2.min.js"></script>
</head>
<body style="background-color: #ccddff">
    <form id="form1" runat="server">
        <div>
            <asp:Panel ID="Panel1" DefaultButton="btnLogin" runat="server">
                <table style="margin: 0 auto;width: 20%" class="table">
                    <tr>

                        <td>
                           <label> Pssword:</label>
                            <asp:TextBox Class="form-control" ID="txtPassword" runat="server"></asp:TextBox>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <asp:Button ID="btnLogin" Class="btn btn-primary" runat="server" Text="Login" OnClick="btnLogin_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Text=""></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
    </form>
</body>
</html>

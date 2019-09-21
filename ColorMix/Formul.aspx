﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Formul.aspx.cs" Inherits="ColorMix.Formul" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <div class="row">
            <table style="width: 60%; margin: 0 auto; font-size: 14px">
                <tr>
                    <td>
                        <p>
                            کد رنگ &nbsp;: &nbsp;
                    <asp:Label ID="lblColorCode" runat="server" Font-Bold="True" ForeColor="#FF0066"></asp:Label>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    اتومبیل/شرکت&nbsp; :&nbsp;
                <asp:Label ID="lblMake" runat="server" Font-Bold="True" ForeColor="#FF0066"></asp:Label>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    نوع رنگ &nbsp;:&nbsp;
                <asp:Label ID="lblColorType" runat="server" Font-Bold="True" ForeColor="#FF0066"></asp:Label>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    واحد &nbsp;:&nbsp;
                <asp:Label ID="lblUnit" runat="server" Font-Bold="True" ForeColor="#FF0066"></asp:Label>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView ID="FormulGrid" runat="server" CellPadding="4"
                            Width="100%" AllowPaging="True"
                            GridLines="None" AutoGenerateColumns="False" ForeColor="#333333" ShowHeaderWhenEmpty="True" OnRowCommand="FormulGrid_RowCommand">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:TemplateField HeaderText="کد رنگ">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnSelect" runat="server" CommandArgument='<%# Bind("Weight") %>' Text='<%# Bind("Code") %>' CommandName="select" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Weight" HeaderText="وزن" />
                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <EmptyDataRowStyle BackColor="#CCCCCC" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                            <EmptyDataTemplate>فرمولی با این مشخصات یافت نشد</EmptyDataTemplate>
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td>وزن کل :
                        <asp:Label ID="lblTotal" runat="server" Text=""></asp:Label>
                        &nbsp; گرم
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <div class="form-group">
                            <label style="color: black">
                                <strong>محاسبه مجدد فرمول بر اساس وزن کل بر حسب گرم:</strong></label>
                            <asp:TextBox ID="txtBuildBase" CssClass="form-control" Style="text-align: left; width: 150px;" runat="server"></asp:TextBox>
                            <asp:Button ID="btnCalculate" CssClass="btn btn-primary" runat="server" Text="محاسبه" OnClick="btnCalculate_Click" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel Visible="False" ID="pnlWeight" runat="server">
                            <div class="form-group">
                                <label style="color: black">
                                    <strong>محاسبه مجدد فرمول بر اساس تغییر وزن&nbsp;<span style="color: red">
                                        <asp:Literal runat="server" ID="ltCode"></asp:Literal></span>:</strong></label>

                                <asp:TextBox ID="txtEasyMix" CssClass="form-control" Style="text-align: left; width: 150px;" runat="server"></asp:TextBox>

                                <asp:Button ID="btnEasyMix" CssClass="btn btn-primary" runat="server" Text="محاسبه" OnClick="btnEasyMix_Click" />

                            </div>
                        </asp:Panel>

                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>

                <tr>
                    <td>
                        <div class="form-group">
                            <asp:Label ID="lblMessage" ForeColor="Red" runat="server" Text=""></asp:Label>
                            <asp:HiddenField ID="hfSelectedWeight" runat="server" />
                            <asp:HiddenField ID="hfTable" runat="server" />
                        </div>
                    </td>
                </tr>
                <%-- <tr>
                    <td>
                        <button class="btn btn-primary" onclick="window.print();">Print</button></td>
                </tr>--%>
            </table>
        </div>
    </div>
</asp:Content>
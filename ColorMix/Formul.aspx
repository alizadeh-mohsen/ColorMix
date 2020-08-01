<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Formul.aspx.cs" Inherits="ColorMix.Formul" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container  ">
        <div class="row justify-content-center">
            <div class="col-lg-10 ">
                <table class="table table-borderless">
                     <tr>
                    <td>
                        <button class="btn btn-success" onclick="window.print();">Print</button></td>
                </tr>
                    <tr>
                        <td>کد رنگ</td>
                        <td>اتومبیل/شرکت</td>
                        <td>نوع رنگ
                        </td>
                        <td>آخرین تغییر
                        </td>
                        <td>واحد
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblColorCode" runat="server" ForeColor="red"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblMake" runat="server" ForeColor="red"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblColorType" runat="server" ForeColor="red"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblLastUpdate" runat="server" ForeColor="red"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblUnit" runat="server" ForeColor="red"></asp:Label>
                        </td>

                    </tr>
                    
                    <tr>
                        <td colspan="5">توضیحات:
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <asp:Label ID="lblComment" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="5">
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
                        <td colspan="5">وزن کل :
                        <asp:Label ID="lblTotal" runat="server" Text=""></asp:Label>
                            &nbsp; گرم
                        </td>
                    </tr>
                    
                <tr>
                    <td colspan="5">
                        <div class="form-group">
                            <label style="color: black">
                                <strong>محاسبه مجدد فرمول بر اساس وزن کل بر حسب گرم:</strong></label>
                            <asp:TextBox ID="txtBuildBase" class="form-control my-2" Style="text-align: left; width: 150px;" runat="server"></asp:TextBox>
                            <asp:Button ID="btnCalculate" class="btn btn-primary" runat="server" Text="محاسبه" OnClick="btnCalculate_Click" />
                        </div>
                    </td>
                </tr>
                    <tr>
                        <td colspan="5">
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
                        <td colspan="5">
                            <div class="form-group">
                                <asp:Label ID="lblMessage" ForeColor="Red" runat="server" Text=""></asp:Label>
                                <asp:HiddenField ID="hfSelectedWeight" runat="server" />
                                <asp:HiddenField ID="hfTable" runat="server" />
                            </div>
                        </td>
                    </tr>

                </table>
            </div>
        </div>
    </div>
</asp:Content>

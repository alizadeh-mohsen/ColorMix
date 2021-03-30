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
                            <button class="btn btn-success" onclick="window.print();">Print</button>
                        </td>
                    </tr>
                    <tr>
                        <td>کد</td>
                        <td>برند</td>
                        <td>نوع</td>
                        <td>تاریخ
                        </td>
                        <td>واحد
                        </td>
                        <td>دقت
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblColorCode" runat="server" ForeColor="blue"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblMake" runat="server" ForeColor="blue"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblColorType" runat="server" ForeColor="blue"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblLastUpdate" runat="server" ForeColor="blue"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblUnit" runat="server" ForeColor="blue"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblAccuracy" runat="server" ForeColor="blue"></asp:Label>
                        </td>

                    </tr>

                    <tr>
                        <td colspan="6">توضیحات:
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <asp:Label ID="lblComment" ForeColor="blue" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">موارد کاربرد:  <asp:Label ID="lblUsage" ForeColor="blue" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr >
                        <td colspan="6" class="justify-content-center">
                            <asp:GridView ID="FormulGrid" runat="server" CellPadding="4"
                                Width="90%" AllowPaging="True" 
                                GridLines="None" AutoGenerateColumns="False" ForeColor="#333333" ShowHeaderWhenEmpty="True" OnRowCommand="FormulGrid_RowCommand" BorderStyle="Solid">
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <Columns>
                                    <asp:TemplateField HeaderText="کد">
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
                        <td colspan="6">وزن کل :
                        <asp:Label ID="lblTotal" runat="server" Text=""></asp:Label>
                            &nbsp; گرم
                        </td>
                    </tr>

                    <tr>
                        <td colspan="6">
                            <div class="form-group">
                                <label style="color: black">
                                    <strong>محاسبه مجدد فرمول بر اساس وزن کل بر حسب گرم:</strong></label>
                                <asp:TextBox ID="txtBuildBase" class="form-control my-2" Style="text-align: left; width: 150px;" runat="server"></asp:TextBox>
                                <asp:Button ID="btnCalculate" class="btn btn-primary" runat="server" Text="محاسبه" OnClick="btnCalculate_Click" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <asp:Panel Visible="False" ID="pnlWeight" runat="server">
                                <div class="form-group">
                                    <label style="color: black">
                                        <strong>محاسبه مجدد فرمول بر اساس تغییر وزن&nbsp;<span style="color: blue">
                                            <asp:Literal runat="server" ID="ltCode"></asp:Literal></span>:</strong></label>
                                    <asp:TextBox ID="txtEasyMix" CssClass="form-control" Style="text-align: left; width: 150px;" runat="server"></asp:TextBox>
                                    <asp:Button ID="btnEasyMix" CssClass="btn btn-primary" runat="server" Text="محاسبه" OnClick="btnEasyMix_Click" />
                                </div>
                            </asp:Panel>

                        </td>
                    </tr>

                    <tr>
                        <td colspan="6">
                            <div class="form-group">
                                <asp:Label ID="lblMessage" ForeColor="blue" runat="server" Text=""></asp:Label>
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

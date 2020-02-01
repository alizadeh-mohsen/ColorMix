<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="MixOnline.aspx.cs" Inherits="ColorMix.MixOnline" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel  ID="Panel1" runat="server" DefaultButton="btnSearch" >
        <table style="width: 90%; margin: 0 auto; font-size: 14px">
            <tr>
                <td><span style="width: 100px; display: block">کد رنگ:</span>
                    <asp:TextBox ID="txtCode" runat="server" Width="150px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td><span style="width: 100px; display: block">ماشین:</span>
                    <asp:DropDownList ID="ddlCar" runat="server" Width="150px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td><span style="width: 100px; display: block">شرکت:</span>
                    <asp:DropDownList ID="ddlCompany" runat="server" Width="150px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td><span style="width: 100px; display: block">نوع رنگ:</span>
                    <asp:DropDownList ID="ddlColorType" runat="server" Width="150px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td ><span style="width: 100px; display: block">شرح:</span>
                    <asp:TextBox ID="txtColorDesc1" runat="server" Width="150px"></asp:TextBox>&nbsp;و&nbsp;
                    <asp:TextBox ID="txtColorDesc2" runat="server" Width="150px"></asp:TextBox></td>
            </tr>
            <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
            <tr>
                <td>
                    <asp:Button class="btn btn-primary" ID="btnSearch" runat="server" Text="جستجو" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnClear" class="btn btn-primary" runat="server" Text="پاک کردن" OnClick="btnClear_Click" />
                    &nbsp;</td>
            </tr>
            <tr><td>&nbsp;<asp:Label ID="lblText" runat="server" Text="فرمول های یافت شده:"></asp:Label>
                &nbsp;<asp:Label ID="lblCount" runat="server"></asp:Label>
                </td><td>&nbsp;</td></tr>
            <tr>
                <td colspan="2">
                    <asp:GridView ID="SearchGrid" runat="server" CellPadding="4"
                        OnPageIndexChanging="SearchGrid_PageIndexChanging" Width="100%" AllowPaging="True"
                        GridLines="None" AutoGenerateColumns="False" ForeColor="#333333" ShowHeaderWhenEmpty="True" OnRowCommand="SearchGrid_RowCommand">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                                <asp:TemplateField HeaderText="کد رنگ">
                                    <ItemTemplate >
                                        <asp:LinkButton ID="btnSelect" runat="server" CommandArgument='<%# Bind("ColorId") %>'  Text='<%# Bind("[Color Code]") %>' CommandName="select" />
                                    </ItemTemplate>
                                </asp:TemplateField>

                            <asp:BoundField DataField="ColorId" HeaderText="Id" Visible="False"></asp:BoundField>
                            <asp:BoundField DataField="Make/Company" HeaderText="ماشین/شرکت" />
                            <asp:BoundField DataField="Color Type" HeaderText="نوع رنگ" />
                            <asp:BoundField DataField="comment" HeaderText="توضیحات" />
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
                <td colspan="2">
                    <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="red"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>

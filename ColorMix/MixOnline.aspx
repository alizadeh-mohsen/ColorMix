﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="MixOnline.aspx.cs" Inherits="ColorMix.MixOnline" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container my-2">
        <div class="form-row">
            <div class="col-md-6 form-group ">
                کد رنگ:
                    <asp:TextBox ID="txtCode" runat="server" class="form-control"></asp:TextBox>
            </div>

            <div class="col-md-6 form-group">
                ماشین:
                    <asp:DropDownList ID="ddlCar" runat="server" class="form-control">
                    </asp:DropDownList>
            </div>
        </div>

        <div class="form-row">
            <div class="col-md-6 form-group">
                شرکت:
                    <asp:DropDownList ID="ddlCompany" runat="server" class="form-control">
                    </asp:DropDownList>

            </div>

            <div class="col-md-6 form-group">
                نوع رنگ:
                    <asp:DropDownList ID="ddlColorType" runat="server" class="form-control">
                    </asp:DropDownList>
            </div>
        </div>
        <div class="form-row">
            <div class="col-md-6 form-group">
                شرح1:
                            <asp:TextBox ID="txtColorDesc1" runat="server" class="form-control"></asp:TextBox>
            </div>

            <div class="col-md-6 form-group">
                شرح2:
                        <asp:TextBox ID="txtColorDesc2" runat="server" class="form-control"></asp:TextBox>
            </div>
        </div>

    </div>
    <div class="container mb-3">
        <div class="row">
            <div class="col">
                <asp:Button class="btn btn-primary" ID="btnSearch" runat="server" Text="جستجو" OnClick="btnSearch_Click" />
                <asp:Button ID="btnClear" class="btn btn-primary " runat="server" Text="پاک کردن" OnClick="btnClear_Click" />
                <asp:Label class="mx-2" ID="lblText" runat="server" Text="فرمول های یافت شده:"></asp:Label>
                <asp:Label ID="lblCount" runat="server"></asp:Label>
            </div>
        </div>
        
    </div>

    <div class="container mb-4">
        <div class="row">
            <div class="col">


                <asp:GridView ID="SearchGrid" runat="server" CellPadding="4"
                    OnPageIndexChanging="SearchGrid_PageIndexChanging" Width="100%" AllowPaging="True"
                    GridLines="None" AutoGenerateColumns="False" ForeColor="#333333" ShowHeaderWhenEmpty="True" OnRowCommand="SearchGrid_RowCommand">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:TemplateField HeaderText="کد رنگ">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnSelect" runat="server" CommandArgument='<%# Bind("ColorId") %>' Text='<%# Bind("[Color Code]") %>' CommandName="select" />
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


                <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="red"></asp:Label>


            </div>
        </div>
    </div>





</asp:Content>

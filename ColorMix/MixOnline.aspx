<%@ Page Title="فرمول رنگ" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="MixOnline.aspx.cs" Inherits="ColorMix.MixOnline" %>

<%@ Register TagPrefix="rhp" Namespace="Heidarpour.WebControlUI" Assembly="Heidarpour.WebControlUI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="js/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script src="js/JavaScript.js"></script>
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
                موارد استفاده:
                <asp:TextBox ID="txtUsage" runat="server" class="form-control"></asp:TextBox>
            </div>

            <div class="col-md-6 form-group">
                تاریخ:<br />
                <rhp:DatePicker ID="DatePicker1" runat="server"></rhp:DatePicker>
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

               <asp:Label ID="lblCount" runat="server"></asp:Label>
                <asp:Label  ID="lblText" runat="server" Text="فرمول"></asp:Label>


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
                        <asp:TemplateField HeaderText="کد">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnSelect" runat="server" CommandArgument='<%# Bind("ColorId") %>' Text='<%# Bind("[Color Code]") %>' CommandName="select" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="ColorId" HeaderText="Id" Visible="False"></asp:BoundField>
                        <asp:BoundField DataField="Make/Company" HeaderText="برند" />
                        <asp:BoundField DataField="Color Type" HeaderText="نوع" />
                        <asp:BoundField DataField="comment" HeaderText="توضیحات" />
                        <asp:BoundField DataField="Unit" HeaderText="واحد" />
                        <asp:TemplateField HeaderText="تاریخ">
                            <ItemTemplate>
                                <asp:Label ID="lblDate" runat="server" Text='<%# ConvertToShamsi( Eval("lastUpdate").ToString()) %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

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

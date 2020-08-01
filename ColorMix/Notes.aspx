<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Notes.aspx.cs" Inherits="ColorMix.Notes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="container">
        <div class="row my-3">
            <div class="col">
                <asp:TextBox ID="txtNote" runat="server" Height="500px" ReadOnly="True" TextMode="MultiLine" Width="100%"></asp:TextBox>
            </div>
        </div>
    </div>

</asp:Content>

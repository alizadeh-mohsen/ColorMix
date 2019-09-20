using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using ColorMix.Service;

namespace ColorMix.Admin
{
    public partial class Formul : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["token"] == null || string.IsNullOrEmpty(Session["token"].ToString()))
            {
                Response.Redirect("Default.aspx");
            }
            if (!IsPostBack)
            {
                try
                {
                    ddlCar.DataSource = DbHelper.LoadDataSet("SelectCar").Tables[0];
                    ddlCar.DataTextField = "Car";
                    ddlCar.DataValueField = "ID";
                    ddlCar.DataBind();

                    ddlCompany.DataSource = DbHelper.LoadDataSet("SelectCompany").Tables[0];
                    ddlCompany.DataTextField = "Car";
                    ddlCompany.DataValueField = "ID";
                    ddlCompany.DataBind();

                    ddlColorType.DataSource = DbHelper.LoadDataSet("SelectTypes").Tables[0];
                    ddlColorType.DataTextField = "Type";
                    ddlColorType.DataValueField = "ID";
                    ddlColorType.DataBind();

                    SearchGrid.AllowPaging = true;
                    SearchGrid.PageSize = 15;
                }
                catch (Exception ex)
                {
                    lblMessage.Text = ex.Message;
                }
                txtCode.Focus();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            if ((ddlCompany.SelectedIndex != 0) && (ddlCar.SelectedIndex != 0))
            {
                lblMessage.Text = "لطفا از بین شرکت و اتومبیل یکی را انتخاب کنید";
                ddlCar.Focus();
                return;
            }
            Search();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtDesc.Text = txtCode.Text = "";
            ddlCar.SelectedIndex = ddlCompany.SelectedIndex = ddlColorType.SelectedIndex = 0;
            SearchGrid.DataSource = null;
        }

        protected void SearchGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            Search();
            SearchGrid.PageIndex = e.NewPageIndex;
            SearchGrid.DataBind();
        }

        private void Search()
        {
            using (SqlConnection connection = DbHelper.GetConnection())
            {
                SqlCommand com = new SqlCommand("Search", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                if (ddlCar.SelectedIndex != 0)
                {
                    com.Parameters.AddWithValue("@carid", ddlCar.SelectedValue);
                }
                if (ddlCompany.SelectedIndex != 0)
                {
                    com.Parameters.AddWithValue("@carid", ddlCompany.SelectedValue);
                }
                if (ddlColorType.SelectedIndex != 0)
                {
                    com.Parameters.AddWithValue("@typeid", ddlColorType.SelectedValue);
                }
                if (!string.IsNullOrEmpty(txtCode.Text.Trim()))
                {
                    com.Parameters.AddWithValue("@code", txtCode.Text);
                }
                if (!string.IsNullOrEmpty(txtDesc.Text.Trim()))
                {
                    com.Parameters.AddWithValue("@desc", txtDesc.Text);
                }
                SqlDataAdapter da = new SqlDataAdapter(com);
                DataSet ds = new DataSet();

                try
                {
                    da.Fill(ds, "search");
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        SearchGrid.DataSource = ds.Tables["search"];
                    }
                    else
                    {
                        lblMessage.Text = "رنگی با این مشخصات پیدا نشد";
                        SearchGrid.DataSource = null;
                    }
                    SearchGrid.DataBind();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "خطا" + ex.Message;
                }
            }
        }

        protected void SearchGrid_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                var id = int.Parse(SearchGrid.SelectedRow.Cells[1].Text);
                Response.Redirect("UpdateFormul.aspx?id=" + id);
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }
        }

    }
}

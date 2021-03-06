﻿using ColorMix.Service;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ColorMix
{
    public partial class MixOnline : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblText.Visible = false;
                lblCount.Text = "";
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
            txtCode.Text = txtColorDesc1.Text = txtColorDesc2.Text = "";
            ddlCar.SelectedIndex = ddlCompany.SelectedIndex = ddlColorType.SelectedIndex = 0;
            txtCode.Focus();
            lblText.Visible = false;
            lblCount.Text =
                txtUsage.Text =
            DatePicker1.Text = "";
            DatePicker1.Date = null;
        }

        protected void SearchGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            Search();
            SearchGrid.PageIndex = e.NewPageIndex;
            SearchGrid.DataBind();
        }

        private void Search()
        {
            lblText.Visible = true;
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
                    var code = DbHelper.PersianToEnglish(txtCode.Text.Trim());
                    com.Parameters.AddWithValue("@code", code);
                }
                if (!string.IsNullOrEmpty(txtColorDesc1.Text.Trim()))
                {
                    com.Parameters.AddWithValue("@desc1", txtColorDesc1.Text.Trim());
                }
                if (!string.IsNullOrEmpty(txtColorDesc2.Text.Trim()))
                {
                    com.Parameters.AddWithValue("@desc2", txtColorDesc2.Text.Trim());
                }
                if (!string.IsNullOrEmpty(txtUsage.Text.Trim()))
                {
                    com.Parameters.AddWithValue("@usage", txtUsage.Text.Trim());
                }
                if (!string.IsNullOrEmpty(DatePicker1.Text))
                {
                    com.Parameters.AddWithValue("@date", DatePicker1.Date);
                }
                SqlDataAdapter da = new SqlDataAdapter(com);
                DataTable dt = new DataTable();

                try
                {
                    da.Fill(dt);
                    SearchGrid.DataSource = dt.Rows.Count > 0 ? dt : null;
                    lblCount.Text = dt.Rows.Count.ToString();
                    SearchGrid.DataBind();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "خطا" + ex.Message;

                }
            }
        }

        protected void SearchGrid_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                var id = int.Parse(e.CommandArgument.ToString());
                Response.Redirect("Formul.aspx?id=" + id);
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }
        }

        protected string ConvertToShamsi(string lastUpdate)
        {
            if (string.IsNullOrEmpty(lastUpdate))
                return "";

            DateTime d = DateTime.Parse(lastUpdate);
            PersianCalendar pc = new PersianCalendar();
            return $"{pc.GetYear(d)}/{pc.GetMonth(d)}/{pc.GetDayOfMonth(d)}";
        }
    }
}
﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using ColorMix.Service;

namespace ColorMix.Admin
{
    public partial class Unit : Page
    {
        int ID;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["token"] == null || string.IsNullOrEmpty(Session["token"].ToString()))
            {
                Response.Redirect("Default.aspx");
            }
            if (!IsPostBack)
            {
                GridView1.AllowPaging = true;
                GridView1.PageSize = 15;
                BindGridView();
            }
        }

        private void BindGridView()
        {
            using (SqlConnection connection = DbHelper.GetConnection())
            {
                SqlCommand command = new SqlCommand("SelectUnit", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                SqlDataAdapter da = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();

                da.Fill(dataTable);
                if (dataTable.Rows.Count > 0)
                {
                    GridView1.DataSource = dataTable;
                    GridView1.DataBind();
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate)
                {
                    ((LinkButton)e.Row.Cells[1].Controls[0]).Attributes["onclick"] = "if(!confirm('Delete ?')) return false;";
                }
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            BindGridView();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindGridView();
            lbtnAdd.Visible = false;
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;

            BindGridView();

            lbtnAdd.Visible = true;
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
           
            using (SqlConnection connection = DbHelper.GetConnection())
            {
                SqlCommand command = new SqlCommand("UpdateUnit", connection)
                { 
                    CommandType = CommandType.StoredProcedure
                };

                string ID = GridView1.Rows[e.RowIndex].Cells[2].Text;
                string name = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtUnit")).Text;

                command.Parameters.AddWithValue("@id", ID);
                command.Parameters.AddWithValue("@name", name);
                command.ExecuteNonQuery();
            }
            GridView1.EditIndex = -1;
            BindGridView();
            lbtnAdd.Visible = true;
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

            using (SqlConnection connection = DbHelper.GetConnection())
            {
                SqlCommand command = new SqlCommand("DeleteUnit", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@id", GridView1.Rows[e.RowIndex].Cells[2].Text);
                command.ExecuteNonQuery();
            }
            BindGridView();
            ClearData();
        }

        protected void lbtnAdd_Click(object sender, EventArgs e)
        {
            lbtnAdd.Visible = false;
            pnlAdd.Visible = true;
        }

        protected void lbtnSubmit_Click(object sender, EventArgs e)
        {
            if (txtUnit.Text != "")
            {
                using (SqlConnection connection = DbHelper.GetConnection())
                {
                    SqlCommand command = new SqlCommand("InsertUnit", connection)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    command.Parameters.AddWithValue("@name", txtUnit.Text.Trim());
                    command.ExecuteNonQuery();
                    BindGridView();
                    ClearData();
                }
            }

            txtUnit.Text = "";
            lbtnAdd.Visible = true;
            pnlAdd.Visible = false;
        }

        protected void lbtnCancel_Click(object sender, EventArgs e)
        {
            txtUnit.Text = "";

            lbtnAdd.Visible = true;
            pnlAdd.Visible = false;
        }
        private void ClearData()
        {
            txtUnit.Text = "";
        }
    }
}

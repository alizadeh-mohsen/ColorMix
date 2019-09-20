using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using ColorMix.Service;

namespace ColorMix.Admin
{
    public partial class Make : Page
    {
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
                SqlCommand command = new SqlCommand("SelectMake", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                {
                    command.Parameters.AddWithValue("@make", txtSearch.Text.Trim());
                }
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
                SqlCommand command = new SqlCommand("UpdateMake", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                string id = GridView1.Rows[e.RowIndex].Cells[2].Text;
                string name = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtMake")).Text;
                bool isCompany = ((CheckBox)GridView1.Rows[e.RowIndex].FindControl("chkComp")).Checked;

                command.Parameters.AddWithValue("@id", id);
                command.Parameters.AddWithValue("@make", name);
                command.Parameters.AddWithValue("@company", isCompany);
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
                SqlCommand command = new SqlCommand("DeleteMake", connection)
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
            if (txtCar.Text != "")
            {
                using (SqlConnection connection = DbHelper.GetConnection())
                {
                    SqlCommand command = new SqlCommand("InsertMake", connection)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    command.Parameters.AddWithValue("@make", txtCar.Text.Trim());
                    command.Parameters.AddWithValue("@company", chkCompany.Checked);

                    command.ExecuteNonQuery();
                    BindGridView();
                    ClearData();
                }
            }

            txtCar.Text = "";
            lbtnAdd.Visible = true;
            pnlAdd.Visible = false;
        }

        protected void lbtnCancel_Click(object sender, EventArgs e)
        {
            txtCar.Text = "";

            lbtnAdd.Visible = true;
            pnlAdd.Visible = false;
        }
        private void ClearData()
        {
            txtCar.Text = "";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGridView();
        }
    }
}

using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using ColorMix.Service;

namespace ColorMix.Admin
{
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["token"] != null && !string.IsNullOrEmpty(Session["token"].ToString()))
            {
                Response.Redirect("Formuls.aspx");
            }
            if (!IsPostBack)
            {
                txtPassword.Focus();
            }
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            using (SqlConnection connection = DbHelper.GetConnection())
            {
                SqlCommand command = new SqlCommand("SelectLogin", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@user", "iri5365");
                command.Parameters.AddWithValue("@pass", txtPassword.Text.Trim());

                SqlDataAdapter da = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();

                da.Fill(dataTable);

                if (dataTable.Rows.Count > 0)
                {
                    Session["token"] = dataTable.Rows[0]["username"];
                    Response.Redirect("Formuls.aspx");
                }
                else
                {
                    lblMessage.Text = "invalid Login";
                    txtPassword.Focus();
                }
            }
        }
    }
}
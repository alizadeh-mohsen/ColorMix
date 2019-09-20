using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using ColorMix.Service;

namespace ColorMix.Admin
{
    public partial class Notes : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["token"] == null || string.IsNullOrEmpty(Session["token"].ToString()))
            {
                Response.Redirect("Default.aspx");
            }
            if (!IsPostBack)
            {
                DisplayData();
            }
        }

        private void DisplayData()
        {
            using (SqlConnection connection = DbHelper.GetConnection())
            {
                SqlCommand command = new SqlCommand("SelectNote", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                SqlDataAdapter da = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();

                da.Fill(dataTable);
                if (dataTable.Rows.Count > 0)
                {
                    txtNote.Text = dataTable.Rows[0]["Body"].ToString();
                }
            }
        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (SqlConnection connection = DbHelper.GetConnection())
            {
                SqlCommand command = new SqlCommand("UpdateNote", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@body", txtNote.Text.Trim());
                command.ExecuteNonQuery();
            }
        }

    }
}
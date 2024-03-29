﻿using System;
using System.Data;
using System.Data.SqlClient;
using ColorMix.Service;

namespace ColorMix
{
    public partial class Notes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
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
        }
    }
}
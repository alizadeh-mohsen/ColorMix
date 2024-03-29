﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;
using ColorMix.Service;

namespace ColorMix
{

    public partial class Formul : Page
    {
        static DataTable formulTable;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (string.IsNullOrEmpty(Request.QueryString["Id"]))
                    Response.Redirect("MixOnline.aspx");

                var colorId = int.Parse(Request.QueryString["id"]);
                GetFormul(colorId);
                GetUnits();
            }
        }

        private void GetUnits()
        {
            rblBase.Controls.Clear();

            using (SqlConnection dbConnection = DbHelper.GetConnection())
            {
                SqlCommand com = new SqlCommand("GetColorUnits", dbConnection) { CommandType = CommandType.StoredProcedure };
                com.Parameters.AddWithValue("@colorCode", lblColorCode.Text.Trim());


                SqlDataAdapter da = new SqlDataAdapter(com);
                DataSet ds = new DataSet();
                try
                {
                    da.Fill(ds);
                    foreach (DataRow unit in ds.Tables[0].Rows)
                    {
                        ListItem li = new ListItem
                        {
                            Value = unit.ItemArray[0].ToString(),
                            Text = unit.ItemArray[1].ToString(),
                            Selected = unit.ItemArray[1].ToString() == lblUnit.Text

                        };

                        rblBase.Items.Add(li);
                    }

                    rblBase.CssClass = "spaced";
                }
                catch (Exception ex)
                {
                    lblMessage.Text = " : خطا" + ex.Message;
                }
            }
        }



        private void GetFormul(int colorId)
        {

            using (SqlConnection dbConnection = DbHelper.GetConnection())
            {
                SqlCommand com = new SqlCommand("GetCodeInfo", dbConnection) { CommandType = CommandType.StoredProcedure };
                com.Parameters.AddWithValue("@colorId", colorId);

                SqlDataAdapter da = new SqlDataAdapter(com);
                DataSet ds = new DataSet();
                try
                {
                    da.Fill(ds);
                    DataRow colorInfo = ds.Tables[0].Rows[0];
                    formulTable = ds.Tables[1];

                    lblColorCode.Text = colorInfo["Code"].ToString();
                    lblUnit.Text = colorInfo["Name"].ToString();
                    lblBase.Text = colorInfo["BaseName"].ToString();
                    lblMake.Text = colorInfo["Car"].ToString();
                    lblColorType.Text = colorInfo["Type"].ToString();
                    lblAccuracy.Text = colorInfo["accuracy"].ToString();
                    lblUsage.Text = colorInfo["usage"].ToString();
                    lblLastUpdate.Text = colorInfo["LastUpdate"] is DBNull ? "-" : DbHelper.GregorianToShamsi(DateTime.Parse(colorInfo["LastUpdate"].ToString()));
                    var comment = colorInfo["Comment"].ToString();
                    if (!string.IsNullOrEmpty(comment))
                        lblComment.Text = Regex.Replace(comment, @"(?:\r\n *){1,2} *", "<br>");

                    if (formulTable.Rows.Count > 0)
                    {
                        FormulGrid.DataSource = formulTable;
                        FormulGrid.DataBind();
                        float total = 0;
                        foreach (DataRow drFormul in formulTable.Rows)
                        {
                            total += float.Parse(drFormul["Weight"].ToString());
                        }
                        lblTotal.Text = lblUnit.Text.Contains("gr") ? string.Format("{0:0.#}", total) : string.Format("{0:0.##}", total);
                    }
                    else
                    {
                        lblMessage.Text = "فرمولی برای این نوع رنگ وارد نشده.";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "خطا" + ex.Message;
                }
                txtBuildBase.Focus();

            }
        }
        protected void btnCalculate_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            if (string.IsNullOrEmpty(txtBuildBase.Text))
                return;
            float weight;
            if (float.TryParse(txtBuildBase.Text, out weight) == false)
            {
                lblMessage.Text = "وزن وارد شده صحیح نمی باشد";
                return;
            }
            Calculate();
        }
        protected void btnEasyMix_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            if (string.IsNullOrEmpty(hfSelectedWeight.Value) || string.IsNullOrEmpty(txtEasyMix.Text))
                return;
            float weight;
            if (float.TryParse(txtEasyMix.Text, out weight) == false)
            {
                lblMessage.Text = "وزن وارد شده صحیح نمی باشد";
                return;
            }
            Mix();
            FormulGrid.SelectedIndex = -1;
            hfSelectedWeight.Value = txtEasyMix.Text;
            pnlWeight.Visible = false;
        }
        private void Calculate()
        {
            var total = 0f;
            for (int i = 0; i < formulTable.Rows.Count; i++)
            {
                var weitgh = float.Parse(formulTable.Rows[i]["Weight"].ToString());
                var buildBase = float.Parse(lblTotal.Text);
                var newBase = float.Parse(txtBuildBase.Text.Trim());
                var newWeight = lblUnit.Text.ToLower().Contains("gr")
                    ? Math.Round(weitgh * newBase / buildBase, 1)
                    : Math.Round(weitgh * newBase / buildBase, 2);
                formulTable.Rows[i]["Weight"] = newWeight.ToString();
                total += float.Parse(formulTable.Rows[i]["Weight"].ToString());
            }
            FormulGrid.DataSource = formulTable;
            FormulGrid.DataBind();
            lblTotal.Text = lblUnit.Text.ToLower().Contains("gr") ? string.Format("{0:0.#}", total) : string.Format("{0:0.##}", total);
            txtEasyMix.Text = "";
        }
        private void Mix()
        {
            var total = 0f;
            if (string.IsNullOrEmpty(txtEasyMix.Text.Trim()))
            {
                return;
            }
            var newValue = float.Parse(txtEasyMix.Text.Trim());
            var oldValue = float.Parse(hfSelectedWeight.Value);
            var rate = newValue / oldValue;

            for (int i = 0; i < formulTable.Rows.Count; i++)
            {
                var newWeight = lblUnit.Text.ToLower().Contains("gr")
                    ? Math.Round(float.Parse(formulTable.Rows[i]["weight"].ToString()) * rate, 1)
                    : Math.Round(float.Parse(formulTable.Rows[i]["weight"].ToString()) * rate, 2);
                formulTable.Rows[i]["weight"] = newWeight.ToString();
                total += float.Parse(formulTable.Rows[i]["weight"].ToString());
            }
            FormulGrid.DataSource = formulTable;
            FormulGrid.DataBind();
            lblTotal.Text = total.ToString();
        }

        #region Print

        #endregion

        protected void FormulGrid_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName.ToLower().Equals("select"))
                {
                    txtEasyMix.Text = hfSelectedWeight.Value = e.CommandArgument.ToString();
                    ltCode.Text = ((System.Web.UI.WebControls.LinkButton)e.CommandSource).Text;
                }
                pnlWeight.Visible = true;
                txtEasyMix.Focus();
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
            }
        }

        protected void rblBase_SelectedIndexChanged(object sender, EventArgs e)
        {

            using (SqlConnection dbConnection = DbHelper.GetConnection())
            {
                SqlCommand com = new SqlCommand("GetCodeInfoByUnitId", dbConnection) { CommandType = CommandType.StoredProcedure };
                com.Parameters.AddWithValue("@code", lblColorCode.Text);
                com.Parameters.AddWithValue("@unitId", int.Parse(((ListControl)sender).SelectedValue));


                SqlDataAdapter da = new SqlDataAdapter(com);
                DataSet ds = new DataSet();
                try
                {
                    da.Fill(ds);
                    formulTable = ds.Tables[0];

                    if (formulTable.Rows.Count > 0)
                    {
                        FormulGrid.DataSource = formulTable;
                        FormulGrid.DataBind();
                        float total = 0;
                        foreach (DataRow drFormul in formulTable.Rows)
                        {
                            total += float.Parse(drFormul["Weight"].ToString());
                        }
                        lblTotal.Text = lblUnit.Text.Contains("gr") ? string.Format("{0:0.#}", total) : string.Format("{0:0.##}", total);
                    }
                    else
                    {
                        lblMessage.Text = "فرمولی برای این نوع رنگ وارد نشده.";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "خطا" + ex.Message;
                }
                txtBuildBase.Focus();

            }
        }
    }
}
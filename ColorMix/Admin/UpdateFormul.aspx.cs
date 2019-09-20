using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using ColorMix.Service;

namespace ColorMix.Admin
{
    public partial class UpdateFormul : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["token"] == null || string.IsNullOrEmpty(Session["token"].ToString()))
            {
                Response.Redirect("Default.aspx");
            }
            if (!IsPostBack)
            {
                ddlMake.DataSource = DbHelper.LoadDataSet("SelectCarAndCompany").Tables[0];
                ddlMake.DataTextField = "Car";
                ddlMake.DataValueField = "ID";
                ddlMake.DataBind();

                ddlColorType.DataSource = DbHelper.LoadDataSet("SelectTypes").Tables[0];
                ddlColorType.DataTextField = "Type";
                ddlColorType.DataValueField = "ID";
                ddlColorType.DataBind();

                ddlUnit.DataSource = DbHelper.LoadDataSet("SelectUnit").Tables[0];
                ddlUnit.DataTextField = "Name";
                ddlUnit.DataValueField = "ID";
                ddlUnit.DataBind();
                if (Request.QueryString["id"] != null)
                    if (Request.QueryString["id"] != null)
                    {
                        var colorId = int.Parse(Request.QueryString["id"]);
                        GetResult(colorId);
                    }
                    else
                    {
                        lblMessage.Text = "اطلاعات فرمول یافت نشد";
                    }
            }
        }
        private void GetResult(int colorId)
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
                    DataTable formulTable = ds.Tables[1];

                    txtColorCode.Text = colorInfo["Code"].ToString();
                    ddlUnit.SelectedValue = colorInfo["UnitId"].ToString();
                    ddlMake.SelectedValue = colorInfo["CarID"].ToString();
                    ddlColorType.SelectedValue = colorInfo["ColorTypeID"].ToString();

                    lblDate.Text = !(colorInfo["LastUpdate"] is DBNull) &&
                                  !string.IsNullOrEmpty(colorInfo["LastUpdate"].ToString())
                        ? DbHelper.GregorianToShamsi(DateTime.Parse(colorInfo["LastUpdate"].ToString()))
                        : string.Empty;
                    chkLock.Checked = !(colorInfo["Lock"] is DBNull) && colorInfo["lock"].ToString() == "1";
                    txtDesc.Text = colorInfo["Comment"].ToString();


                    if (formulTable.Rows.Count > 0)
                    {
                        float total = 0;
                        foreach (DataRow drFormul in formulTable.Rows)
                        {
                            lstBaseColor.Items.Add(drFormul["Code"].ToString());
                            lstWeight.Items.Add(string.Format("{0:0.##}", drFormul["Weight"]));
                            total += float.Parse(drFormul["Weight"].ToString());
                        }

                        lblTotal.Text = ddlUnit.SelectedItem.Text.ToLower().Contains("gr") ? string.Format("{0:0.#}", total) : string.Format("{0:0.##}", total);
                    }
                    else
                    {
                        lblMessage.Text = "فرمولی برای این نوع رنگ وارد نشده.";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = " : خطا" + ex.Message;
                }
            }
        }

        private string UpdateBaseWeight()
        {
            float sum = lstWeight.Items.Cast<object>().Sum(t => float.Parse(t.ToString()));
            return sum.ToString();
        }

        protected void lstColor_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (lstBaseColor.SelectedIndex != -1)
            {
                lstWeight.SelectedIndex = lstBaseColor.SelectedIndex;
                if (txtBaseColor.Text == string.Empty && txtWeight.Text == string.Empty)
                {
                    int index = lstBaseColor.SelectedIndex;
                    txtBaseColor.Text = lstBaseColor.SelectedItem.ToString();
                    txtWeight.Text = lstWeight.Items[index].ToString();
                    lstBaseColor.Items.RemoveAt(index);
                    lstWeight.Items.RemoveAt(index);
                    lblTotal.Text = UpdateBaseWeight();
                    txtBaseColor.Focus();
                }
            }
        }

        protected void lstWeight_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (lstWeight.SelectedIndex != -1)
            {
                lstBaseColor.SelectedIndex = lstWeight.SelectedIndex;
                if (txtBaseColor.Text == string.Empty && txtWeight.Text == string.Empty)
                {
                    int index = lstWeight.SelectedIndex;
                    txtWeight.Text = lstWeight.SelectedItem.ToString();
                    txtBaseColor.Text = lstBaseColor.Items[index].ToString();
                    lstWeight.Items.RemoveAt(index);
                    lstBaseColor.Items.RemoveAt(index);
                    lblTotal.Text = UpdateBaseWeight();
                    txtBaseColor.Focus();
                }
            }
        }

        protected void btnBaseColor_Click(object sender, EventArgs e)
        {
            txtWeight.Focus();
        }

        protected void btnWeight_Click(object sender, EventArgs e)
        {
            if (txtBaseColor.Text != string.Empty)
            {
                try
                {
                    float.Parse(txtWeight.Text);
                }
                catch (Exception)
                {
                    lblMessage.Text = "وزن وارد شده صحیح نیست";
                    txtWeight.Focus();
                    return;
                }

                lstBaseColor.Items.Add(txtBaseColor.Text);
                lstWeight.Items.Add(txtWeight.Text);
                txtBaseColor.Text = txtWeight.Text = string.Empty;

                lblTotal.Text = UpdateBaseWeight();
                txtBaseColor.Focus();
            }
            else
            {
                lblMessage.Text = "ابتدا مادر رنگ را وارد کنید";
                txtBaseColor.Focus();
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int colorId;
            if (Request.QueryString["id"] != null)
            {
                colorId = int.Parse(Request.QueryString["id"]);
            }
            else
            {
                lblMessage.Text = "اطلاعات فرمول صحیح نمیباشد";
                return;
            }
            using (SqlConnection dbConnection = DbHelper.GetConnection())
            {

                SqlCommand com = new SqlCommand("DeleteFormul", dbConnection) { CommandType = CommandType.StoredProcedure };
                com.Parameters.AddWithValue("@colorId", colorId);
                try
                {
                    com.ExecuteNonQuery();
                    lblMessage.Text = "فرمول با موفقیت حذف شد";
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "خطا" + ex.Message;
                }
            }
        }

        protected void btnSaveColor_Click(object sender, EventArgs e)
        {
            int colorId;
            if (Request.QueryString["id"] != null)
            {
                colorId = int.Parse(Request.QueryString["id"]);
            }
            else
            {
                lblMessage.Text = "اطلاعات فرمول صحیح نمیباشد";
                return;
            }

            using (SqlConnection dbConnection = DbHelper.GetConnection())
            {
                SqlCommand com = dbConnection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                try
                {
                    com.CommandText = "UpdateColor";

                    com.Parameters.Clear();
                    com.Parameters.AddWithValue("@ColorID", colorId);
                    com.Parameters.AddWithValue("@CarID", ddlMake.SelectedValue);
                    com.Parameters.AddWithValue("@ColorTypeID", ddlColorType.SelectedValue);
                    com.Parameters.AddWithValue("@code", txtColorCode.Text.Trim());
                    com.Parameters.AddWithValue("@comment", txtDesc.Text.Trim());
                    com.Parameters.AddWithValue("@Lock", chkLock.Checked);
                    com.Parameters.AddWithValue("@LastUpdate", txtDate.Text);
                    com.Parameters.AddWithValue("@unitId", ddlUnit.SelectedValue);

                    com.ExecuteNonQuery();
                    lblMessage.Text = "اطلاعات رنگ با موفقیت آپدیت شد";
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "خطا" + ex.Message;
                }

            }
        }

        protected void btnSaveFomrul_Click(object sender, EventArgs e)
        {
            int colorId;
            if (Request.QueryString["id"] != null)
            {
                colorId = int.Parse(Request.QueryString["id"]);
            }
            else
            {
                lblMessage.Text = "اطلاعات فرمول صحیح نمیباشد";
                return;
            }
            if (lstWeight.Items.Count == 0 || lstBaseColor.Items.Count == 0)
            {
                lblMessage.Text = "فرمول را وارد کنید";
                txtBaseColor.Focus();
                return;
            }

            if (txtBaseColor.Text != string.Empty || txtWeight.Text != string.Empty)
            {
                lblMessage.Text = "فرمولی وجود دارد که وارد نشده است";
                txtBaseColor.Focus();
                return;
            }
            using (SqlConnection dbConnection = DbHelper.GetConnection())
            {
                SqlCommand com = dbConnection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                try
                {
                    com.CommandText = "DeleteFormulForEdit";
                    com.Parameters.AddWithValue("@ColorID", colorId);
                    com.ExecuteNonQuery();

                    com.CommandText = "UpdateFormul";

                    for (int i = 0; i < lstBaseColor.Items.Count; i++)
                    {
                        com.Parameters.Clear();
                        com.Parameters.AddWithValue("@ColorID", colorId);
                        com.Parameters.AddWithValue("@Code", lstBaseColor.Items[i].Text);
                        com.Parameters.AddWithValue("@weight", lstWeight.Items[i].Text);

                        com.ExecuteNonQuery();
                    }

                    lblMessage.Text = "فرمول با موفقیت آپدیت شد";
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "خطا" + ex.Message;
                }

            }
        }

    }
}
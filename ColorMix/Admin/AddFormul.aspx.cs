using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using ColorMix.Service;

namespace ColorMix.Admin
{
    public partial class AddFormul : Page
    {
        private readonly SqlConnection con = new SqlConnection("Data Source=(local);Initial Catalog=ColorDb;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["token"] == null || string.IsNullOrEmpty(Session["token"].ToString()))
            {
                Response.Redirect("Default.aspx");
            }
            if (!IsPostBack)
                {
                    ddlMake.DataSource = DbHelper.LoadDataSet("SelectCar").Tables[0];
                    ddlMake.DataTextField = "Car";
                    ddlMake.DataValueField = "ID";
                    ddlMake.DataBind();

                    ddlCompany.DataSource = DbHelper.LoadDataSet("SelectCompany").Tables[0];
                    ddlCompany.DataTextField = "Car";
                    ddlCompany.DataValueField = "ID";
                    ddlCompany.DataBind();

                    ddlColorGroup.DataSource = DbHelper.LoadDataSet("SelectTypes").Tables[0];
                    ddlColorGroup.DataTextField = "Type";
                    ddlColorGroup.DataValueField = "ID";
                    ddlColorGroup.DataBind();

                    ddlUnit.DataSource = DbHelper.LoadDataSet("SelectUnit").Tables[0];
                    ddlUnit.DataTextField = "Name";
                    ddlUnit.DataValueField = "ID";
                    ddlUnit.DataBind();
                }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Save();
        }

        private void Save()
        {
            lblMessage.Text = "";
            if ((ddlMake.SelectedIndex == 0) && (ddlCompany.SelectedIndex == 0) ||
                (ddlMake.SelectedIndex != 0) && (ddlCompany.SelectedIndex != 0))
            {
                lblMessage.Text = "لطفا از بین شرکت و اتومبیل یکی را انتخاب کنید";
                ddlCompany.SelectedIndex = 0;
                ddlMake.Focus();
                return;
            }

            if (ddlColorGroup.SelectedIndex == 0)
            {
                lblMessage.Text = "نوع رنگ را از لیست انتخاب کنید";

                ddlColorGroup.Focus();
                return;
            }
            if (txtColorCode.Text == string.Empty)
            {
                lblMessage.Text = "کد رنگ را وارد کنید";
                txtColorCode.Focus();
                return;
            }
            if (txtBaseColor.Text != string.Empty || txtWeight.Text != string.Empty)
            {
                lblMessage.Text = "فرمولی وجود دارد که وارد نشده است";
                txtBaseColor.Focus();
                return;
            }

            if (lstWeight.Items.Count == 0 || lstBaseColor.Items.Count == 0)
            {
                lblMessage.Text = "فرمول را وارد کنید";
                txtBaseColor.Focus();
                return;
            }
            if (lstBaseColor.Items.Count != lstWeight.Items.Count)
            {
                lblMessage.Text = "تعداد مادر رنگها و وزن های وارد شده برابر نیست";
                return;
            }

            using (SqlConnection dbConnection = DbHelper.GetConnection())
            {

                SqlCommand com = dbConnection.CreateCommand();

                com.CommandText = "InsertColor";
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@carid",
                    ddlMake.SelectedValue == "1" ? ddlCompany.SelectedValue : ddlMake.SelectedValue);

                com.Parameters.AddWithValue("@typeid", ddlColorGroup.SelectedValue);
                com.Parameters.AddWithValue("@code", txtColorCode.Text.Trim());
                com.Parameters.AddWithValue("@comment", txtColorDesc.Text.Trim());
                com.Parameters.AddWithValue("@UnitId", ddlUnit.SelectedValue);
                com.Parameters.Add("@newid", SqlDbType.Int);
                com.Parameters["@newid"].Direction = ParameterDirection.Output;

                try
                {
                    com.ExecuteNonQuery();
                    string colorId = com.Parameters["@newid"].Value.ToString();
                    com.CommandText = "InsertFormul";
                    for (int i = 0; i < lstBaseColor.Items.Count; i++)
                    {
                        com.Parameters.Clear();
                        com.Parameters.AddWithValue("@ColorID", colorId);
                        com.Parameters.AddWithValue("@code", lstBaseColor.Items[i].Text);
                        com.Parameters.AddWithValue("@weight", lstWeight.Items[i].Text);

                        com.ExecuteNonQuery();
                    }

                    lblMessage.Text = "فرمول جدید با موفقیت ذخیره شد";
                }
                catch (Exception ex)
                {
                    lblMessage.Text = ex.Message;
                }
                finally
                {
                    con.Close();
                }
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
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
                var total = string.IsNullOrEmpty(lblTotal.Text) ? "0" : lblTotal.Text;
                lblTotal.Text = (float.Parse(txtWeight.Text) + float.Parse(total)).ToString();
                txtBaseColor.Text = txtWeight.Text = string.Empty;

                txtBaseColor.Focus();
            }
            else
            {
                lblMessage.Text = "ابتدا مادر رنگ را وارد کنید";
                txtBaseColor.Focus();

            }
        }

        protected void lstBaseColor_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (lstBaseColor.SelectedIndex != -1)
            {
                if (txtBaseColor.Text == string.Empty && txtWeight.Text == string.Empty)
                {
                    int index = lstBaseColor.SelectedIndex;
                    txtBaseColor.Text = lstBaseColor.SelectedItem.ToString();
                    txtWeight.Text = lstWeight.Items[index].ToString();
                    lstBaseColor.Items.RemoveAt(index);
                    lstWeight.Items.RemoveAt(index);
                    lblTotal.Text = (float.Parse(lblTotal.Text) - (float.Parse(txtWeight.Text))).ToString();
                    txtBaseColor.Focus();
                }
            }
        }

        protected void lstWeight_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (lstWeight.SelectedIndex != -1)
            {
                if (txtBaseColor.Text == string.Empty && txtWeight.Text == string.Empty)
                {
                    int index = lstWeight.SelectedIndex;
                    txtWeight.Text = lstWeight.SelectedItem.ToString();
                    txtBaseColor.Text = lstBaseColor.Items[index].ToString();
                    lstWeight.Items.RemoveAt(index);
                    lstBaseColor.Items.RemoveAt(index);

                    lblTotal.Text = (float.Parse(lblTotal.Text) - (float.Parse(txtWeight.Text))).ToString();
                    txtBaseColor.Focus();
                }
            }
        }

    }
}
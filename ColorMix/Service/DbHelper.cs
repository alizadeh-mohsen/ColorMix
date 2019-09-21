using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;

namespace ColorMix.Service
{
    public class DbHelper
    {
        public static SqlConnection GetConnection()
        {
            var sqlConnection =
                new SqlConnection(ConfigurationManager.ConnectionStrings["RohamDbConnection"].ConnectionString);
            sqlConnection.Open();
            return sqlConnection;
        }

        public static DataSet LoadDataSet(string commandName)
        {
            using (SqlConnection connection = GetConnection())
            {
                SqlCommand command = connection.CreateCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = commandName;
                SqlDataAdapter da = new SqlDataAdapter(command);
                DataSet ds = new DataSet();
                da.Fill(ds);
                return ds;

            }
        }

        public static string GregorianToShamsi(DateTime gregorian)
        {
            try
            {
                PersianCalendar pc = new PersianCalendar();
                int pcYear = pc.GetYear(gregorian);
                int pcMonth = pc.GetMonth(gregorian);
                int pcDay = pc.GetDayOfMonth(gregorian);
                string convertedDate = string.Format("{0}/{1}/{2}", pcYear, pcMonth, pcDay);
                return convertedDate;
            }
            catch (Exception ex)
            {
                //MessageBox.Show(ex.Message);
                return "operation caused error";
            }
        }

        private static string GetPersianDate()
        {
            PersianCalendar pc = new PersianCalendar();
            string Date = pc.GetYear(DateTime.Now) + "/" + pc.GetMonth(DateTime.Now) + "/" + pc.GetDayOfMonth(DateTime.Now);
            return Date;
        }

        private static string GetMiladiDate()
        {
            GregorianCalendar pc = new GregorianCalendar();
            string Date = pc.GetYear(DateTime.Now) + "/" + pc.GetMonth(DateTime.Now) + "/" + pc.GetDayOfMonth(DateTime.Now);
            return Date;

        }

        public static string PersianToEnglish(string persianStr)
        {
                Dictionary<string, string> lettersDictionary = new Dictionary<string, string>
                {
                    ["۰"] = "0",
                    ["۱"] = "1",
                    ["۲"] = "2",
                    ["۳"] = "3",
                    ["۴"] = "4",
                    ["۵"] = "5",
                    ["۶"] = "6",
                    ["۷"] = "7",
                    ["۸"] = "8",
                    ["۹"] = "9"
                };
                return lettersDictionary.Aggregate(persianStr, (current, item) =>
                    current.Replace(item.Key, item.Value));
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

//Data String:
//Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Database.mdf;Integrated Security=True;Connect Timeout=30

namespace AWP_TCG
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private static readonly string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["id"] != null)
                Response.Redirect("frontPage.aspx");
        }

        protected void existingSubmit_Click(object sender, EventArgs e)
        {
            int validation = 0;
            using (var conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("login"))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@username", username.Text);
                    cmd.Parameters.AddWithValue("@password", password.Text);
                    cmd.Connection = conn;
                    conn.Open();
                    validation = Convert.ToInt32(cmd.ExecuteScalar());
                    conn.Close();

                }
                switch (validation)
                {
                    case 0:
                        //Login failed, Username and Password incorrect
                        break;
                    default:
                        //Login succeeded, add the parameters to session
                        Session["username"] = username.Text;
                        //Session["password"] = password.Text;
                        Session["id"] = validation;
                        Response.Redirect("frontPage.aspx");
                        break;
                }
            }

        }

        //prevent duplicate usernames
        protected void newSubmit_Click(object sender, EventArgs e)
        {
            Session["username"] = newUsername.Text;
            //Session["password"] = newPassword.Text;

            SqlParameter[] parameters = new SqlParameter[3];

            parameters[0] = new SqlParameter("username", newUsername.Text);
            parameters[1] = new SqlParameter("password", newPassword.Text);
            parameters[2] = new SqlParameter("email", email.Text);


            using (var conn = new SqlConnection(connectionString))
            {
                using (var command = new SqlCommand("newUser", conn)
                {
                    CommandType = System.Data.CommandType.StoredProcedure

                })
                {
                    command.Parameters.Add(parameters[0]);
                    command.Parameters.Add(parameters[1]);
                    command.Parameters.Add(parameters[2]);
                    conn.Open();
                    Session["id"] = Convert.ToInt32(command.ExecuteScalar());
                    conn.Close();
                }
            }//add to db

        }//button click

    }
}
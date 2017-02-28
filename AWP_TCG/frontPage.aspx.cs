using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AWP_TCG
{
    public partial class frontPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Write("Welcome to the front page. ");
            if (Session["username"] != null)
            {
                Response.Write("You're logged in, " + Session["username"] + ". Thanks. Really.");
                loginButton.Visible = false;
            }

        }

        protected void loginButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("login.aspx");
        }
    }
}
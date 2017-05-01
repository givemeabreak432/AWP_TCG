using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AWP_TCG
{
    public partial class lobby : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                username.Value = Session["username"].ToString();
                loginDiv.Visible = false;
                lobbyDiv.Visible = true;
            }
            else
            {
                loginDiv.Visible = true;
                lobbyDiv.Visible = false;
            }
        }
    }
}
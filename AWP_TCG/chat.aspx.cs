using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AWP_TCG
{
    public partial class chat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["username"] != null)
                username.Value = Session["username"].ToString();
            else
            {
                sendMessage.Visible = false;
                Response.Write("If you wanna chat, login!");
            }
        }
    }
}
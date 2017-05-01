using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AWP_TCG
{
    public partial class GameRoom : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            username.Value = Session["username"].ToString();
            roomID.Value = Request.Form["roomID"];
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AWP_TCG
{
    public partial class DeckBuilder : System.Web.UI.Page
    {
        private static readonly string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AllCards_RowCommand(object sender, GridViewCommandEventArgs e)
        {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = AllCards.Rows[index];
                Response.Write("Added " + row.Cells[0].Text);
        }
    }
}
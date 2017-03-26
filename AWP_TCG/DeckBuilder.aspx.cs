using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;


namespace AWP_TCG
{
    public partial class DeckBuilder : System.Web.UI.Page
    {
        private static readonly string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["currentDeckID"] != null)
            {
                newDeckDiv.Visible = true;
                cardSelectionDiv.Visible = true;
                currentDeckDiv.Visible = true;

            }
        }

        protected void AllCards_RowCommand(object sender, GridViewCommandEventArgs e)
        {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = AllCards.Rows[index];
                Response.Write("Added " + row.Cells[0].Text);

                using (var conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("addCardToDeck"))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@deckID", (int)Session["currentDeckID"]);
                        cmd.Parameters.AddWithValue("@cardID", row.Cells[0].Text);
                        cmd.Connection = conn;
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();

                    }
                }
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            using (var conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("newDeck"))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@deckName", DeckName.Text);
                    cmd.Parameters.AddWithValue("@ownerID", 3); //temporary until we get user IDS/user systems set up
                    cmd.Connection = conn;
                    conn.Open();
                    Session["currentDeckID"] = cmd.ExecuteScalar();
                    Session["currentDeckName"] = DeckName.Text;
                    conn.Close();


                }
            }
            newDeckDiv.Visible = true;
            cardSelectionDiv.Visible = true;
            currentDeckDiv.Visible = true;
            currentDeckNameLabel.Text = (string)Session["currentDeckName"];
        }

        protected void SelectButton_Click(object sender, EventArgs e)
        {
            using (var conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SelectDeckByName"))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@deckName", DropdownOfDecks.Text);
                    cmd.Parameters.AddWithValue("@ownerID", 3); //temporary until we get user IDS/user systems set up
                    cmd.Connection = conn;
                    conn.Open();
                    Session["currentDeckID"] = cmd.ExecuteScalar();
                    Session["currentDeckName"] = DropdownOfDecks.Text;
                    conn.Close();


                }
            }
            newDeckDiv.Visible = true;
            cardSelectionDiv.Visible = true;
            currentDeckDiv.Visible = true;
            currentDeckNameLabel.Text = (string)Session["currentDeckName"];
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
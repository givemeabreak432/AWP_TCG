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
            if (Session["id"] == null)
            {
                newDeckDiv.Visible = false;
                cardSelectionDiv.Visible = false;
                currentDeckDiv.Visible = false;
                loginDiv.Visible = true;
                return;
            }
            if (!IsPostBack)
            {
                SqlDataSource2.SelectParameters["ownerID"].DefaultValue = Session["id"].ToString();
                DropdownOfDecks.DataBind();
            }

            //setting visibilities
            if (Session["currentDeckID"] != null)
            {
                newDeckDiv.Visible = true;
                cardSelectionDiv.Visible = true;
                currentDeckDiv.Visible = true;
                loginDiv.Visible = false;
            }
            if (DropdownOfDecks.Items.Count == 0)
            {
                DropdownOfDecks.Visible = false;
                SelectButton.Visible = false;
                noDecksLabel.Visible = true;
            }
            else
            {
                DropdownOfDecks.Visible = true;
                SelectButton.Visible = true;
                noDecksLabel.Visible = false;
            }
        }

        //adds card to deck
        protected void AllCards_RowCommand(object sender, GridViewCommandEventArgs e)
        {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = AllCards.Rows[index];
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
            currentDeck.DataBind();

        }
        
        //remove card from deck
        protected void RemoveCard_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = currentDeck.Rows[index];

            using (var conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("RemoveCardFromDeck"))
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
            currentDeck.DataBind();

        }

        //creates a new deck
        protected void SaveButton_Click(object sender, EventArgs e)
        {
            //check if deck with name exists
            using (var conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SelectDeckByName"))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@deckName", DeckName.Text);
                    cmd.Parameters.AddWithValue("@ownerID", (int)Session["id"]); 
                    cmd.Connection = conn;
                    conn.Open();
                    if(cmd.ExecuteScalar() != null)
                    {
                        Response.Write("Deck with given name already exists");
                        return;
                    }
                    conn.Close();

                
                }
            }

            using (var conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("newDeck"))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@deckName", DeckName.Text);
                    cmd.Parameters.AddWithValue("@ownerID", (int)Session["id"]); 
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
            SqlDataSource3.SelectParameters["deckID"].DefaultValue = Session["currentDeckID"].ToString();
            SqlDataSource2.SelectParameters["ownerID"].DefaultValue = Session["id"].ToString();
            DropdownOfDecks.DataBind();
        }

        //selects an active deck
        protected void SelectButton_Click(object sender, EventArgs e)
        {
            using (var conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SelectDeckByName"))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@deckName", DropdownOfDecks.Text);
                    cmd.Parameters.AddWithValue("@ownerID", Session["id"]); 
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
            SqlDataSource3.SelectParameters["deckID"].DefaultValue = Session["currentDeckID"].ToString();



        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void loginButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("login.aspx");
        }

        protected void homeButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("frontPage.aspx");
        }

        protected void FilterButton_Click(object sender, EventArgs e)
        {
            using (var conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SelectTypeByName"))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@typeName", DropDownOfTypes.Text);
                    cmd.Connection = conn;
                    conn.Open();
                    SqlDataSource1.SelectParameters["cardType"].DefaultValue = cmd.ExecuteScalar().ToString();
                    conn.Close();
                    AllCards.DataBind();


                }
            }
        }
    }
}
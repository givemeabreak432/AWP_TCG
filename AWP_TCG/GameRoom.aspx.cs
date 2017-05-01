using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AWP_TCG
{
    public partial class GameRoom : System.Web.UI.Page
    {
        int HAND_SIZE = 5;

        private static readonly string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        List<string> decklist = new List<string>();

        protected void Page_Load(object sender, EventArgs e)
        {
            username.Value = Session["username"].ToString();
            roomID.Value = Request.Form["roomID"];
            if (!IsPostBack)
            {
                SqlDataSource.SelectParameters["ownerID"].DefaultValue = Session["id"].ToString();
                DropdownOfDecks.DataBind();
            }
        }

        protected void SelectButton_Click(object sender, EventArgs e)
        {
            using (var conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetCardsInDeck"))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@deckName", DropdownOfDecks.Text);
                    cmd.Parameters.AddWithValue("@ownerID", Session["id"]);
                    cmd.Connection = conn;
                    conn.Open();
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            //add card to deck for each appearence
                            for(int i = 0; i < reader.GetInt32(1); i++)
                            {
                                decklist.Add(reader.GetString(0));
                            }

                        }
                    }

                   conn.Close();
                }
            }

            //make sure deck is at least big enough to fill a hand
            if (decklist.Count() >= HAND_SIZE)
            {
                deckSelectionDiv.Visible = false;

                int numCardsSel = 0;
                int selCardRange = decklist.Count;
                Random rnd = new Random();

                handContainer.InnerHtml = "Sample Hand: <br/>";
                while (numCardsSel < HAND_SIZE)
                {
                    //select card
                    int selCard = rnd.Next(0, selCardRange - 1);
                    string cardName = decklist[selCard];
                    handContainer.InnerHtml = handContainer.InnerHtml + "<br/>" + cardName;

                    //decrease range
                    numCardsSel++;
                    selCardRange--;

                }
            }
            else Response.Write("This deck is too small! Please add more cards to this deck, or select a new deck");
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
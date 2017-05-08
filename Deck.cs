using System;

public class Deck
{
    private List<Card> cards;
	public Deck()
	{
	}

    public Card DrawCard()
    {
        Card drawn = cards[0];
        cards.RemoveAt(0);
        return drawn;
    }

    public void Shuffle()
    {
        Random shuffler = new Random();
        cards = cards.OrderBy(a => shuffler.Next()).ToList();
    }

    public void AddCard(Card newCard)
    {
        cards.Add(newCard);
    }
}

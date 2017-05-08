using System;

public class Hand
{
    private static int maxSize = 7; 
    List<Card> cardsInHand;

	public Hand()
	{
	}

    public void AddCard(Card newCard)
    {
        cardsInHand.Add(newCard);
    }
}

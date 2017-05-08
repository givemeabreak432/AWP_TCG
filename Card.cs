using System;

public class Card
{
    private int genericCost;
    private int blueCost;
    private int greenCost;
    private int blackCost;
    private int redCost;
    private int whiteCost;
    private string cardDesc;
    private string cardName;
    private string cardType;

	public Card(string description, string name, string inType)
	{
        cardDesc = description;
        cardName = name;
        cardType = inType;
	}
}

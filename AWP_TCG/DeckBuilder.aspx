<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeckBuilder.aspx.cs" Inherits="AWP_TCG.DeckBuilder" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        Deck Builder Prototype:    </div>

        <br />
        CARDS AVAILABLE:
        <asp:GridView ID="AllCards" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" OnRowCommand="AllCards_RowCommand" >
            <Columns>
                <asp:BoundField DataField="cardName" HeaderText="cardName" SortExpression="cardName" />
                <asp:BoundField DataField="cardCost" HeaderText="cardCost" SortExpression="cardCost" />
                <asp:BoundField DataField="blueCost" HeaderText="blueCost" SortExpression="blueCost" />
                <asp:BoundField DataField="greenCost" HeaderText="greenCost" SortExpression="greenCost" />
                <asp:BoundField DataField="redCost" HeaderText="redCost" SortExpression="redCost" />
                <asp:BoundField DataField="whiteCost" HeaderText="whiteCost" SortExpression="whiteCost" />
                <asp:BoundField DataField="blackCost" HeaderText="blackCost" SortExpression="blackCost" />
                <asp:BoundField DataField="cardDescription" HeaderText="cardDescription" SortExpression="cardDescription" />
                <asp:ButtonField runat="server" Text="Add"  />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [cardName], [cardCost], [blueCost], [greenCost], [redCost], [whiteCost], [blackCost], [cardDescription] FROM [Card]"></asp:SqlDataSource>

        <hr />
        CURRENT DECK:
        <asp:TextBox ID="DeckName" runat="server" Text="ENTER DECK NAME"></asp:TextBox>
        <asp:Button ID="SaveButton" runat="server" Text="Save" />
    </form>
</body>
</html>

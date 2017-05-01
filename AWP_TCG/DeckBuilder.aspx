<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeckBuilder.aspx.cs" Inherits="AWP_TCG.DeckBuilder" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
     <!--data source-->
    <form id="form1" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="GetAllCards" SelectCommandType ="StoredProcedure">
       <SelectParameters>
            <asp:Parameter Name="cardType" DefaultValue ="-1" Type ="Int32" />
       </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SelectDecKByOwner" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="ownerID" Type ="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="GetDeckList" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="deckID" Type="Int32"/>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT typeName FROM cardType">
    </asp:SqlDataSource>


    <div>
    
        Deck Builder Prototype:   

    </div>

        <div id="loginDiv" runat="server" Visible="false">
            You must be logged in to use this feature. <br />
            <asp:Button runat="server" ID="loginButton" Text="Login" OnClick="loginButton_Click" />
        </div>

        <br />
        <div id="cardSelectionDiv" runat="server" Visible="false">
        CARDS AVAILABLE: <br />
        FILTER BY TYPE: <asp:DropDownList ID="DropDownOfTypes" runat="server" DataSourceID="SqlDataSource4" DataTextField="typeName" DataValueField="typeName" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"></asp:DropDownList>
        <asp:Button ID="FilterButton" runat="server" Text="Filter Selection" OnClick="FilterButton_Click" /> <br />
        <asp:GridView ID="AllCards" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" OnRowCommand="AllCards_RowCommand" DataKeyNames="cardID">
            <Columns>
                <asp:BoundField DataField="cardID" HeaderText="cardID" SortExpression="cardID" InsertVisible="False" ReadOnly="True" />
                <asp:BoundField DataField="cardName" HeaderText="cardName" SortExpression="cardName" />
                <asp:BoundField DataField="typeName" HeaderText="Type" SortExpression="typeName" />
                <asp:BoundField DataField="cardCost" HeaderText="cardCost" SortExpression="cardCost" />
                <asp:BoundField DataField="blueCost" HeaderText="blueCost" SortExpression="blueCost" />
                <asp:BoundField DataField="greenCost" HeaderText="greenCost" SortExpression="greenCost" />
                <asp:BoundField DataField="redCost" HeaderText="redCost" SortExpression="redCost" />
                <asp:BoundField DataField="whiteCost" HeaderText="whiteCost" SortExpression="whiteCost" />
                <asp:BoundField DataField="blackCost" HeaderText="blackCost" SortExpression="blackCost" />
                <asp:BoundField DataField="cardDescription" HeaderText="cardDescription" SortExpression="cardDescription" />
                <asp:ButtonField runat="server" Text="Add To Deck"  />
            </Columns>
        </asp:GridView>
        </div>
        <hr />


      <div id="currentDeckDiv" runat="server" Visible="false">
        CURRENT DECK:
        <asp:Label id="currentDeckNameLabel" runat="server"></asp:Label>
      <asp:GridView ID="currentDeck" runat="server" AutoGenerateColumns="False" DataKeyNames="cardID" DataSourceID="SqlDataSource3" OnRowCommand="RemoveCard_RowCommand" >
          <Columns>
              <asp:BoundField DataField="cardID" HeaderText="cardID" SortExpression="cardID" />
              <asp:BoundField DataField="cardName" HeaderText="cardName" SortExpression="cardName" />
              <asp:BoundField DataField="NumberOfAppearences" HeaderText="NumberOfAppearences" SortExpression="NumberOfAppearences"/>
              <asp:ButtonField runat="server" Text="Remove"/>
          </Columns>
        </asp:GridView>
       </div>


      <div id="newDeckDiv" runat="server">
        CREATE NEW DECK:
          <asp:TextBox ID="DeckName" runat="server" Text="Enter Name"></asp:TextBox>
          <asp:Button ID="SaveButton" runat="server" Text="Create Deck!" OnClick="SaveButton_Click" /><br />
        SELECT DECK:
          <asp:DropDownList ID="DropdownOfDecks" runat="server" DataSourceID="SqlDataSource2" DataTextField="deckName" DataValueField="deckName" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"></asp:DropDownList>
          <asp:Button ID="SelectButton" runat="server" Text="Select Deck!" OnClick="SelectButton_Click" />
          <asp:Label ID="noDecksLabel" runat="server" Text="You have no decks. Try creating one!"></asp:Label><br /> 
      </div>
    </form>
</body>
</html>

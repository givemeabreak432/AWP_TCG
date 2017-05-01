<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frontPage.aspx.cs" Inherits="AWP_TCG.frontPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>AWP TCG</title>
    <style>
        * {
            margin: 0;
        }
        #chatFrame{
            width: 100%;
            bottom: 20%;
            position: fixed;
        }

        #lobbyFrame{
            width:25%;
            height:40%;
            right:10%;
            position: fixed;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    </div>
        <asp:Button ID="loginButton" runat="server" OnClick="loginButton_Click" Text="Login/Create Acct" Width="174px" /><br />
        <asp:Button ID="deckBuilderButton" runat="server" Text="Go To Deck Builder" Width="174px" OnClick="deckBuilderButton_Click" />
         <br />        
        <iframe src="lobby.aspx" id="lobbyFrame"></iframe><br />
        <iframe src="chat.aspx" id="chatFrame" style="width:100%; height:30%;"></iframe>
    </form>

</body>
</html>

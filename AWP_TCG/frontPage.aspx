<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frontPage.aspx.cs" Inherits="AWP_TCG.frontPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    </div>
        <asp:Button ID="loginButton" runat="server" OnClick="loginButton_Click" Text="Login/Create Acct" Width="174px" /><br />
        <asp:Button ID="deckBuilderButton" runat="server" Text="Go To Deck Builder" Width="174px" OnClick="deckBuilderButton_Click" />
    </form>
</body>
</html>

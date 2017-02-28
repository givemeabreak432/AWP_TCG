<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="AWP_TCG.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="login" runat="server">
    <div id="existingUser">
        Log In: <br />
        Username: <asp:TextBox ID="username" runat="server"></asp:TextBox> <br />
        Password: <asp:TextBox ID="password" runat="server" TextMode="Password"></asp:TextBox> <br />
        <asp:Button ID="existingSubmit" runat="server" Text="Log In" OnClick="existingSubmit_Click" /> <br />
    </div>
    <hr />
    <div id="newUser">
        Create Account <br />
        Username: <asp:TextBox ID="newUsername" runat="server"></asp:TextBox><br />
        Password: <asp:TextBox ID="newPassword" runat="server" TextMode="Password"></asp:TextBox><br />
        Email: <asp:TextBox ID="email" runat="server"></asp:TextBox><br />
        <asp:Button ID="newSubmit" runat="server" Text="Create Account" OnClick="newSubmit_Click"/><br />
    </div>
    <div id="error" style="display:none">
        <asp:Label ID="errMsg" runat="server"></asp:Label>
    </div>
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="lobby.aspx.cs" Inherits="AWP_TCG.lobby" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>

    <form id="form1" runat="server">
        <input type="hidden" id="username" runat="server" />
    </form>

    <input type="text" id="text" />
    <input type="button" id="sendLobby" value="Send"/>

    <div id="lobbyContainer" style="overflow: scroll; width: 500px; height: 500px;">
    </div>

    <script src="Scripts/jquery-3.1.1.min.js"></script>
    <script src="Scripts/jquery.signalR-2.2.1.min.js"></script>
    <script src="http://localhost:59147/signalr/hubs"></script>
    <script type="text/javascript">
        $(function () {
            var conn = $.hubConnection("http://localhost:59147/signalr");
            var lobby = conn.createHubProxy('LobbyHub');
                                                     
            lobby.on('BroadcastLobbies', function (lobbies) {
                decLobbies = JSON.parse(lobbies);
                $('#lobbyContainer').html("");
                for (i = 0; i < decLobbies.length; ++i) {
                    $('#lobbyContainer').append('<p>' + decLobbies[i] + '</p>');
                }
            });
            
            conn.start().done(function () {
                $("#sendLobby").click(function () {
                    console.log("button clicked");
                    lobby.invoke('SendLobby', $("#username").val(), $("#text").val());
                    $('#text').val('').focus();
                });
            });

        });

    </script>
    

</body>
</html>

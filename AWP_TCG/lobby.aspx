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

    <div id="lobbyContainer" style="overflow: auto; width: 500px; height: 500px;">
        <table id="lobbyTable">
            <tr><td>Loading lobbies...</td></tr>
        </table>
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
                $('#lobbyTable').html("<thead><tr><th>Lobby</th><th>Creator</th><th></th></tr></thead>");
                for (i = 0; i < decLobbies.length; ++i) {
                    $('#lobbyTable').append('<tr><td>' + decLobbies[i]["Item1"] + "</td><td>" + decLobbies[i]["Item2"] + '</td><td><input type=\"button\" id=\"joinButton" value="Join" style="float:right"/></td></tr>'); //Tuples in JSON are sent as objects with the values identified by keys "Item1", "Item2", and so on.
                }
                $('#lobbyTable').append("</table>")
            });
            
            conn.start().done(function () {
                $("#sendLobby").click(function () {
                    console.log("button clicked");
                    lobby.invoke('SendLobby', $("#text").val(), $("#username").val());
                    $('#text').val('').focus();
                });
            });

        });

    </script>
    

</body>
</html>

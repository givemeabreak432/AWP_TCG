<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="lobby.aspx.cs" Inherits="AWP_TCG.lobby" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

</head>
<body>
    <div id="lobbyDiv" runat="server">
    <form id="form1" runat="server">
        <input type="hidden" id="username" runat="server" />
        
    </form>

    <input type="text" id="text" />
    <input type="button" id="sendLobby" value="Send"/>
    <input type="button" id="joinProxy" value="test" style="visibility: hidden"/>

    <form action="/GameRoom.aspx" method="post" target="_top">
        <input type="hidden" id="roomID" name="roomID" value=""/>
        <input type="submit" id="submitProxy" style="visibility: hidden"/>
    </form>

    <div id="lobbyContainer" style="overflow: auto;">
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
            var _ConnectLobby;
            var curID = 0;
                                                     
            lobby.on('BroadcastLobbies', function (lobbies) {
                decLobbies = JSON.parse(lobbies);
                $('#lobbyTable').html("<thead><tr><th>Lobby</th><th>Creator</th><th></th></tr></thead>");
                for (i = 0; i < decLobbies.length; ++i) {
                    $('#lobbyTable').append('<tr><td>' + decLobbies[i]["name"] + "</td><td>" + decLobbies[i]["host"] + '</td><td><input type=\"button\" class=\"joinButton" id="' + decLobbies[i]["id"] + '" value="Join" style= "float:right" /></td ></tr > '); //Tuples in JSON are sent as objects with the values identified by the object Lobby in LobbyHub
                    $("#" + decLobbies[i]["id"]).prop("disabled", decLobbies[i]["isFull"]);
                    //console.log("ID: " + decLobbies[i]["id"] + "; isFull: " + decLobbies[i]["isFull"]);
                }
                $('#lobbyTable').append("</table>")
                $(".joinButton").click(function () {
                    //_ConnectLobby($(this.id)); //TODO: this is not changing the value of the lobby to true as intended. Console prints fine, but function does not appear to be attached.
                    curID = this.id;
                    $("#joinProxy").trigger("click");
                    //console.log("clicked");
                });
            });
            
            conn.start().done(function () {
                $("#sendLobby").click(function () {
                    //console.log("button clicked");
                    curID = $(this.id)
                    lobby.invoke('SendLobby', $("#text").val(), $("#username").val());
                    $('#text').val('').focus();
                });

                _ConnectLobby = function (id) {
                    lobby.invoke('ConnectLobby', id);
                }

                $("#joinProxy").click(function () {
                    //console.log(curID);
                    _ConnectLobby(curID);
                    $("#roomID").val(curID);
                    $("#submitProxy").trigger("click");
                    
                });

                lobby.invoke('PageStart', 'lobby');

            });

        });

    </script>
    </div>
    <div id = "loginDiv" runat ="server">
        Please login to use this feature.
    </div>

</body>
</html>

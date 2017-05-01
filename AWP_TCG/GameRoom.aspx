<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GameRoom.aspx.cs" Inherits="AWP_TCG.GameRoom" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="username" runat="server" />
        <input type="text" runat="server" id="roomID" value=" " placeholder="null" style="visibility:hidden"/>
    </form>

    <input type="button" id="startProxy" value="" style="visibility:hidden" />

    <div id="chatContainer" style="overflow: scroll; width: 500px; height: 500px;">
        <input type="text" id="text" />
        <input type="button" id="sendMessage" value="Send"/>
    </div>

    <script src="Scripts/jquery-3.1.1.min.js"></script>
    <script src="Scripts/jquery.signalR-2.2.1.min.js"></script>
    <script src="http://localhost:59147/signalr/hubs"></script>
    <script type="text/javascript">
        $(function () {
           //var chat = $.connection.ChatHub;
            var conn = $.hubConnection("http://localhost:59147/signalr");
            var lobby = conn.createHubProxy('LobbyHub');

            lobby.on('BroadcastMessage', function (name, message, roomID) {
                var encodedName = $('<div />').text(name).html();
                var encodedMsg = $('<div />').text(message).html();
                var encodedID = $('<div />').text(roomID).html();
                $('#chatContainer').append('<p><b>' + encodedName + '</b> (' + roomID + "): &nbsp;" + encodedMsg + '</p>');
            });

            lobby.on('JoinRoom', function () {
                console.log($("#roomID").val());
                $("#startProxy").trigger("click");
            });
            
            conn.start().done(function () {
                $("#sendMessage").click(function () {
                    //console.log("button clicked");
                    lobby.invoke('SendMessage', $("#username").val(), $("#text").val(), $("#roomID").val());
                    $('#text').val('').focus();
                });

                $("#startProxy").click(function () {
                    lobby.invoke('JoinRoom', $("#roomID").val());
                });

                lobby.invoke('PageStart', 'gameRoom');
            });

        });

    </script>

</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="chat.aspx.cs" Inherits="AWP_TCG.chat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        * {
            margin: 0;
        }
        #messageFooter{
            width: 100%;
            bottom: 0;
            position: fixed;
        }

    </style>
</head>
<body>

    <form id="form1" runat="server">
        <input type="hidden" id="username" runat="server" />
    </form>

    <div id="chatContainer" runat= "server" style="width: 100%; height: 100%;">
    </div><br />
    <br />
    <footer id="messageFooter">
         <input type="button" runat="server" id="sendMessage" value="Send" style="width:15%"/>
         <input type="text" id="text" style="width:80%"/>
    </footer>

    <script src="Scripts/jquery-3.1.1.min.js"></script>
    <script src="Scripts/jquery.signalR-2.2.1.min.js"></script>
    <script src="http://localhost:59147/signalr/hubs"></script>
    <script type="text/javascript">
        $(function () {
            //var chat = $.connection.ChatHub;
            var conn = $.hubConnection("http://localhost:59147/signalr");
            var chat = conn.createHubProxy('LobbyHub');

            chat.on('BroadcastMessage', function (name, message, roomID) {
                var encodedName = $('<div />').text(name).html();
                var encodedMsg = $('<div />').text(message).html();
                var encodedID = $('<div />').text(roomID).html();
                $('#chatContainer').append('<p><b>' + encodedName + '</b> (' + roomID + "): &nbsp;" + encodedMsg + '</p>');
                window.scrollTo(0, document.body.scrollHeight);
            });
            
            conn.start().done(function () {
                $("#sendMessage").click(function () {
                    chat.invoke('SendMessage', $("#username").val(), $("#text").val(), "all");
                    $('#text').val('').focus();
                });
            });

        });

    </script>


</body>
</html>

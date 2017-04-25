<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="chat.aspx.cs" Inherits="AWP_TCG.chat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>

    <form id="form1" runat="server">
        <input type="hidden" id="username" runat="server" />
    </form>

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
            var chat = conn.createHubProxy('ChatHub');

            chat.on('BroadcastMessage', function (name, message) {
                var encodedName = $('<div />').text(name).html();
                var encodedMsg = $('<div />').text(message).html();
                $('#chatContainer').append('<p><b>' + encodedName + '</b>: &nbsp;' + encodedMsg + '</p>');
            });
            
            conn.start().done(function () {
                $("#sendMessage").click(function () {
                    console.log("button clicked");
                    chat.invoke('SendMessage', $("#username").val(), $("#text").val());
                    $('#text').val('').focus();
                });
            });

        });

    </script>


</body>
</html>

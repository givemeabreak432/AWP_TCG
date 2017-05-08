<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GameRoom.aspx.cs" Inherits="AWP_TCG.GameRoom" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        #chatContainerContainer{
            bottom:0;
            height:35%;
            width:80%;
            position:fixed;
        }
    </style>
</head>
<body>
    <!--data source-->
    <asp:SqlDataSource ID="SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SelectDecKByOwner" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="ownerID" Type ="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <form id="form1" runat="server">
        <input type="hidden" id="username" runat="server" />
        <asp:TextBox id="playerID" runat="server" OnChange="setID" AutoPostBack="true" style="visibility:hidden" />
        <input type="text" runat="server" id="roomID" value=" " placeholder="null" style="visibility:hidden"/>

    <input type="button" id="startProxy" value="" style="visibility:hidden" />

    <div id="chatContainerContainer" style="overflow: scroll">
        <input type="text" id="text" />
        <input type="button" id="sendMessage" value="Send"/>
    <div id="chatContainer" runat="server">
    </div>
    </div>

    <div id="deckSelectionDiv" runat="server">
          <asp:DropDownList ID="DropdownOfDecks" runat="server" DataSourceID="SqlDataSource" DataTextField="deckName" DataValueField="deckName" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"></asp:DropDownList>
          <asp:Button ID="SelectButton" runat="server" Text="Select Deck!" OnClick="SelectButton_Click" />
    </div>


    <div id="handContainer" runat="server">
    </div>
    </form>

    <script src="Scripts/jquery-3.1.1.min.js"></script>
    <script src="Scripts/jquery.signalR-2.2.1.min.js"></script>
    <script src="http://localhost:59147/signalr/hubs"></script>
    <script type="text/javascript">
        $(function () {
           //var chat = $.connection.ChatHub;
            var conn = $.hubConnection("http://localhost:59147/signalr");
            var lobby = conn.createHubProxy('LobbyHub');
            var playerID = -1;

            lobby.on('BroadcastMessage', function (name, message, roomID) {
                var encodedName = $('<div />').text(name).html();
                var encodedMsg = $('<div />').text(message).html();
                var encodedID = $('<div />').text(roomID).html();
                $('#chatContainer').prepend('<p><b>' + encodedName + '</b> (' + roomID + "): &nbsp;" + encodedMsg + '</p>');

            });

            lobby.on('JoinRoom', function () {
                console.log($("#roomID").val());
                $("#startProxy").trigger("click");

            });

            lobby.on('ReceiveID', function (connections) {
                playerID = connections;
                $('#playerID').val(playerID);
                $('#handContainer').prepend('<p><b>You are player ' + playerID + '</b></p>');
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
                if ($('#playerID').val() == "")
                {
                    lobby.invoke('GetPlayerID', $("#roomID").val());
                }
            });

        });

    </script>

</body>
</html>

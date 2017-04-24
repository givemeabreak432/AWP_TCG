using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;

namespace AWP_TCG
{
    public class LobbyHub : Hub
    {
        public void UpdateLobbies()
        {
            Clients.All.broadcastMessage();
        }

        public void AddLobby()
        {

            UpdateLobbies();
        }
    }
}
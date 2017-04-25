using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using System.Collections;
using Newtonsoft.Json;

namespace AWP_TCG
{
    public class LobbyHub : Hub
    {
        
        private static List<string> lobbies = new List<string>();

        public void SendLobby(string name, string room)
        {
            lobbies.Add(room);
            string json = JsonConvert.SerializeObject(lobbies, Formatting.None);
            Clients.All.BroadcastLobbies(json);
        }
    }
}
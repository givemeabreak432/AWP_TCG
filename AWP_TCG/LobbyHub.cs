using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using System.Collections;
using Newtonsoft.Json;
using System.Threading.Tasks;

namespace AWP_TCG
{
    public class LobbyHub : Hub
    {
        
        private static List<Tuple<string, string>> lobbies = new List<Tuple<string, string>>();

        public void SendLobby(string room, string name)
        {
            lobbies.Add(Tuple.Create(room, name));
            string json = JsonConvert.SerializeObject(lobbies, Formatting.None);
            Clients.All.BroadcastLobbies(json);
        }

        public override Task OnConnected()
        {
            string json = JsonConvert.SerializeObject(lobbies, Formatting.None);
            Clients.Client(Context.ConnectionId).BroadcastLobbies(json);

            return base.OnConnected();
        }
    }

}
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
        
        private static List<Lobby> lobbies = new List<Lobby>(); //lobby attributes, in order: id, room name, host name, room full

        public void SendLobby(string room, string name)
        {
            lobbies.Add(new Lobby(Guid.NewGuid().ToString("N"), room, name, false)); //Guid guaruntees a unique id for each lobby
            string json = JsonConvert.SerializeObject(lobbies, Formatting.None);
            Clients.All.BroadcastLobbies(json);
        }

        public void ConnectLobby(string id)
        {
            foreach (Lobby item in lobbies)
            {
                if(item.id.Equals(id))
                {
                    item.isFull = true;
                }
            }

            string json = JsonConvert.SerializeObject(lobbies, Formatting.None);
            Clients.All.BroadcastLobbies(json);
        }

        public override Task OnConnected()
        {
            string json = JsonConvert.SerializeObject(lobbies, Formatting.None);
            Clients.Client(Context.ConnectionId).BroadcastLobbies(json);
            return base.OnConnected();
        }

        public class Lobby
        {
            public string id { get; set; }
            public string name { get; set; }
            public string host { get; set; }
            public bool isFull { get; set; }

            public Lobby(string inID, string inName, string inHost, bool inFull)
            {
                id = inID;
                name = inName;
                host = inHost;
                isFull = inFull;
            }
        }

    }

}
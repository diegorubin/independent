var WebSocketServer = require('ws').Server;

var server = new WebSocketServer({ port: 8080 });

var sessions = {};
var nextId = 0;
 
server.on('connection', function connection(client) {

  client.on('message', function incoming(message) {
    console.log(message);
    var message = JSON.parse(message);
    if(message.event === 'start') newSession(message);
    if(message.event === 'view') newClient(client, message);
    if(message.event === 'update') updateClients(message);
  });

});

function newSession(message) {
  if(!sessions[message.session]) sessions[message.session] = {'clients': []};
}

function newClient(client, message) {
  if(!sessions[message.session]) sessions[message.session] = {'clients': []};
  sessions[message.session].clients.push(client);
}

function updateClients(message) {
  for(var i = 0; i < sessions[message.session].clients.length; i++) {
    var client = sessions[message.session].clients[i];
    client.send(JSON.stringify(message.content), function(){/*not send*/});
  }
}


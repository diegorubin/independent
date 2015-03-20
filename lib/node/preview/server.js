var markdown = require( "markdown" ).markdown;
var WebSocketServer = require('ws').Server;

var server = new WebSocketServer({ port: 8080 });

var sessions = {};
var nextId = 0;
 
server.on('connection', function connection(client) {

  client.on('message', function incoming(message) {
    var message = JSON.stringify();
    if(!sessions[session]) sessions[session] = {'clients': []};
    sessions[session].clients.push(client);
  });

});

//notify clients
ws.on('message', function broadcast(message){
  ws.connections.forEach(function(connection){
  });
});


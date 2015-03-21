var markdown = require( "markdown" ).markdown;
var WebSocketServer = require('ws').Server;

var server = new WebSocketServer({ port: 8080 });

var sessions = {};
var nextId = 0;
 
server.on('connection', function connection(client) {

  client.on('message', function incoming(message) {
    console.log(message);
    var message = JSON.parse(message);
    if(!sessions[message.session]) sessions[message.session] = {'clients': []};
    sessions[message.session].clients.push(client);
  });

});

//notify clients
server.on('message', function broadcast(message){
  console.log("-> " + message);
  server.connections.forEach(function(connection){
  });
});


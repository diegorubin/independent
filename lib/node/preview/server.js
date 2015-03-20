var markdown = require( "markdown" ).markdown;

var WebSocketServer = require('ws').Server
  , wss = new WebSocketServer({ port: 8080 });
 
wss.on('connection', function connection(ws) {
  ws.on('message', function incoming(message) {
    console.log('received:\n %s', markdown.toHTML(message));
  });
 
  ws.send('something');
});


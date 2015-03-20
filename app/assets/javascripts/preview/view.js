var PreviewView = function() {
}

PreviewView.prototype.connect = function(session) {

  this.session = session;
  this.connection = new WebSocket('ws://localhost:8080');
  this.connection.onopen = function() {
    var message = JSON.stringify({'event': 'view', 'session': session});
    _this.connection.send(message);  
  }

}

PreviewView.prototype.render = function() {
}

// load preview socket
$(document).ready(function(){

});


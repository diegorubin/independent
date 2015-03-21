var PreviewForm = function() {

}

PreviewForm.prototype.connect = function(session) {
  var _this = this;

  this.session = session;
  this.connection = new WebSocket('ws://localhost:8080');
  this.connection.onopen = function() {
    var message = JSON.stringify({'event': 'start', 'session': session});
    _this.connection.send(message);  
  }

}


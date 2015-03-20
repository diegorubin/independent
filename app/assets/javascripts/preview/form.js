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

  this.on('change', function(event){
    console.log($(this).val());
    _this.connection.send($(this).val());
  });
}


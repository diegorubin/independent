var PreviewForm = function() {

}

PreviewForm.prototype.connect = function(session) {
  var _this = this;

  this.session = session;
  this.connection = new WebSocket($('meta[name="preview_host"]').attr('content'));
  this.connection.onopen = function() {
    var message = JSON.stringify({'event': 'start', 'session': session});
    _this.connection.send(message);  
  }

}

PreviewForm.prototype.send = function(content) {
  var _this = this;
  var object = {'event': 'update', 'session': _this.session};
  object.content = content;
  _this.connection.send(JSON.stringify(object));  
}


var PreviewView = function() {
}

PreviewView.prototype.connect = function(session) {
  var _this = this;

  this.session = session;
  this.connection = new WebSocket('ws://localhost:8080');
  this.connection.onopen = function() {
    var message = JSON.stringify({'event': 'view', 'session': session});
    _this.connection.send(message);  
  }

  this.connection.onmessage = function(message) {
    var content = JSON.parse(message.data);

    //render
    $.each(content, function(attr, value) {
      $("[data-preview-attribute='" + attr + "']").html(value);
    });
  }

}

// load preview socket
$(document).ready(function(){

  if(Utils.getParams().preview_session) {
    var preview = new PreviewView();
    preview.connect(Utils.getParams().preview_session);
  }

});


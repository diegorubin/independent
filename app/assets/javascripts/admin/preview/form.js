var PreviewForm = function() {

}

PreviewForm.prototype.connect = function(session) {
  var _this = this;

  this.session = session;
  this.connection = new WebSocket('ws://localhost:8080');
  this.connection.onopen = function() {
    _this.connection.send('');  
  }

  $("input").keyup(function(event){
    console.log($(this).val());
    _this.connection.send($(this).val());
  });
}

// load preview socket
$(document).ready(function(){
  var data_session = $('*[data-preview-session]');
  if(data_session.length > 0) {
    var connection = new PreviewForm();
    connection.connect(data_session.attr('data-preview-session'));
  }
});



//= require_self
function Kindle(resource, slug) {
  var _this = this;
  var closed = true;

  _this.init = function() {
    document.getElementById("send-kindle").onclick = function(event) {
      event.preventDefault();

      var image = document.getElementById("send-kindle-icon");

      if(closed) {
        _this.getForm();
        image.setAttribute('src', '/images/ereader-icon-red.png');
      } else {
        _this.closeDialog();
        image.setAttribute('src', '/images/ereader-icon.png');
      }
      closed = !closed;

    };
  };

  _this.openDialog = function(html) {
    var overlay = document.getElementById('overlay-kindle');
    overlay.innerHTML = html;
  };

  _this.closeDialog = function() {
    var overlay = document.getElementById('overlay-kindle');
    overlay.innerHTML = '';
  };

  _this.getForm = function() {

    var xmlhttp = new XMLHttpRequest();
    var url = "/kindle/new?resource=" + resource + "&slug=" + slug + "&location=" + window.location;
    
    xmlhttp.onreadystatechange = function() {
      if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        _this.openDialog(xmlhttp.responseText);
      }
    };
    xmlhttp.open("GET", url, true);
    xmlhttp.send();
  };

};


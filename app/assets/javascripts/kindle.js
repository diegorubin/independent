//= require_self
function Kindle(resource, slug) {
  var _this = this;

  _this.init = function() {
    document.getElementById("send-kindle").onclick = function(event) {
      event.preventDefault();
      _this.getForm();

    };
  };

  _this.openDialog = function(html) {
    var overlay = document.getElementById('overlay-kindle');
    overlay.innerHTML = html;
  };

  _this.getForm = function() {

    var xmlhttp = new XMLHttpRequest();
    var url = "/kindle/new?resource=" + resource + "&slug=" + slug + "&location=" + window.location;
    
    xmlhttp.onreadystatechange = function() {
      if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        console.log(xmlhttp.responseText);
        _this.openDialog(xmlhttp.responseText);
      }
    };
    xmlhttp.open("GET", url, true);
    xmlhttp.send();
  };

};


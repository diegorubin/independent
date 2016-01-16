function FileArea(fileArea) {
  var self = this;

  self.fileArea = fileArea;

  self.init = function() {
    self.fileArea.addEventListener("dragleave", self.dragHover, false);
    self.fileArea.addEventListener("dragover", self.dragHover, false);
    self.fileArea.addEventListener("drop", self.drop, false);
 
  };

  self.dragHover = function(e) {
    e.stopPropagation();  
    e.preventDefault();  

    self.fileArea.className = (e.type == "dragover" ? "hover" : "");  
  };

  self.drop = function(e) {
    self.dragHover(e);  
    self.file = e.dataTransfer.files[0];  
    self.read(self.file);
  };

  self.read = function(file) {
    if (file.type.match('image.*')) {
      var reader = new FileReader();

      reader.onload = function(f) {
        self.onLoadFile(f);
      }

      reader.readAsDataURL(file);
    }
  };

}


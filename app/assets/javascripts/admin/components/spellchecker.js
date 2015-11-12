var Spellchecker = function() {
}

Spellchecker.prototype.loadFromTextarea = function(textarea) {
  var _this = this;
  _this.textarea = textarea;

  _this.textarea.on('change', function(){
    console.log('teste');
  });
}

Spellchecker.prototype.addWord = function(word) {
}


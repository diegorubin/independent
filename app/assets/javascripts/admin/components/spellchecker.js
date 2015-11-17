var Spellchecker = function() {
  var _this = this;
  _this.currentWord = 0;
  _this.result = undefined;
  _this._loadUI();
}

Spellchecker.prototype.loadFromCodemirror = function(codemirrorObject) {
  var _this = this;

  codemirrorObject.on('change', function() {
    clearTimeout(_this.callCheckText);
    _this.callCheckText = setTimeout(function(){
      $.ajax({
        url: "/admin/api/v1/spellchecker",
        method: "POST",
        data: {text:codemirrorObject.getValue()}
      }).done(function(result){
        _this.result = result;
        _this._showWord(_this.currentWord);
      });
    }, 400);
  });

}

Spellchecker.prototype.addWord = function(word) {
}

Spellchecker.prototype.ignoreWord = function() {
  var _this = this;
  _this._showWord(++_this.currentWord);
}

Spellchecker.prototype._loadUI = function() {
  var _this = this;
  $('#spellchecker-ignore').click(function(event){
    event.preventDefault();
    _this.ignoreWord();
  });
}

Spellchecker.prototype._showWord = function(position) {
  var _this = this;
  if(_this.result[_this.currentWord]) {
    $('.spellchecker-current').html(_this.currentWord + 1);
    $('.spellchecker-total').html(_this.result.length);
    $('#spellchecker-word').val(_this.result[_this.currentWord].word);
  }
}


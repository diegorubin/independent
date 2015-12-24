var Spellchecker = function(forField) {
  var _this = this;
  _this.currentWord = 0;
  _this._forField = forField;
  _this._loadUI();
};

Spellchecker.prototype.loadFromCodemirror = function(codemirrorObject) {
  var _this = this;
  _this.codemirrorObject = codemirrorObject;

  codemirrorObject.on('change', function() {
    clearTimeout(_this.callCheckText);
    _this.callCheckText = setTimeout(function(){
      _this.reloadDictionary();
    }, 60000);
  });
};

Spellchecker.prototype.reloadDictionary = function() {
  var _this = this;
  $.ajax({
    url: "/admin/api/v1/spellchecker/check",
    method: "POST",
    data: {text: _this.codemirrorObject.getValue()}
  }).done(function(result){
    _this.setDictionary(result);
  });
};

Spellchecker.prototype.setDictionary = function(value) {
  var _this = this;
  _this.dictionary = value;
  if (_this.dictionary.length) {
    _this._showWord(_this.currentWord);
  } else {
    _this._clearFields();
  }
};

Spellchecker.prototype.getDictionary = function() {
  var _this = this;
  return _this.dictionary;
};

Spellchecker.prototype.addWord = function(word) {
  var _this = this;

  $.ajax({
    url: "/admin/api/v1/spellchecker/add",
    method: "POST",
    data: {word: _this._findField('.spellchecker-word').val() }
  }).done(function(result){
    _this.reloadDictionary();
  });

};

Spellchecker.prototype.changeWord = function(newWord) {
  var _this = this;

  var start = _this.getDictionary()[_this.currentWord].column;
  var end = start + (_this.getDictionary()[_this.currentWord].word).length;
  var line = _this.getDictionary()[_this.currentWord].line;

  _this.codemirrorObject.setSelection(
    {line: line, ch: start}, {line: line, ch: end}
  );

  _this.codemirrorObject.replaceSelection(newWord);

};

Spellchecker.prototype.ignoreWord = function() {
  var _this = this;

  if(_this.currentWord < (_this.dictionary.length -1)) {
    _this.currentWord++;
  } else {
    _this.currentWord = 0;
  }

  _this._showWord(_this.currentWord);
};

Spellchecker.prototype._loadUI = function() {
  var _this = this;

  _this._findField('.spellchecker-add').click(function(event){
    event.preventDefault();
    _this.addWord();
  });

  _this._findField('.spellchecker-ignore').click(function(event){
    event.preventDefault();
    _this.ignoreWord();
  });

  _this._findField('.spellchecker-change').click(function(event){
    event.preventDefault();
    _this.changeWord(_this._findField('.spellchecker-word').val());
  });

  _this._findField('.spellchecker-check').click(function(event){
    event.preventDefault();
    _this.reloadDictionary();
  });
};

Spellchecker.prototype._showWord = function(position) {
  var _this = this;
  if(_this.getDictionary()[_this.currentWord]) {
    _this._findField('.spellchecker-current').html(_this.currentWord + 1);
    _this._findField('.spellchecker-total').html(_this.getDictionary().length);
    _this._findField('.spellchecker-word')
      .val(_this.getDictionary()[_this.currentWord].word);
  }
};

Spellchecker.prototype._clearFields = function() {
  var _this = this;
  _this._findField('.spellchecker-current').html('0');
  _this._findField('.spellchecker-total').html('0');
  _this._findField('.spellchecker-word').val('');
};

Spellchecker.prototype._findField = function(klass) {
  var _this = this;
  var field = $('.spellchecker[data-field="' + _this._forField + '"]').find(klass);
  return $(field);
};


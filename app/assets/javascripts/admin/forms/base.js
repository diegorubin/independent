var BaseForm = function() {
}

BaseForm.prototype.save = function() {
}

BaseForm.prototype.loadFields = function() {
  var _this = this;
  $.each(this.fieldIds(), function(position, fieldId){
    $("#" + fieldId).keyup(function(event){
      _this.content[$(this).attr('id')] = $(this).val();
      _this.connection.send(_this.content);
    });
  }); 
}

BaseForm.prototype.connectPreviewServer = function() {
  if(this.form.attr('data-preview-session')) {
    this.connection = new PreviewForm();
    this.connection.connect(this.form.attr('data-preview-session'));
  }
}

BaseForm.prototype.loadCodeMirror = function() {
  var _this = this;
  var textareas = _this.form.find('textarea');
  $.each(textareas, function(index, textarea) {
    var editor = CodeMirror.fromTextArea(textarea, _this.getOptions());
    editor.on('change', function() {
      $.ajax({
        url: "/admin/api/v1/markdown",
        method: "POST",
        data: {markdown:editor.getValue()}
      }).done(function(result) {
        _this.content[textarea.id] = result;
        _this.connection.send(_this.content);
      });
    });
  });
}

// form functions utils
function loadForm(selector, callback) {
  if($(selector).length > 0) {
    callback(selector);
  }
}


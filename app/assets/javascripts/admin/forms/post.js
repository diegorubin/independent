var PostForm = function() {
}

PostForm.prototype = new BaseForm();
PostForm.prototype.constructor = PostForm;

PostForm.prototype.init = function(form) {
  var _this = this;

  _this.content = {};
  _this.editors = [];
  _this.form = $(form);
  var textareas = _this.form.find('textarea');

  _this.loadFields();

  $.each(textareas, function(index, textarea) {
    _this.editors.push(CodeMirror.fromTextArea(textarea, _this.getOptions()));
  });

  if(this.form.attr('data-preview-session')) {
    this.connection = new PreviewForm();
    this.connection.connect(this.form.attr('data-preview-session'));
  }
}

PostForm.prototype.getOptions = function() {
  return {lineNumbers: true, mode: 'markdown'};
}

// fields form
PostForm.prototype.fieldIds = function() {
  return ['post_title'];
}

PostForm.prototype.loadFields = function() {
  var _this = this;
  $.each(this.fieldIds(), function(position, fieldId){
    $("#" + fieldId).keyup(function(event){
      _this.content[$(this).attr('id')] = $(this).val();
      _this.connection.send(_this.content);
    });
  }); 
}

//load PostForm
loadForm('form#post', function(formElem){
  var form = new PostForm();
  form.init(formElem);
});

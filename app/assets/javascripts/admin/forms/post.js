var PostForm = function() {
}

PostForm.prototype = new BaseForm();
PostForm.prototype.constructor = PostForm;

PostForm.prototype.init = function(form) {
  var _this = this;

  this.form = $(form);
  var textareas = this.form.find('textarea');

  $.each(textareas, function(index, textarea) {
    CodeMirror.fromTextArea(textarea, _this.getOptions());
  });

}

PostForm.prototype.getOptions = function() {
  return {lineNumbers: true, mode: 'markdown'};
}

//load PostForm
loadForm('form#post', function(formElem){
  var form = new PostForm();
  form.init(formElem);
});

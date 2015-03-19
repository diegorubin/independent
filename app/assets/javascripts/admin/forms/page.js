var PageForm = function() {
}

PageForm.prototype = new BaseForm();
PageForm.prototype.constructor = PageForm;

PageForm.prototype.init = function(form) {
  var _this = this;

  this.form = $(form);
  var textarea = this.form.find('textarea')[0];
  CodeMirror.fromTextArea(textarea, _this.getOptions());

}

PageForm.prototype.getOptions = function() {
  return {lineNumbers: true, mode: 'markdown'};
}

//load PageForm
loadForm('form#page', function(formElem){
  var form = new PageForm();
  form.init(formElem);
});

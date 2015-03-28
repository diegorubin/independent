var PageForm = function() {
}

PageForm.prototype = new BaseForm();
PageForm.prototype.constructor = PageForm;

PageForm.prototype.init = function(form) {
  var _this = this;

  _this.content = {};
  _this.form = $(form);

  _this.loadFields();

  _this.loadAutoSave();
  _this.loadFocusMode();
  _this.loadCodeMirror();
  _this.connectPreviewServer();
}

PageForm.prototype.getOptions = function() {
  return {lineNumbers: true, mode: 'markdown'};
}

// fields form
PageForm.prototype.fieldIds = function() {
  return ['page_title'];
}

//load PageForm
loadForm('form#page', function(formElem){
  var form = new PageForm();
  form.init(formElem);
});

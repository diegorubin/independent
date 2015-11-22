var PostForm = function() {
  var _this = this;
};

PostForm.prototype = new BaseForm();
PostForm.prototype.constructor = PostForm;

PostForm.prototype.init = function(form) {
  var _this = this;

  _this.content = {};
  _this.form = $(form);

  _this.loadFields();

  _this.loadAutoSave();
  _this.loadFocusMode();
  _this.loadCodeMirror();

  _this.loadSpellchecker();

  _this.connectPreviewServer();

};

PostForm.prototype.getOptions = function() {
  return {lineNumbers: true, mode: 'markdown'};
};

// fields form
PostForm.prototype.fieldIds = function() {
  return ['post_title', 'post_category', 'post_tags'];
};

//load PostForm
loadForm('form#post', function(formElem){
  var form = new PostForm();
  form.init(formElem);
});


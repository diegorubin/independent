var SnippetForm = function() {
}

SnippetForm.prototype = new BaseForm();
SnippetForm.prototype.constructor = SnippetForm;

SnippetForm.prototype.init = function(form) {
  var _this = this;

  this.form = $(form);
  var textarea = this.form.find('textarea')[0];
  this.editor = CodeMirror.fromTextArea(textarea, this.getOptions());

  // binds
  this.form.find('#snippet_language').change(function(event){
    _this.setLanguage($(this).val());
  });
}

SnippetForm.prototype.setLanguage = function(language) {
  console.log(language);
  this.editor.setOption("mode", language);
}

SnippetForm.prototype.getOptions = function() {
  return {lineNumbers: true, mode: 'ruby'};
}

//load SnippetForm
loadForm('form#snippet', function(formElem){
  var form = new SnippetForm();
  form.init(formElem);
});


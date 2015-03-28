var BaseForm = function() {
}

BaseForm.prototype.refresh = function(resource) {
}

BaseForm.prototype.save = function() {
  var _this = this;

  $.ajax({
    type: options['method'] || 'POST',
    dataType: options['type'] || 'json',
    data: options['data'] || {},
    url: _this.url,

    success: function(data, textStatus, xhr) {
      if(self.refresh) self.refresh(data);
    },

    error: function(data) {
      location.reload();
    }
  });
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

BaseForm.prototype.loadAttributes = function() {

  var attrs = {};
  var field_types = ["input", "select", "textarea", "hidden"];

  for(var j = 0; j < field_types.length; j++){
    var inputs = form.find(field_types[j]);

    for(var i = 0; i < inputs.length; i++) {
      var input = $(inputs[i]);
      attrs[input.attr("name")] = input.val();
    }

  }

  /* get values of radio and checkbox */
  var radios = $("input[type='radio']:checked");

  for(var i = 0; i < radios.length; i++) {
    var name = $(radios[i]).attr('name');
    attrs[name] = $(radios[i]).val();
  }

  var checkboxes = $("input[type='checkbox']");
  for(var i = 0; i < checkboxes.length; i++) {
    var name = $(checkboxes[i]).attr('name') || '';

    if(name.match(/\[\]$/)) {

      if((typeof attrs[name]) == 'string') {attrs[name] = [];}
      if($(checkboxes[i]).is(":checked"))
        attrs[name].push($(checkboxes[i]).val());

    } else {

      attrs[name] =
        ($(checkboxes[i]).is(":checked") ? $(checkboxes[i]).val() : '');

    }
  }

  return attrs;
}

// form functions utils
function loadForm(selector, callback) {
  if($(selector).length > 0) {
    callback(selector);
  }
}


var BaseForm = function() {
}

BaseForm.prototype.save = function() {
}

// form functions utils
function loadForm(selector, callback) {
  if($(selector).length > 0) {
    callback(selector);
  }
}


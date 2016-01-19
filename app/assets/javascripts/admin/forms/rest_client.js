function RestClient(api, options) {
  var _this = this;
  _this.api = api;
  _this.options = options || {};

  _this.call = function(method, data) {
    _this.data = data;
    _this.method = method;

    var options = _this.prepareDefaultOptions();

    for(var option in _this.options) {
      options[option] = _this.options[option];
    }

    for(var property in options) {
      if(options[property] == undefined) delete options[property];
    }

    $.ajax(options);
  };

  _this.prepareDefaultOptions = function() {
    options = {
      type: _this.method,
      dataType: 'json',
      data: _this.data,
      url: _this.api,

      success: function(data, textStatus, xhr) {
        if(_this.success) _this.success(data, textStatus, xhr);
      },

      error: function(data) {
        if(_this.error) _this.error(data);
      }
    };

    return options;
  };

};


function RestClient(api) {
  var _this = this;
  _this.api = api;

  _this.call = function(method, data) {
    $.ajax({
      type: method,
      dataType: 'json',
      data: data,
      url: _this.api,

      success: function(data, textStatus, xhr) {
        if(_this.success) _this.success(data, textStatus, xhr);
      },

      error: function(data) {
        if(_this.error) _this.error(data);
      }
    });
  };
}


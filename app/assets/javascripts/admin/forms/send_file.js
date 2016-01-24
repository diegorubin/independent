function SendFile(api) {
  var _this = this;
  _this.api = api;

  _this.send = function(field, file, attributes) {
    var csrf_param = $('meta[name=csrf-param]').attr('content');
    var csrf_token = $('meta[name=csrf-token]').attr('content');

    var data = new FormData();

    data.append(field, file);

    data.append('xhr', true);
    data.append(csrf_param, csrf_token);

    for(var attribute in attributes) {
      data.append(attribute, attributes[attribute]);
    }

    var options = {contentType: false, processData: false, dataType: undefined};
    var client = new RestClient(api, options);

    client.success = function(data, textStatus, xhr) {
      if(_this.success) _this.success(data, textStatus, xhr);
    };

    client.error = function(data) {
      if(_this.error) _this.error(data);
    };

    client.call('POST', data);

  };

}


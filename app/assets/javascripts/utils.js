var Utils = {
  getParams: function() {
    var queryDict = {};
    location.search.substr(1).split("&").forEach(function(item) {
      queryDict[item.split("=")[0]] = item.split("=")[1]
    });
    return queryDict;
  }
}


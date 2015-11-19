var Utils = {

  getParams: function() {
    var queryDict = {};
    location.search.substr(1).split("&").forEach(function(item) {
      queryDict[item.split("=")[0]] = item.split("=")[1]
    });
    return queryDict;
  },

  cloneObject(obj){
    if (obj === null || typeof obj !== 'object') {
        return obj;
    }
 
    var temp = obj.constructor();
    for (var key in obj) {
        temp[key] = cloneObject(obj[key]);
    }
 
    return temp;
  }
}


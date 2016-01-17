var Utils = {

  getParams: function() {
    var queryDict = {};
    location.search.substr(1).split("&").forEach(function(item) {
      queryDict[item.split("=")[0]] = item.split("=")[1]
    });
    return queryDict;
  },

  cloneObject: function(obj){
    if (obj === null || typeof obj !== 'object') {
        return obj;
    }
 
    var temp = obj.constructor();
    for (var key in obj) {
        temp[key] = cloneObject(obj[key]);
    }
 
    return temp;
  },

  slug: function(text) {
    return text.toLowerCase().replace(/[^\w ]+/g,'').replace(/ +/g,'-');
  },

  removeExtension: function(filename) {
    return filename.replace(/\.[^/.]+$/, "");
  }

}


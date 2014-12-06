$(document).ready(function(){

  $(".widget-new-nested").click(function(event) {
    event.preventDefault();

    var self = $(this);

    var url = window.location + "/nesteds/new";

    var data = { model: self.attr('data-model') };

    $.ajax({
      data: data,
      type: "GET",
      url: url,
      success: function(data){
        var content = self.parent();
        content.append(data);
      }
    });

  });

});


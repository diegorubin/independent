function get_attributes_in_form(form) {

  var attrs = {};
  var field_types = ["input", "select", "textarea", "hidden"];

  for(var j = 0; j < field_types.length; j++){
    var inputs = form.find(field_types[j]);

    for(var i = 0; i < inputs.length; i++) {
      var input = $(inputs[i]);
      attrs[input.attr("name")] = input.val();
    }

  }

  return attrs;
}

function Comment(content_type, content_id) {
  var self = this;

  self.content_type = content_type; 
  self.content_id = content_id; 

  self.attrs = {};

  this.create = function() {

    self.wrap = $('.comment-wrap');
    self.form = self.wrap.find('form');

    self.wrap.find(".loading").removeClass("hidden");

    self.attrs = get_attributes_in_form(self.form);
    self.attrs['content_type'] = self.content_type;
    self.attrs['content_id'] = self.content_id;

    $.ajax({
      url: "/comments", type: "POST", data: self.attrs,
      success: function(result) {
        $(".comment-wrap").html(result);
        self.wrap.find(".loading").addClass("hidden");
      }
    });
  };

}

$(document).ready(function(){ 
  $(".comment-wrap").on('click', '.save-comment', function(event) {
    event.preventDefault();
    comment.create();
  });

  $('a.remove_comment').click(function(event) {
    event.preventDefault();
    if(confirm("Você tem certeza?")) {
      var pid = $("#pid").attr('value');
    
      var _parent = $(this).parent();
      var _id = _parent.closest("li.comment").find("#comment-id").attr('value');

      $.ajax({
        type: "DELETE",
        url: "/comments/"+ _id +"?pid="+pid,
        success: function(data){
          _parent.closest("li.comment").html(data);
        }
      });
    }
  });

});


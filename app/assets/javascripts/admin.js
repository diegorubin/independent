//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require rest_in_place
//= require_self
//

$(document).ready(function(){ 

  /* comments */
  $('a.approve_comment').click(function(event) {
    event.preventDefault();
    modify_comment($(this), 'PUT');
  });

  $('a.remove_comment').click(function(event) {
    event.preventDefault();
    modify_comment($(this), 'DELETE');
  });

});


function modify_comment(link, method) {
  if(confirm("Você tem certeza?")) {

    var content_type = link.closest(".comments").find("#content_type").val();

    var comment_id = link.closest(".comment").find("#comment_id").val();
    var parent_id = link.closest(".comment").find("#comment_parent_id").val();
  
    $.ajax({
      type: method,
      url: "/admin/comments/"+ comment_id,
      data: {content_type: content_type, parent_id: parent_id},
      success: function(data){
        link.closest(".comment").html(data);
      }
    });
  }
}


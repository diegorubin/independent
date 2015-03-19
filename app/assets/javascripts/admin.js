//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require codemirror
//
//= require codemirror/mode/clike/clike
//= require codemirror/mode/clojure/clojure
//= require codemirror/mode/commonlisp/commonlisp
//= require codemirror/mode/d/d
//= require codemirror/mode/erlang/erlang
//= require codemirror/mode/fortran/fortran
//= require codemirror/mode/go/go
//= require codemirror/mode/haml/haml
//= require codemirror/mode/javascript/javascript
//= require codemirror/mode/lua/lua
//= require codemirror/mode/markdown/markdown
//= require codemirror/mode/pascal/pascal
//= require codemirror/mode/perl/perl
//= require codemirror/mode/php/php
//= require codemirror/mode/python/python
//= require codemirror/mode/ruby/ruby
//= require codemirror/mode/rust/rust
//= require codemirror/mode/shell/shell
//= require codemirror/mode/sql/sql
//= require codemirror/mode/tcl/tcl
//= require codemirror/mode/xml/xml
//= require codemirror/mode/yaml/yaml
//
//= require rest_in_place
//= require_tree ./admin
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


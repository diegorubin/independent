var ImageSelectComponent = function(content) {
  var _this = this;

  this.container = $(content).closest('.form-wrapper');
  this.content = content;
  $(this.content).on('click', function(event){

    $.ajax({
      type: 'GET',
      dataType: 'json',
      url: '/admin/images',

      success: function(data, textStatus, xhr) {

        // load images
        $.each(data, function(index, image){
        });

        // show modal
        $('#dialog').modal('show');

      },

      error: function(data) {
        location.reload();
      }
    });
  });
}

/* load image select */
$(document).ready(function(){
  $.each($('.image-select-content'), function(index, element){
    new ImageSelectComponent(element);
  });
});


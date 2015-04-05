var ImageSelectComponent = function(content) {
  var _this = this;

  this.image_size = $(content).attr('data-image-size');
  this.container = $(content).closest('.form-wrapper');
  this.content = content;

  var originalValue = this.container.find('input').val();
  if(originalValue) {
    this.loadImage(originalValue.replace(this.image_size, 'thumb'));
  }

  $(this.content).on('click', function(event){

    $.ajax({
      type: 'GET',
      dataType: 'json',
      url: '/admin/images',

      success: function(data, textStatus, xhr) {

        // load structure
        $('#dialog-body').html('');
        $('#dialog-body').append('<ul id="list-images"></li>');

        // load images
        _this.images = data;
        $.each(data, function(index, image){
          $('#list-images').append(_this.renderImage(image, index));
        });

        // show modal
        $('#dialog').modal('show');

      },

      error: function(data) {
        location.reload();
      }
    });
  });

  // set image
  $(document).on('click', '.image-value',  function(event){
    var position = $(this).attr('data-position');

    _this.loadImage(_this.images[position].file.thumb.url);

    var url = _this.images[position].file[_this.image_size].url;
    $(_this.container).find('input').val(url);

    $('#dialog').modal('hide');
  });
}

ImageSelectComponent.prototype.loadImage = function(url) {
  var _this = this;

  var img = $('<img />');
  img.attr('src',url);
  $(_this.container).find('.image-select-content').html(img);
}

ImageSelectComponent.prototype.renderImage = function(image, index) {
  var liObject = $('<li/>');

  var imageObject = $('<img class="image-value" />');
  imageObject.attr('src', image.file.thumb.url);
  imageObject.attr('data-position', index);

  liObject.append(imageObject);

  return liObject;
}

/* load image select */
$(document).ready(function(){
  loadImageSelects();
});

function loadImageSelects() {
  $.each($('.image-select-content'), function(index, element){
    new ImageSelectComponent(element);
  });
}


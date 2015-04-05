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
    _this.loadStructure();
    _this.getImages();
    $('#dialog').modal('show');
  });

  $(document).on('click', '#dialog-previous', function(event){
    event.preventDefault();
    if(_this.page > 1) {
      _this.page = _this.page - 1;
      _this.getImages();
    }
  });

  $(document).on('click', '#dialog-next', function(event){
    event.preventDefault();
    _this.page = _this.page + 1;
    _this.getImages();
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

ImageSelectComponent.prototype.loadStructure = function() {
  var _this = this;

  $('#dialog-title').html(polyglot.t("dialogs.image_select.title"));
  $('#dialog-cancel').html(polyglot.t("dialogs.image_select.cancel"));
  $('#dialog-ok').html(polyglot.t("dialogs.image_select.ok"));
  $('#dialog-ok').prop("disabled", true);

  // load structure
  $('#dialog-body').html('');
  $('#dialog-body').append('<ul id="list-images"></ul>');

  $('#dialog-body').append('<div class="clear"></div>');

  _this.loadPagination();
}

ImageSelectComponent.prototype.loadPagination = function() {
  var _this = this;
  _this.page = 1;

  var pagination = $('<div id="dialog-pagination"></div>');

  var previous = $('<a href="#" id="dialog-previous">-</a>');
  pagination.append(previous);

  var current = $('<span id="dialog-current">1</span>');
  pagination.append(current);

  var next = $('<a href="#" id="dialog-next">+</a>');
  pagination.append(next);

  $('#dialog-body').append(pagination);
}

ImageSelectComponent.prototype.getImages = function() {
  var _this = this;

  $.ajax({
    type: 'GET',
    dataType: 'json',
    url: '/admin/images',
    data: {page: _this.page},

    success: function(data, textStatus, xhr) {
      _this.loadImages(data);
      $("#dialog-current").html(_this.page);
    },

    error: function(data) {
      location.reload();
    }
  });

}

ImageSelectComponent.prototype.loadImages = function(data) {
  var _this = this;

  _this.images = data.result;
  $('#list-images').html('');
  $.each(_this.images, function(index, image){
    $('#list-images').append(_this.renderImage(image, index));
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


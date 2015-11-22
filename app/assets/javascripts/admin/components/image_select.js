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
    $('#dialog').clone().appendTo($($(_this.container).find('.modal-select')));
    _this.dialog = $($(_this.container).find('.modal'));

    _this.loadStructure();
    _this.getFormFilter();
    _this.getImages();

    _this.dialog.modal('show');
  });

  $(_this.container).on('click', '.dialog-previous', function(event){
    event.preventDefault();
    if(_this.page > 1) {
      _this.page = _this.page - 1;
      _this.getImages();
    }
  });

  $(_this.container).on('click', '.dialog-next', function(event){
    event.preventDefault();
    _this.page = _this.page + 1;
    _this.getImages();
  });

  $(_this.container).on('click', '.submit-filter-form', function(event){
    event.preventDefault();
    _this.page = 1;
    _this.getImages();
  });

  // set image
  $(_this.container).on('click', '.image-value',  function(event){
    var position = $(this).attr('data-position');

    _this.loadImage(_this.images[position].file.thumb.url);

    var url = _this.images[position].file[_this.image_size].url;
    $(_this.container).find('input').val(url);

    _this.dialog.modal('hide');
  });
};

ImageSelectComponent.prototype.loadStructure = function() {
  var _this = this;

  $(_this.dialog.find('.dialog-title')).html(polyglot.t("dialogs.image_select.title"));
  $(_this.dialog.find('.dialog-cancel')).html(polyglot.t("dialogs.image_select.cancel"));
  $(_this.dialog.find('.dialog-ok')).html(polyglot.t("dialogs.image_select.ok"));
  $(_this.dialog.find('.dialog-ok')).prop("disabled", true);

  // load structure
  $(_this.dialog.find('.dialog-body')).html('');
  $(_this.dialog.find('.dialog-body')).append('<div class="well"><div class="image-filters"></div></div>');
  $(_this.dialog.find('.dialog-body')).append('<ul class="list-images"></ul>');

  $(_this.dialog.find('.dialog-body')).append('<div class="clear"></div>');

  _this.loadPagination();
};

ImageSelectComponent.prototype.loadPagination = function() {
  var _this = this;
  _this.page = 1;

  var pagination = $('<div class="dialog-pagination"></div>');

  var previous = $('<a href="#" class="btn btn-default dialog-previous">-</a>');
  pagination.append(previous);

  var current = $('<span class="dialog-current">1</span>');
  pagination.append(current);

  var next = $('<a href="#" class="btn btn-default dialog-next">+</a>');
  pagination.append(next);

  $(_this.dialog.find('.dialog-body')).append(pagination);
};

ImageSelectComponent.prototype.getImages = function() {
  var _this = this;

  var data = _this.getFilters();
  data.page = _this.page;

  $.ajax({
    type: 'GET',
    dataType: 'json',
    url: '/admin/images',
    data: data,

    success: function(data, textStatus, xhr) {
      _this.loadImages(data);
      $(_this.dialog.find('.dialog-current')).html(_this.page);
    },

    error: function(data) {
      location.reload();
    }
  });

};

ImageSelectComponent.prototype.getFormFilter = function() {
  var _this = this;

  $.ajax({
    type: 'GET',
    dataType: 'html',
    url: '/admin/filters/Image',

    success: function(data, textStatus, xhr) {
      $(_this.dialog.find('.image-filters')).html(data);
    },

    error: function(data) {
      location.reload();
    }
  });

};

ImageSelectComponent.prototype.getFilters = function() {
  var _this = this;
  var form = $(_this.dialog.find('.image-filters'));

  var filters = {};
  var inputs = form.find('input');
  $.each(inputs, function(index, input){
    filters[$(input).attr('name')] = $(input).val();
  });

  return filters;
};

ImageSelectComponent.prototype.loadImages = function(data) {
  var _this = this;

  _this.images = data.result;
  $(_this.dialog.find('.list-images')).html('');
  $.each(_this.images, function(index, image){
    $(_this.dialog.find('.list-images')).append(_this.renderImage(image, index));
  });
};

ImageSelectComponent.prototype.loadImage = function(url) {
  var _this = this;

  var img = $('<img />');
  img.attr('src',url);
  $(_this.container).find('.image-select-content').html(img);
};

ImageSelectComponent.prototype.renderImage = function(image, index) {
  var liObject = $('<li/>');

  var imageObject = $('<img class="image-value" />');
  imageObject.attr('src', image.file.thumb.url);
  imageObject.attr('data-position', index);

  liObject.append(imageObject);

  return liObject;
};

/* load image select */
$(document).ready(function(){
  loadImageSelects();
});

function loadImageSelects() {
  $.each($('.image-select-content'), function(index, element){
    new ImageSelectComponent(element);
  });
}


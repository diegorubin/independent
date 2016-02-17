var GalleryForm = function() {
  var _this = this;
  _this.page = 1;
};

GalleryForm.prototype = new BaseForm();
GalleryForm.prototype.constructor = BaseForm;

GalleryForm.prototype.init = function(form) {
  var _this = this;

  _this.content = {};
  _this.form = $(form);
  _this.photosContainer = _this.form.find('.gallery-content');

  _this.loadAddButton();
  _this.loadDelButton();
  _this.loadNextButton();
  _this.loadPreviousButton();
  _this.loadInsertButton();

  _this.loadSortable();

  _this.setPostionsBeforeSubmit();

  _this.setEditFieldEvent();

};

GalleryForm.prototype.loadSortable = function() {
  $('.gallery-content').sortable({
    forcePlaceholderSize: true,
		placeholderClass: 'gallery-image-container gallery-image-container-ghost'
  });
};

GalleryForm.prototype.loadNextButton = function(){
  var _this = this;
  $(document).on('click', '.dialog-next', function(event){
    event.preventDefault();
    _this.page++;
    _this.getImages();
  });
};

GalleryForm.prototype.loadPreviousButton = function(){
  var _this = this;
  $(document).on('click', '.dialog-previous',  function(event){
    event.preventDefault();
    if(_this.page > 1) {
      _this.page--;
      _this.getImages();
    }
  });
};

GalleryForm.prototype.getInputField = function(type, originalValue, blurEvent) {

    var input; 

    if(type == 'textarea') {
      input = $('<textarea></textarea>');
      input.html(originalValue);
    } else {
      input = $('<input type="text"/>');
      input.val(originalValue);
    }

    input.blur(blurEvent);

    input.dblclick(function(event){
      event.stopPropagation();
    });

    return input;
};

GalleryForm.prototype.setEditFieldEvent = function() {
  var _this = this;

  $('.gallery-content').on('dblclick', '.gallery-edit-field', function(event){
    var elem = $(this);
    var field = elem.data('field');
    var type = elem.data('type');

    var item = $(this).closest('.gallery-image-container');
    var originalValue = item.find('.' + field).val();

    var input = _this.getInputField(type, originalValue,function(event){
      var value = $(this).val();
      item.find('.' + field).val(value);
      elem.html(value);
    });

    elem.html('');
    elem.append(input);
    input.focus();

  });
};

GalleryForm.prototype.loadImageUploader = function() {
  var _this = this;

  var imageUploadArea = _this.form.find('#image-upload-area').get(0);
  _this.fileArea = new FileArea(imageUploadArea);
  _this.fileArea.onLoadFile = function(event, file) {
    _this.onLoadFile(event, file);
  };
  _this.fileArea.init();
};

GalleryForm.prototype.onLoadFile = function(event, file) {
  var _this = this;
  _this.addImageToGallery(event, file);
};

GalleryForm.prototype.addImageToGallery = function(event, file) {
  var _this = this;

  var sendFile = new SendFile('/admin/images.json');
  var attributes = {
    'image[title]': Utils.removeExtension(file.name),
    'image[slug]': Utils.slug(Utils.removeExtension(file.name))
  };

  sendFile.success = function(response) {
    _this.photosContainer.append(_this.createImageItem(event, response.image));
    _this.loadSortable();
  };
  sendFile.send('image[file]', file, attributes);

};

GalleryForm.prototype.createImageItem = function(event, imageData) {
  var _this = this;

  var imageContainer = $($('#gallery-image-template').html());

  var image = imageContainer.find('img');
  image.attr('src', imageData.file.thumb.url);
  image.attr('height', '75');

  var title = imageContainer.find('.gallery-item-title');
  title.html(imageData.title);

  var slug = imageContainer.find('.gallery-item-slug');
  slug.html(imageData.slug);

  var imageMetadata =  imageContainer.find('.gallery-image-metadata');
  imageMetadata.append(_this.createImageItemMetadata(imageData));

  return imageContainer;
};

GalleryForm.prototype.createImageItemMetadata = function(imageData, imageContainer) {
  var index = new Date().getTime();
  var container = $('<div></div>');

  var titleField = $('<input type="hidden"/>');
  titleField.addClass('gallery-item-title');
  titleField.attr('name', '[gallery][items_attributes][' + index + '][title]');
  titleField.attr('value', imageData.title);
  container.append(titleField);

  var slugField = $('<input type="hidden"/>');
  slugField.addClass('gallery-item-slug');
  slugField.attr('name', '[gallery][items_attributes][' + index + '][slug]');
  slugField.attr('value', imageData.slug);
  container.append(slugField);

  var positionField = $('<input type="hidden"/>');
  positionField.addClass('gallery-item-position');
  positionField.attr('name', '[gallery][items_attributes][' + index + '][position]');
  positionField.attr('value', 0);
  container.append(positionField);

  return container;

};

GalleryForm.prototype.loadAddButton = function() {
  var _this = this;

  $(_this.form.find('.gallery-add-button')).on('click', function(event){
    event.preventDefault();

    $('#gallery-dialog').html($(_this.form.find('#gallery-image-modal').html()).clone());

    _this.dialog = $('#gallery-dialog').find('.modal');
    _this.dialog.find('.tabs a').click(function(event){
      event.preventDefault();
      $(this).tab('show');
    });

    _this.getImages();
    _this.dialog.modal('show');

    _this.loadImageUploader();
  });
};

GalleryForm.prototype.loadDelButton = function() {
  $('.gallery-content').on('click', '.gallery-del-button', function(event){
    event.preventDefault();
    $(this).closest('.gallery-image-container').hide();
    $(this).closest('.gallery-image-container').find('.destroy').val(true);
  });
};

GalleryForm.prototype.loadInsertButton = function() {
  var _this = this;

  $('body').on('click', '.image-value',  function(event){
    event.preventDefault();
    var position = $(this).data('position');
    _this.photosContainer.append(_this.createImageItem(event, _this.images[position]));
    _this.loadSortable();
  });

};

GalleryForm.prototype.setPostionsBeforeSubmit = function() {
  var _this = this;
  _this.form.submit(function() {
    _this.setPositions();
  });
};

GalleryForm.prototype.setPositions = function() {
  var _this = this;

  $.each(_this.form.find('.gallery-image-container'), function(index, item){
    $(item).find('.position').val(index);
  });
};

GalleryForm.prototype.getImages = function() {
  var _this = this;

  var data = {};
  data.page = _this.page;

  var client = new RestClient('/admin/images');
  client.success = function(data) {
    _this.loadImages(data);
    $(_this.dialog.find('.dialog-current')).html(_this.page);
  };
  client.call('GET', data);

};

GalleryForm.prototype.loadImages = function(data) {
  var _this = this;

  _this.images = data.result;
  $(_this.dialog.find('.list-images')).html('');
  $.each(_this.images, function(index, image){
    $(_this.dialog.find('.list-images')).append(_this.renderImage(image, index));
  });
};

GalleryForm.prototype.renderImage = function(image, index) {
  var liObject = $('<li/>');

  var imageObject = $('<img class="image-value" />');
  imageObject.attr('src', image.file.thumb.url);
  imageObject.data('position', index);

  liObject.append(imageObject);

  return liObject;
};

//load GalleryForm
loadForm('form#gallery', function(formElem){
  var form = new GalleryForm();
  form.init(formElem);
});


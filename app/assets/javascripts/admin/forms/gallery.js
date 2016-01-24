var GalleryForm = function() {
  var _this = this;
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

GalleryForm.prototype.setEditFieldEvent = function() {
  var _this = this;

  $('.gallery-content').on('dblclick', '.gallery-edit-field', function(event){
    var elem = $(this);
    var field = elem.data('field');

    var item = $(this).closest('.gallery-image-container');
    var originalValue = item.find('.' + field).val();

    var input = $('<input type="text"/>');
    input.val(originalValue);
    input.blur(function(event){
      var value = $(this).val();
      item.find('.' + field).val(value);
      elem.html(value);
    });

    input.dblclick(function(event){
      event.stopPropagation();
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
    _this.photosContainer.append(_this.createImageItem(event, response));
    _this.loadSortable();
  };
  sendFile.send('image[file]', file, attributes);

};

GalleryForm.prototype.createImageItem = function(event, response) {
  var _this = this;

  var imageContainer = $($('#gallery-image-template').html());

  var image = imageContainer.find('img');
  image.attr('src', response.image.file.thumb.url);
  image.attr('height', '75');

  var title = imageContainer.find('.gallery-item-title');
  title.html(response.image.title);

  var slug = imageContainer.find('.gallery-item-slug');
  slug.html(response.image.slug);

  var imageMetadata =  imageContainer.find('.gallery-image-metadata');
  imageMetadata.append(_this.createImageItemMetadata(response));

  return imageContainer;
};

GalleryForm.prototype.createImageItemMetadata = function(response, imageContainer) {
  var index = new Date().getTime();
  var container = $('<div></div>');

  var titleField = $('<input type="hidden"/>');
  titleField.addClass('gallery-item-title');
  titleField.attr('name', '[gallery][items_attributes][' + index + '][title]');
  titleField.attr('value', response.image.title);
  container.append(titleField);

  var slugField = $('<input type="hidden"/>');
  slugField.addClass('gallery-item-slug');
  slugField.attr('name', '[gallery][items_attributes][' + index + '][slug]');
  slugField.attr('value', response.image.slug);
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

//load GalleryForm
loadForm('form#gallery', function(formElem){
  var form = new GalleryForm();
  form.init(formElem);
});


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

  _this.loadSortable();

};

GalleryForm.prototype.loadSortable = function() {
  $('.gallery-content').sortable({
    forcePlaceholderSize: true,
		placeholderClass: 'gallery-image-container gallery-image-container-ghost'
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

  return imageContainer;
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

//load GalleryForm
loadForm('form#gallery', function(formElem){
  var form = new GalleryForm();
  form.init(formElem);
});


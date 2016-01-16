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

};

GalleryForm.prototype.loadImageUploader = function() {
  var _this = this;

  var imageUploadArea = _this.form.find('#image-upload-area').get(0);
  _this.fileArea = new FileArea(imageUploadArea);
  _this.fileArea.onLoadFile = function(f) {
    _this.onLoadFile(f);
  };
  _this.fileArea.init();
};

GalleryForm.prototype.onLoadFile = function(f) {
  var _this = this;
  _this.addImageToGallery(f);
};

GalleryForm.prototype.addImageToGallery = function(f) {
  var _this = this;

  var image = $('<img/>');
  image.addClass('gallery-item');
  image.attr('height', 100);
  image.attr('width', 100);
  image.attr('src', f.target.result);

  _this.photosContainer.append(image);
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


function Gallery(total) {
  var _this = this;

  _this.total = total;
  _this.current = 0;
  _this.showed = 4;
  _this.items = $('.gallery-carousel > li');

  _this.start = function() {

    $('.left-gallery-item').click(function(event){
      if (_this.current > 0) {
        _this.loadItem(--_this.current);
        _this.showPreviousItems();
      }
    });

    $('.right-gallery-item').click(function(event){
      if (_this.current < _this.total - 1) {
        _this.showNextItems();
        _this.loadItem(++_this.current);
      }
    });

    $('.gallery-item').click(function(event){
      _this.loadItem($(this).data('position'));
    });

    $(_this.items[0]).click();
  };

  _this.showNextItems = function() {
    $(_this.items[_this.current]).hide();
  };

  _this.showPreviousItems = function() {
    $(_this.items[_this.current]).show();
  };

  _this.loadItem = function(position) {
    var item = $(_this.items[position]);
    $('#gallery-item-image').attr('src', item.data('slide'));
    $('#gallery-item-title').html(item.data('title'));
    $('#gallery-item-description').html(item.data('description'));
  };

};

$(document).ready(function(){ 
  var wrapper = $('.gallery-carousel-wrapper');

  if(wrapper) {
    var gallery = new Gallery(wrapper.data('total'));
    gallery.start();
  }

});


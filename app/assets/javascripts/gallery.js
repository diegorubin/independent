function Gallery(total) {
  var _this = this;

  _this.total = total;
  _this.current = 0;
  _this.items = $('.gallery-carousel > li');

  _this.start = function() {

    $('.left-gallery-item').click(function(event){
      if (_this.current > 0) {
        _this.loadItem(--_this.current);
      }
    });

    $('.right-gallery-item').click(function(event){
      if (_this.current < _this.total - 1) {
        _this.loadItem(++_this.current);
      }
    });
  };

  _this.loadItem = function(position) {
    var item = $(_this.items[position]);
    console.log(item);
    $('#gallery-item-image').attr('src', item.data('slide'));
    $('#gallery-item-title').html(item.data('title'));
    $('#gallery-item-description').html(item.data('description'));
  };

};

$(document).ready(function(){ 
  var wrapper = $('.gallery-carousel-wrapper');
  console.log(wrapper);

  if(wrapper) {
    var gallery = new Gallery(wrapper.data('total'));
    gallery.start();
  }

});


 //= require_self
function Presentation(slides, lenPresentation, slug) {
  var self = this;

  this.slug = slug;
  this.window = $(window);
  this.loading = $("#slide-loading");
  this.presentation = $("#presentation");
  this.image = $("#presentation-image");
  this.currentPage = $("#current_page");
  this.progressBar = $("#loading-current");

  this.slides = slides;
  this.lenPresentation = lenPresentation;

  this.sPosition = 0;

  this.loadPresentation = function(position) {
    $('<img/>').attr('src', self.slides[position]).load(function() {
      self.progressBar.css("width", 
                          ((position/self.lenPresentation) * 100) + "%");
      if(position < self.lenPresentation)
        self.loadPresentation(position+1);
    });
    
  };
  this.loadPresentation(0);

  this.setSlide = function(position) {

    self.loading.removeClass("hidden");

    $('<img/>').attr('src', self.slides[position]).load(function() {

      if(self.fullscreen)
        self.image.attr("src", self.slides[position]);
      else
        self.presentation.css("background-image", 
          "url(" + self.slides[position] + ")");  

      self.loading.addClass("hidden");
    });
    
    self.currentPage.html(position+1);

  };

  this.prevSlide = function() {
    if(self.sPosition > 0) {
      self.sPosition--;
      self.setSlide(self.sPosition);
    }
  };

  this.nextSlide = function() {
    if(self.sPosition < self.lenPresentation) {
      self.sPosition++;
      self.setSlide(self.sPosition);
    }
  };

  $('.prevSlide').click(function(event) {
    self.prevSlide();
    event.preventDefault();
  });

  $('.nextSlide').click(function(event) {
    self.nextSlide();
    event.preventDefault();
  });

  $('.fullscreen-button').click(function(event) {
    window.open("?fullscreen=on","| Site Pessoal de Diego Rubin", "fullscreen=yes, scrollbars=no");
    
    event.preventDefault();

  });

  $('.prevSlide').hover(
      function() {
        $('#mPrevSlide').addClass("presentation-menu-hover");
      },
      function() {
        $('#mPrevSlide').removeClass("presentation-menu-hover");
      }
  );
  
  $('.nextSlide').hover(
      function() {
        $('#mNextSlide').addClass("presentation-menu-hover");
      },
      function() {
        $('#mNextSlide').removeClass("presentation-menu-hover");
      }
  );

  this.toggleMenuBar = function() {
    self.MenuHidden = !self.MenuHidden;
    $("#pmenu").toggleClass("hidden");
    $("#loading-bar").toggleClass("hidden");

    self.windowResized();
  };

  this.evaluateKey = function(e) {
    var kId = (window.event) ? event.keyCode : e.keyCode;

    switch(kId)
    {
      // Space, right, down or enter
      case 32:
      case 39:
      case 40:
      case 13:
        self.nextSlide();
        break;
      // backspace, up, left
      case 8:
      case 37:
      case 38:
        self.prevSlide();
        break;
      // f
      case 70:
        self.toggleMenuBar();
        break;
      // ESC, q
      case 81:
      case 27:
        window.close();
    }
  };

  this.windowResized = function(event) {
    var newSize = $(document).height();

    if(!self.MenuHidden)
      newSize -= 70;

    self.image.attr('height', newSize);
    self.presentation.css('height', newSize);
  };

  this.onClick = function(event) {
    self.nextSlide();

    event.preventDefault();
  };

  this.setFullscreenMode = function() {
    self.fullscreen = true;

    document.onkeyup = this.evaluateKey;
    document.onclick = this.onClick;
    window.onresize = this.windowResized;

    self.windowResized();
  };

}
 

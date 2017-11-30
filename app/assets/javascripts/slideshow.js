function Slideshow(options){
  this.$slideshowElement = options.slideshowElement;
  this.$allSlides = this.$slideshowElement.children('img');
  this.$currentSlide = this.$allSlides.first();
}

Slideshow.prototype.init = function(){
  this.hideAllSlides();
  this.runSlideshow();
};

Slideshow.prototype.hideAllSlides = function(){
  this.$allSlides.hide();
  console.log(this.$allSlides);
};

Slideshow.prototype.runSlideshow = function(){
  var _this = this;

  if(!this.$currentSlide.length)
    this.$currentSlide = this.$allSlides.first();

  this.$currentSlide.fadeIn(3000, function(){
    $(this).delay(1500).fadeOut(2000, function(){
      _this.$currentSlide = _this.$currentSlide.next('img');
      _this.runSlideshow();
    });
  });
};

$(document).ready(function(){
  var productImagesSlideshowArguments = { slideshowElement : $('.product-images-slideshow'),
                                         },
      productImagesSlideshow = new Slideshow(productImagesSlideshowArguments)

  productImagesSlideshow.init();
});
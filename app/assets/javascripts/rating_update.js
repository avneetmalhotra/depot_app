function AjaxFormResponse(options){
  this.$formElement = options.$formElement;
}

AjaxFormResponse.prototype.init = function(){
  this.handleAjaxResponse();
};

AjaxFormResponse.prototype.handleAjaxResponse = function(){
  this.handleAjaxSuccess();
  this.handleAjaxFailure();
};

AjaxFormResponse.prototype.handleAjaxSuccess = function(){
  _this = this;
  this.$formElement.on("ajax:success", function(event, data){
    alert('Product successfully rated.')
    console.log(data.averageRating)
    _this.updateAverageRating(data);
  });
};

AjaxFormResponse.prototype.updateAverageRating = function(options){
  $(options.averageRatingElementSelector).html(options.averageRating);
};

AjaxFormResponse.prototype.handleAjaxFailure = function(){
  this.$formElement.on('ajax:error', function(){
    alert('There was some error rating the product. Please try again.')
  });
};

AjaxFormResponse.prototype.handleAjaxFailure = function(){

};

$(document).ready(function(){
  var ratingFormArguments = { $formElement : $('.rating-form') },
      ratingFormResponse = new AjaxFormResponse(ratingFormArguments);

  ratingFormResponse.init();
});
var ImageCenter = {
  ic: null,
  ci: null,
  images: null,

  init: function(selector) {
    this.ic = $(selector);
    this.ci = $('#chat_input input');
    this.images = this.ic.find('.images');

    this.listenForInputIdle();
    this.makeImagesSelectable();
  },

  listenForInputIdle: function() {
    var timer = null;
    ImageCenter.ci.keyup(function() {
        if (timer) {
            clearTimeout(timer);
        }
        timer = setTimeout(function() {
          ImageCenter.search(ImageCenter.ci.val());
        }, 1000);
    });
  },

  makeImagesSelectable: function() {

    ImageCenter.images.find('img').click(function() {
      ImageCenter.images.find('img').removeClass('chosen');
      $(this).addClass('chosen');
    });
  },

  selectedImage: function() {
    if(ImageCenter.images.find('img.chosen').length > 0) {
    return ImageCenter.images.find('img.chosen')[0].src;
    }
    return null;
  },

  search: function(query) {
    if(query.length > 4) {

      console.log("Querying for " + query);
      $.getJSON( "/search.json?q=" + query, function( data ) {
        ImageCenter.images.text('');
        $.each( data, function( index, clip_result ) {
          var result = clip_result[0]; 
          ImageCenter.images.append("<img src=" + result.file_path + "/>");
        });
        ImageCenter.makeImagesSelectable();
      });
     
    }
  },

  clear: function() {
    ImageCenter.images.text('');
  },
};

$(function() {
  ImageCenter.init('#image_center');
});

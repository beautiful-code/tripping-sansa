var ImageCenter = {
  ic: null,
  ci: null,

  init: function(selector) {
    this.ic = $(selector);
    this.ci = $('#chat_input input');
    this.listenForInputIdle();
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

  search: function(query) {
    if(query.length > 4) {
      ImageCenter.ic.append(query);
    }
  },
};

$(function() {
  ImageCenter.init('#image_center');
});

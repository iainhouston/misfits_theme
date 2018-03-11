(function($, Drupal) {
  Drupal.behaviors.myModuleBehavior = {
    attach: function(context, settings) {
      $('div.thumbscrubber', context).once('thumbscrubber').each(function() {
        var $slides, $this, numslides, ts_currslide, ts_prevslide, width, x;
        x = void 0;
        ts_prevslide = void 0;
        ts_currslide = void 0;
        $this = $(this);
        width = $(this).innerWidth();
        $slides = $('.ts-inner', this).children();
        numslides = $slides.length;
        console.log(numslides);
      });
    }
  };
})(jQuery, Drupal);

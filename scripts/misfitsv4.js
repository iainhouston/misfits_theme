(function($, Drupal) {
  Drupal.behaviors.misfitsv4Thumbscrubber = {
    attach: function(context, settings) {
      $('.thumbscrubber', context).once('thumbscrubber', function() {
        var $slides, $this, numslides, ts_currslide, ts_prevslide, width, x;
        x = void 0;
        ts_prevslide = void 0;
        ts_currslide = void 0;
        $this = $(this);
        width = $(this).innerWidth();
        $slides = $('.ts-inner', this).children();
        numslides = $slides.length;
        console.log(numslides);
        $('.ts-inner > :first-child').addClass('ts-currslide');
        $this.mousemove(function(event) {
          x = event.pageX - ($this.offset().left);
          ts_currslide = Math.floor(x / (width / numslides)) + 1;
          if (ts_currslide !== ts_prevslide) {
            ts_prevslide = ts_currslide;
            $('.ts-inner > .ts-currslide', this).removeClass('ts-currslide');
            $('.ts-inner > :nth-child(' + ts_currslide + ')', this).addClass('ts-currslide');
          }
          return false;
        });
        $this.mouseleave(function(event) {
          if (ts_currslide !== 1) {
            ts_currslide = 1;
            ts_prevslide = 1;
            $('.ts-inner > .ts-currslide', this).removeClass('ts-currslide');
            $('.ts-inner > :nth-child(' + ts_currslide + ')', this).addClass('ts-currslide');
          }
          return false;
        });
      });
    }
  };
})(jQuery, Drupal);

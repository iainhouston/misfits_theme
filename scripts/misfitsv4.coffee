(($, Drupal) ->
  Drupal.behaviors.misfitsv4ThumScrubber = attach: (context, settings) ->
    $('div.thumbscrubber', context).once('init').each ->
      x = undefined
      ts_prevslide = undefined
      ts_currslide = undefined
      $this = $(this)
      $this.addClass 'thumbs-init'
      width = $(this).innerWidth()
      $slides = $('.ts-inner', this).children()
      numslides = $slides.length
      console.log numslides
      # Make the first photo opaque
      $('.ts-inner > :first-child').addClass 'ts-currslide'
      # listen for mousemove
      $this.mousemove (event) ->
        x = event.pageX - ($this.offset().left)
        ts_currslide = Math.floor(x / (width / numslides)) + 1
        # don't add/remove class if mouse inside current slide threshold
        if ts_currslide != ts_prevslide
          ts_prevslide = ts_currslide
          $('.ts-inner > .ts-currslide', this).removeClass 'ts-currslide'
          $('.ts-inner > :nth-child(' + ts_currslide + ')', this).addClass 'ts-currslide'
        false
      # mousemove
      # on mouseleave, reset back to first slide
      $this.mouseleave (event) ->
        if ts_currslide != 1
          ts_currslide = 1
          ts_prevslide = 1
          $('.ts-inner > .ts-currslide', this).removeClass 'ts-currslide'
          $('.ts-inner > :nth-child(' + ts_currslide + ')', this).addClass 'ts-currslide'
        false
        # mouseleave      
      return
    return
  return
) jQuery, Drupal

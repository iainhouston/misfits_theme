(($, Drupal) ->
  Drupal.behaviors.myModuleBehavior = attach: (context, settings) ->
    $('div.thumbscrubber', context).once('thumbscrubber').each ->
      x = undefined
      ts_prevslide = undefined
      ts_currslide = undefined
      $this = $(this)
      width = $(this).innerWidth()
      $slides = $('.ts-inner', this).children()
      numslides = $slides.length
      console.log numslides
      return
    return
  return
) jQuery, Drupal

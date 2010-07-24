TEDxPerth.withNS 'HomePage', (ns) ->

  ns.sliderSelector: '#homepage-slider'

  ns.setupSlider: ->
    $(ns.sliderSelector).nivoSlider({
      controlNav: false
      directionNav: false
    })

  ns.setup: ->
    ns.setupSlider()
TEDxPerth.withNS 'HomePage', (ns) ->

  ns.currentIndex = 0
  ns.advanceTime  = 4000 # 4 seconds

  ns.setupSlider = ->
    $(ns.sliderSelector).nivoSlider(
      controlNav: false
      directionNav: false
    )
    
  ns.updateMarker = ->
    ns.markers.removeClass('active').filter(":eq($ns.currentIndex)").addClass 'active'
    
  ns.advanceImage = ->
    ns.goToImage((ns.currentIndex + 1) % ns.imageCount)
  
  ns.goToImage = (imageIndex) ->
    ns.stopAdvancing()
    if imageIndex == ns.currentIndex
      ns.startAdvancing()
    else
      from = ns.images.filter ":eq($ns.currentIndex)"
      to = ns.images.filter ":eq($imageIndex)"
      from.fadeOut("slow")
      to.fadeIn("slow", ->
        ns.currentIndex = imageIndex
        ns.updateMarker()
        ns.startAdvancing() if ns.interval?
      )
  
  ns.startAdvancing = () ->
    ns.interval = setTimeout ns.advanceImage, ns.advanceTime
    
  ns.stopAdvancing = () ->
    if ns.interval?
      clearTimeout ns.interval
      delete ns.interval
    

  ns.setup = ->
    ns.images = $ "#banner-items li.banner-item"
    ns.images.hover ns.stopAdvancing, ns.startAdvancing
    ns.markers = $ "#banner-items li.navigate-banner-items a.banner-item-nav"
    ns.markers.each (idx) ->
      $(this).click ->
        ns.goToImage idx
        return false
    ns.imageCount = ns.images.size()
    ns.startAdvancing()
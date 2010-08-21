TEDxPerth.withNS 'TEDVideo', (ns) ->

  ns.videos = []
  
  class ns.InnerVideo
    
    constructor: (parent) ->
      @parent = parent
  
  ns.loadVideosFromHTML = ->
    $("#event-videos li.event-video").each ->
      $this = $ this
      video = new ns.InnerVideo $this
      ns.videos.push video
      $this.find("a.show-video").show().click ->
        ns.playVideo video unless ns.currentVideoIs video
        return false
      $this.find("a.hide-video").click ->
        ns.hideVideo video if ns.currentVideoIs video
        return false
  
  ns.currentVideoIs = (video) ->
    ns.lastVideo? && ns.lastVideo is video
  
  ns.hideVideo = (video, callback) ->
    if video?
      video.parent.find("a.hide-video").hide()
      video.parent.find("a.show-video").show()
      video.parent.find(".video-embed").slideUp(callback)
      delete ns.lastVideo if ns.currentVideoIs video
  
  ns.playVideo = (video) ->
    cb = ->
      video.parent.find(".video-embed").slideDown()
      video.parent.find("a.hide-video").show()
      video.parent.find("a.show-video").hide()
    if ns.lastVideo?
      ns.hideVideo ns.lastVideo, cb
    else
      cb()
    ns.lastVideo = video
  
  ns.setup = -> ns.loadVideosFromHTML()
      
      
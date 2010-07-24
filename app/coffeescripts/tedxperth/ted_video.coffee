TEDxPerth.withNS 'TEDVideo', (ns) ->

  ns.videos: []

  class ns.VideoInstance
    constructor: (id, raw) ->
      @raw: raw
      @id:  id
      
    toEmbedCode: ->
      if Modernizr.video.h264
        @raw.html5
      else
        @raw.html
    
    title:       -> @raw.title
    thumbnail:   -> @raw.thumnail_url
    url:         -> @raw.url
    description: -> @raw.description
  
  ns.add: (id, raw) ->
    ns.videos.push new ns.VideoInstance(id, raw)
  
  ns.eachVideo: (callback) ->
    for video in ns.videos
      callback video
      
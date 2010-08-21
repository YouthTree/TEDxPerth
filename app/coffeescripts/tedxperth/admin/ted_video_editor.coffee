TEDxPerth.withNS 'Admin.TEDVideoEditor', (ns) ->
  
  ns.fieldsetSelector = '.video-input'
  ns.removeSelector =   'a.remove-video-link'
  ns.addSelector =      'a.add-video-link'
  ns.template =         ''
  
  ns.attachEvents = ->
    $(ns.addSelector).click ->
      ns.addVideo()
      false
    $(ns.fieldsetSelector).each -> ns.attachEventOn $(this)
    
  ns.attachEventOn = (fs) ->
    fs.find(ns.removeSelector).click ->
      ns.deleteVideo @
      false
  
  ns.addVideo = ->
    inner = ns.template.replace /VIDEO_IDX/g, Number(new Date())
    $("#{ns.fieldsetSelector}:last").after inner
    ns.attachEventOn $("#{ns.fieldsetSelector}:last")
  
  ns.deleteVideo = (link) ->
    link = $ link
    link.parents(ns.fieldsetSelector).find("input[type=hidden]").val('1').end().hide()
  
  ns.setup = -> ns.attachEvents()
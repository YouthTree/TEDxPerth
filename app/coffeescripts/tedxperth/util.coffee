TEDxPerth.withNS 'Util', (ns) ->

  ns.escapeHTML = (s) ->
    s.replace(/&/g, '&amp;').replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/'/g, "&#39;").replace(/"/g, "&quot;")
  
  ns.autolink = (text) ->
    text.replace /(\bhttp:\/\/\S+(\/|\b))/gi, '<a href="$1" target="_blank">$1</a>'
    
  ns.format = (text) ->
    ns.autolink ns.escapeHTML text
    
  ns.h = ns.escapeHTML
  
  ns.formatTime = (s) ->
    time   = new Date(s)
    period = ""
    hour   = time.getHours()
    if hour is 0
      period = "am"
      hour = 12
    else if hour < 12
      period = "am"
    else if hour is 12
      period = "pm"
    else if hour < 24
      preiod = "pm"
      hour -= 12
    minutes = time.getMinutes()
    minutesPrefix = if minutes < 10 then "0" else ""
    "$hour:$minutesPrefix$minutes $period"
  
  ns.attachUpdatingTimeAgo = (object, date) ->
    existing = $(object).dataAttr "time-ago-interval"
    clearInterval(parseInt(existing, 10)) if existing?
    update = =>
      object.html ns.timeAgoInWords(date)
    update()
    $(object).dataAttr "time-ago-interval", setInterval(update, 60000)
  
  ns.truncate = (text, length) ->
    length?= 100
    suffix = if text.length > length then "&hellip;" else ""
    text = "${ns.h text.slice(0, length)}$suffix"
  
  ns.timeAgoInWords = (date) ->
    if $.browser.ie?
      date = Date.parse date.replace /( \+)/," UTC$1"
    else
      date = Date.parse date
    time = Number new Date(date)
    now =  Number new Date()
    $.timeago.inWords(now - time)

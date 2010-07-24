TEDxPerth.withNS 'Twitter', (ns) ->

  ns.withNS 'Util', (utilNS) ->
    
    utilNS.highlightUsers: (t) ->
      t.replace /(^|\s)@([_a-z0-9]+)/gi, '$1@<a href="http://twitter.com/$2" target="_blank">$2</a>'
    
    utilNS.highlightTags: (t) ->
      t.replace /(^|\s)#(\S+(\/|\b))/gi, '$1<a href="http://twitter.com/search?q=%23$2" target="_blank">#$2</a>'
    
    utilNS.twitterize: (t) ->
      utilNS.highlightTags utilNS.highlightUsers TEDxPerth.Util.autolink t

  ns.processTweets: (tweets) ->
    ns.debug tweets
    ns.container.empty()
    for tweet in tweets
      ns.showTweet tweet
      
      
  ns.showTweet: (tweet) ->
    ns.debug tweet
    formattedText: ns.Util.twitterize tweet.text
    ns.container.append $("<li />").html(formattedText)
    

  ns.currentUser: -> $.metaAttr "twitter-user"

  ns.urlFor: (user) ->
    "http://api.twitter.com/1/statuses/user_timeline/${user}.json?callback=TEDxPerth.Twitter.processTweets&count=4"
  
  ns.load: ->
    user: ns.currentUser()
    $.getScript ns.urlFor(user) if user?
    
  ns.setup: ->
    ns.container: $ "#tweets-listing"
    ns.load()
    # Set it to update every 5 minutes.
    setInterval (=> ns.load()), 300000

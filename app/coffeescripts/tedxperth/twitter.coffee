TEDxPerth.withNS 'Twitter', (ns) ->

  ns.anywhereInstance = null

  ns.withNS 'Util', (utilNS) ->
    
    utilNS.highlightTags = (t) ->
      t.replace /(^|\s)#(\S+(\/|\b))/gi, '$1<a href="http://twitter.com/search?q=%23$2" target="_blank">#$2</a>'
    
    utilNS.twitterize = (t) ->
      utilNS.highlightTags TEDxPerth.Util.autolink t

  ns.processTweets = (tweets) ->
    ns.container.empty()
    ns.showHomepageTweet tweets[0]
    for tweet in tweets
      ns.showTweet tweet
    $.jStorage.set 'tweets-cache', tweets
      
      
  ns.showHomepageTweet = (tweet) ->
    if tweet?
      $("#homepage-twitter-feed #recent-tweet").html ns.Util.twitterize(tweet.text)
      ns.anywhere (T) -> T("#homepage-twitter-feed #recent-tweet").hovercards()
      $("#homepage-twitter-feed").show()
      
  ns.showTweet = (tweet) ->
    tweetID = "anywhere-tweet-#{tweet.id}"
    ns.container.append $("<li />", id: tweetID).html(ns.Util.twitterize(tweet.text))
    ns.anywhere (T) -> T("##{tweetID}").hovercards()
    

  ns.anywhere = (cb) ->
    if ns.anywhereInstance?
      cb ns.anywhereInstance
    else if twttr?
      twttr.anywhere (T) ->
        ns.anywhereInstance = T
        cb T

  ns.currentUser = -> $.metaAttr "twitter-user"

  ns.urlFor = (user) ->
    "http://api.twitter.com/1/statuses/user_timeline/#{user}.json?callback=TEDxPerth.Twitter.processTweets&count=4"
  
  ns.showFollowButton = () ->
    cu = ns.currentUser()
    if cu?
      ns.anywhere (T) -> T("#follow-on-twitter").followButton cu
  
  ns.load = ->
    user = ns.currentUser()
    $.getScript ns.urlFor(user) if user?
    
  ns.setup = ->
    ns.showFollowButton()
    ns.container = $ "#tweets-listing"
    existing = $.jStorage.get 'tweets-cache'
    ns.processTweets existing if existing?
    ns.load()
    # Set it to update every 5 minutes.
    setInterval (=> ns.load()), 300000

var __bind = function(func, context) {
    return function(){ return func.apply(context, arguments); };
  };
TEDxPerth.withNS('Twitter', function(ns) {
  ns.withNS('Util', function(utilNS) {
    ns.anywhereInstance = null;
    utilNS.highlightUsers = function(t) {
      return t.replace(/(^|\s)@([_a-z0-9]+)/gi, '$1@<a href="http://twitter.com/$2" target="_blank">$2</a>');
    };
    utilNS.highlightTags = function(t) {
      return t.replace(/(^|\s)#(\S+(\/|\b))/gi, '$1<a href="http://twitter.com/search?q=%23$2" target="_blank">#$2</a>');
    };
    return (utilNS.twitterize = function(t) {
      return utilNS.highlightTags(utilNS.highlightUsers(TEDxPerth.Util.autolink(t)));
    });
  });
  ns.processTweets = function(tweets) {
    var _a, _b, _c, tweet;
    ns.container.empty();
    ns.showHomepageTweet(tweets[0]);
    _b = tweets;
    for (_a = 0, _c = _b.length; _a < _c; _a++) {
      tweet = _b[_a];
      ns.showTweet(tweet);
    }
    return $.jStorage.set('tweets-cache', tweets);
  };
  ns.showHomepageTweet = function(tweet) {
    if ((typeof tweet !== "undefined" && tweet !== null)) {
      $("#homepage-twitter-feed #recent-tweet").text(tweet.text);
      ns.anywhere(function(T) {
        return T("#homepage-twitter-feed #recent-tweet").hovercards();
      });
      return $("#homepage-twitter-feed").show();
    }
  };
  ns.showTweet = function(tweet) {
    var tweetID;
    tweetID = ("anywhere-tweet-" + (tweet.id));
    ns.container.append($("<li />", {
      id: tweetID
    }).text(tweet.text));
    return ns.anywhere(function(T) {
      return T(("#" + (tweetID))).hovercards();
    });
  };
  ns.anywhere = function(cb) {
    var _a;
    if ((typeof (_a = ns.anywhereInstance) !== "undefined" && _a !== null)) {
      return cb(ns.anywhereInstance);
    } else if ((typeof twttr !== "undefined" && twttr !== null)) {
      return twttr.anywhere(function(T) {
        ns.anywhereInstance = T;
        return cb(T);
      });
    }
  };
  ns.currentUser = function() {
    return $.metaAttr("twitter-user");
  };
  ns.urlFor = function(user) {
    return "http://api.twitter.com/1/statuses/user_timeline/" + (user) + ".json?callback=TEDxPerth.Twitter.processTweets&count=4";
  };
  ns.showFollowButton = function() {
    var cu;
    cu = ns.currentUser();
    return (typeof cu !== "undefined" && cu !== null) ? ns.anywhere(function(T) {
      return T("#follow-on-twitter").followButton(cu);
    }) : null;
  };
  ns.load = function() {
    var user;
    user = ns.currentUser();
    if ((typeof user !== "undefined" && user !== null)) {
      return $.getScript(ns.urlFor(user));
    }
  };
  return (ns.setup = function() {
    var existing;
    ns.showFollowButton();
    ns.container = $("#tweets-listing");
    existing = $.jStorage.get('tweets-cache');
    if ((typeof existing !== "undefined" && existing !== null)) {
      ns.processTweets(existing);
    }
    ns.load();
    return setInterval((__bind(function() {
      return ns.load();
    }, this)), 300000);
  });
});
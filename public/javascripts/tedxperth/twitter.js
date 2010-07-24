TEDxPerth.withNS('Twitter', function(ns) {
  ns.withNS('Util', function(utilNS) {
    utilNS.highlightUsers = function(t) {
      return t.replace(/(^|\s)@([_a-z0-9]+)/gi, '$1@<a href="http://twitter.com/$2" target="_blank">$2</a>');
    };
    utilNS.highlightTags = function(t) {
      return t.replace(/(^|\s)#(\S+(\/|\b))/gi, '$1<a href="http://twitter.com/search?q=%23$2" target="_blank">#$2</a>');
    };
    utilNS.twitterize = function(t) {
      return utilNS.highlightTags(utilNS.highlightUsers(TEDxPerth.Util.autolink(t)));
    };
    return utilNS.twitterize;
  });
  ns.processTweets = function(tweets) {
    var _a, _b, _c, tweet;
    ns.container.empty();
    _b = tweets;
    for (_a = 0, _c = _b.length; _a < _c; _a++) {
      tweet = _b[_a];
      ns.showTweet(tweet);
    }
    return $.jStorage.set('tweets-cache', tweets);
  };
  ns.showTweet = function(tweet) {
    var formattedText;
    formattedText = ns.Util.twitterize(tweet.text);
    return ns.container.append($("<li />").html(formattedText));
  };
  ns.currentUser = function() {
    return $.metaAttr("twitter-user");
  };
  ns.urlFor = function(user) {
    return "http://api.twitter.com/1/statuses/user_timeline/" + (user) + ".json?callback=TEDxPerth.Twitter.processTweets&count=4";
  };
  ns.load = function() {
    var user;
    user = ns.currentUser();
    if (typeof user !== "undefined" && user !== null) {
      return $.getScript(ns.urlFor(user));
    }
  };
  ns.setup = function() {
    var existing;
    ns.container = $("#tweets-listing");
    existing = $.jStorage.get('tweets-cache');
    if (typeof existing !== "undefined" && existing !== null) {
      ns.processTweets(existing);
    }
    ns.load();
    return setInterval(((function(__this) {
      var __func = function() {
        return ns.load();
      };
      return (function() {
        return __func.apply(__this, arguments);
      });
    })(this)), 300000);
  };
  return ns.setup;
});
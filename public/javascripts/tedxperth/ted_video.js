TEDxPerth.withNS('TEDVideo', function(ns) {
  ns.videos = [];
  ns.InnerVideo = function(parent) {
    this.parent = parent;
    return this;
  };
  ns.loadVideosFromHTML = function() {
    return $("#event-videos li.event-video").each(function() {
      var $this, video;
      $this = $(this);
      video = new ns.InnerVideo($this);
      ns.videos.push(video);
      $this.find("a.show-video").show().click(function() {
        if (!(ns.currentVideoIs(video))) {
          ns.playVideo(video);
        }
        return false;
      });
      return $this.find("a.hide-video").click(function() {
        if (ns.currentVideoIs(video)) {
          ns.hideVideo(video);
        }
        return false;
      });
    });
  };
  ns.currentVideoIs = function(video) {
    var _a;
    return (typeof (_a = ns.lastVideo) !== "undefined" && _a !== null) && ns.lastVideo === video;
  };
  ns.hideVideo = function(video, callback) {
    if ((typeof video !== "undefined" && video !== null)) {
      video.parent.find("a.hide-video").hide();
      video.parent.find("a.show-video").show();
      video.parent.find(".video-embed").slideUp(callback);
      if (ns.currentVideoIs(video)) {
        return delete ns.lastVideo;
      }
    }
  };
  ns.playVideo = function(video) {
    var _a, cb;
    cb = function() {
      video.parent.find(".video-embed").slideDown();
      video.parent.find("a.hide-video").show();
      return video.parent.find("a.show-video").hide();
    };
    if ((typeof (_a = ns.lastVideo) !== "undefined" && _a !== null)) {
      ns.hideVideo(ns.lastVideo, cb);
    } else {
      cb();
    };
    return (ns.lastVideo = video);
  };
  return (ns.setup = function() {
    return ns.loadVideosFromHTML();
  });
});
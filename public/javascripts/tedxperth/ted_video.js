TEDxPerth.withNS('TEDVideo', function(ns) {
  ns.videos = [];
  ns.VideoInstance = function(id, raw) {
    this.raw = raw;
    this.id = id;
    return this;
  };
  ns.VideoInstance.prototype.toEmbedCode = function() {
    return Modernizr.video.h264 ? this.raw.html5 : this.raw.html;
  };
  ns.VideoInstance.prototype.title = function() {
    return this.raw.title;
  };
  ns.VideoInstance.prototype.thumbnail = function() {
    return this.raw.thumnail_url;
  };
  ns.VideoInstance.prototype.url = function() {
    return this.raw.url;
  };
  ns.VideoInstance.prototype.description = function() {
    return this.raw.description;
  };

  ns.add = function(id, raw) {
    return ns.videos.push(new ns.VideoInstance(id, raw));
  };
  ns.eachVideo = function(callback) {
    var _a, _b, _c, _d, video;
    _a = []; _c = ns.videos;
    for (_b = 0, _d = _c.length; _b < _d; _b++) {
      video = _c[_b];
      _a.push(callback(video));
    }
    return _a;
  };
  return ns.eachVideo;
});
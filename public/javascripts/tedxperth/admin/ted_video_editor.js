TEDxPerth.withNS('Admin.TEDVideoEditor', function(ns) {
  ns.fieldsetSelector = '.video-input';
  ns.removeSelector = 'a.remove-video-link';
  ns.addSelector = 'a.add-video-link';
  ns.template = '';
  ns.attachEvents = function() {
    $(ns.addSelector).click(function() {
      ns.addVideo();
      return false;
    });
    return $(ns.fieldsetSelector).each(function() {
      return ns.attachEventOn($(this));
    });
  };
  ns.attachEventOn = function(fs) {
    return fs.find(ns.removeSelector).click(function() {
      ns.deleteVideo(this);
      return false;
    });
  };
  ns.addVideo = function() {
    var inner;
    inner = ns.template.replace(/VIDEO_IDX/g, Number(new Date()));
    $(("" + (ns.fieldsetSelector) + ":last")).after(inner);
    return ns.attachEventOn($(("" + (ns.fieldsetSelector) + ":last")));
  };
  ns.deleteVideo = function(link) {
    link = $(link);
    return link.parents(ns.fieldsetSelector).find("input[type=hidden]").val('1').end().hide();
  };
  return (ns.setup = function() {
    return ns.attachEvents();
  });
});
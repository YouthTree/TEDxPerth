TEDxPerth.withNS('HomePage', function(ns) {
  ns.currentIndex = 0;
  ns.advanceTime = 4000;
  ns.setupSlider = function() {
    return $(ns.sliderSelector).nivoSlider({
      controlNav: false,
      directionNav: false
    });
  };
  ns.updateMarker = function() {
    return ns.markers.removeClass('active').filter(":eq($ns.currentIndex)").addClass('active');
  };
  ns.advanceImage = function() {
    return ns.goToImage((ns.currentIndex + 1) % ns.imageCount);
  };
  ns.goToImage = function(imageIndex) {
    var from, to;
    ns.stopAdvancing();
    if (imageIndex === ns.currentIndex) {
      return ns.startAdvancing();
    } else {
      from = ns.images.filter(":eq($ns.currentIndex)");
      to = ns.images.filter(":eq($imageIndex)");
      from.fadeOut("slow");
      return to.fadeIn("slow", function() {
        var _a;
        ns.currentIndex = imageIndex;
        ns.updateMarker();
        if ((typeof (_a = ns.interval) !== "undefined" && _a !== null)) {
          return ns.startAdvancing();
        }
      });
    }
  };
  ns.startAdvancing = function() {
    return (ns.interval = setTimeout(ns.advanceImage, ns.advanceTime));
  };
  ns.stopAdvancing = function() {
    var _a;
    if ((typeof (_a = ns.interval) !== "undefined" && _a !== null)) {
      clearTimeout(ns.interval);
      return delete ns.interval;
    }
  };
  return (ns.setup = function() {
    ns.images = $("#banner-items li.banner-item");
    ns.images.hover(ns.stopAdvancing, ns.startAdvancing);
    ns.markers = $("#banner-items li.navigate-banner-items a.banner-item-nav");
    ns.markers.each(function(idx) {
      return $(this).click(function() {
        ns.goToImage(idx);
        return false;
      });
    });
    ns.imageCount = ns.images.size();
    return ns.startAdvancing();
  });
});
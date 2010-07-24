TEDxPerth.withNS('HomePage', function(ns) {
  ns.sliderSelector = '#homepage-slider';
  ns.setupSlider = function() {
    return $(ns.sliderSelector).nivoSlider({
      controlNav: false,
      directionNav: false
    });
  };
  ns.setup = function() {
    return ns.setupSlider();
  };
  return ns.setup;
});
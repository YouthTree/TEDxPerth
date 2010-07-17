TEDxPerth.withNS('Timestamps', function(ns) {
  ns.setup = function() {
    return $("abbr.timestamp").timeago();
  };
  return ns.setup;
});
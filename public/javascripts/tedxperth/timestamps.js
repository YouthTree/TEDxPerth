TEDxPerth.withNS('Timestamps', function(ns) {
  return (ns.setup = function() {
    return $("abbr.timestamp").timeago();
  });
});
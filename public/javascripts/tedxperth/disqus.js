TEDxPerth.withNS('Disqus', function(ns) {
  ns.currentIdentifier = function() {
    return $.metaAttr("disqus-identifier");
  };
  ns.currentSite = function() {
    return $.metaAttr("disqus-site");
  };
  ns.isDebug = function() {
    return $.metaAttr("disqus-developer") === "true";
  };
  ns.configureDisqus = function() {
    window.disqus_identifier = ns.currentIdentifier();
    if (ns.isDebug()) {
      return (window.disqus_developer = 1);
    }
  };
  ns.addScripts = function() {
    var script;
    ns.configureDisqus();
    script = $("<script />", {
      type: "text/javascript",
      async: true
    });
    if ($("#posts").size() > 0) {
      script.attr("src", ("http://disqus.com/forums/" + (ns.currentSite()) + "/count.js"));
    } else {
      script.attr("src", ("http://" + (ns.currentSite()) + ".disqus.com/embed.js"));
    };
    return script.appendTo($("head"));
  };
  return (ns.setup = function() {
    return ns.addScripts();
  });
});
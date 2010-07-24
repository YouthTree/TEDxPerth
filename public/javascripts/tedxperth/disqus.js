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
      window.disqus_developer = 1;
      return window.disqus_developer;
    }
  };
  ns.addScripts = function() {
    var script;
    ns.configureDisqus();
    script = $("<script />", {
      type: "text/javascript",
      async: true
    });
    $("#posts").size() > 0 ? script.attr("src", ("http://disqus.com/forums/" + (ns.currentSite()) + "/count.js")) : script.attr("src", ("http://" + (ns.currentSite()) + ".disqus.com/embed.js"));
    return script.appendTo($("head"));
  };
  ns.setup = function() {
    return ns.addScripts();
  };
  return ns.setup;
});
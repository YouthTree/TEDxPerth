var __bind = function(func, context) {
    return function(){ return func.apply(context, arguments); };
  };
TEDxPerth.withNS('Util', function(ns) {
  ns.escapeHTML = function(s) {
    return s.replace(/&/g, '&amp;').replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/'/g, "&#39;").replace(/"/g, "&quot;");
  };
  ns.autolink = function(text) {
    return text.replace(/(\bhttp:\/\/\S+(\/|\b))/gi, '<a href="$1" target="_blank">$1</a>');
  };
  ns.format = function(text) {
    return ns.autolink(ns.escapeHTML(text));
  };
  ns.h = ns.escapeHTML;
  ns.formatTime = function(s) {
    var hour, minutes, minutesPrefix, period, preiod, time;
    time = new Date(s);
    period = "";
    hour = time.getHours();
    if (hour === 0) {
      period = "am";
      hour = 12;
    } else if (hour < 12) {
      period = "am";
    } else if (hour === 12) {
      period = "pm";
    } else if (hour < 24) {
      preiod = "pm";
      hour -= 12;
    }
    minutes = time.getMinutes();
    minutesPrefix = minutes < 10 ? "0" : "";
    return "$hour:$minutesPrefix$minutes $period";
  };
  ns.attachUpdatingTimeAgo = function(object, date) {
    var existing, update;
    existing = $(object).dataAttr("time-ago-interval");
    if ((typeof existing !== "undefined" && existing !== null)) {
      clearInterval(parseInt(existing, 10));
    }
    update = __bind(function() {
      return object.html(ns.timeAgoInWords(date));
    }, this);
    update();
    return $(object).dataAttr("time-ago-interval", setInterval(update, 60000));
  };
  ns.truncate = function(text, length) {
    var suffix;
    length = (typeof length !== "undefined" && length !== null) ? length : 100;
    suffix = text.length > length ? "&hellip;" : "";
    return (text = "${ns.h text.slice(0, length)}$suffix");
  };
  return (ns.timeAgoInWords = function(date) {
    var _a, now, time;
    if ((typeof (_a = $.browser.ie) !== "undefined" && _a !== null)) {
      date = Date.parse(date.replace(/( \+)/, " UTC$1"));
    } else {
      date = Date.parse(date);
    };
    time = Number(new Date(date));
    now = Number(new Date());
    return $.timeago.inWords(now - time);
  });
});
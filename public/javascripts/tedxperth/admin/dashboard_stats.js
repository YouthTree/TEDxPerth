TEDxPerth.withNS('Admin.DashboardStats', function(ns) {
  ns.withContainer = function(container_id, callback) {
    var data, labels, values;
    labels = [];
    values = [];
    data = $(("#" + (container_id) + " dl"));
    data.find("dt").each(function() {
      var current;
      current = $(this);
      labels.push(current.text());
      return values.push(current.next('dd').text());
    });
    if (typeof callback === "function" && labels.length > 0) {
      return callback(labels, values);
    }
  };
  ns.showUserSignups = function() {
    return ns.withContainer('signups-chart', function(labels, values) {
      return TEDxPerth.Admin.ColumnChart.create('signups-chart', function() {
        this.setTitle('Signups Per Day');
        this.setCategories(labels);
        this.setSideTitle('Signups per Day');
        this.addSeries('Signups', $.map(values, Number));
        return this.setDataToolTip(function() {
          return "" + (this.y) + " " + (this.series.name.toLowerCase()) + "<br/>on " + (this.x) + ".";
        });
      });
    });
  };
  return (ns.setup = function() {
    return ns.showUserSignups();
  });
});
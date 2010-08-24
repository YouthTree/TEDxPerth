TEDxPerth.withNS('Admin.ColumnChart', function(ns) {
  var InnerChart;
  InnerChart = function(_a) {
    this.id = _a;
    this.buildInitialOptions();
    return this;
  };
  InnerChart.prototype.buildInitialOptions = function() {
    return (this.options = {
      chart: {
        renderTo: this.id,
        defaultSeriesType: 'column'
      },
      xAxis: {
        categories: []
      },
      yAxis: {
        min: 0
      },
      legend: {
        enabled: true
      },
      series: []
    });
  };
  InnerChart.prototype.setSideTitle = function(title) {
    return (this.options.yAxis.title = {
      text: title
    });
  };
  InnerChart.prototype.setCategories = function(c) {
    return (this.options.xAxis.categories = c);
  };
  InnerChart.prototype.setTitle = function(t) {
    return (this.options.title = {
      text: t
    });
  };
  InnerChart.prototype.setDataToolTip = function(tooltip) {
    return (this.options.tooltip = {
      formatter: tooltip
    });
  };
  InnerChart.prototype.addSeries = function(name, data) {
    return this.options.series.push({
      name: name,
      data: data
    });
  };
  InnerChart.prototype.draw = function() {
    $(("#" + (this.id))).empty().show();
    return new Highcharts.Chart(this.options);
  };
  return (ns.create = function(id, cb) {
    var chart;
    chart = new InnerChart(id);
    if (typeof cb === "function") {
      cb.apply(chart);
    }
    chart.draw();
    return chart;
  });
});
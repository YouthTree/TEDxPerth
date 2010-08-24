TEDxPerth.withNS 'Admin.ColumnChart', (ns) ->
  
  class InnerChart
    
    constructor: (@id) ->
      @buildInitialOptions()
      
    buildInitialOptions: ->
      @options =
        chart:
          renderTo: @id
          defaultSeriesType: 'column'
        xAxis:
          categories: []
        yAxis:
          min: 0
        legend:
          enabled: true
        series: []
      
    setSideTitle: (title) ->
      @options.yAxis.title = {text: title}
      
    setCategories: (c) ->
      @options.xAxis.categories = c
    
    setTitle: (t) ->
      @options.title = {text: t}
      
    setDataToolTip: (tooltip) ->
      @options.tooltip = {formatter: tooltip}
      
    addSeries: (name, data) ->
      @options.series.push({
        name: name
        data: data
      })
    
    draw: ->
      $("##{@id}").empty().show()
      new Highcharts.Chart @options
  
  ns.create = (id, cb) ->
    chart = new InnerChart id
    cb.apply chart if typeof cb is "function"
    chart.draw()
    chart
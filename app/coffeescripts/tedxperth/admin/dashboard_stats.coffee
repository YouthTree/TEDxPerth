TEDxPerth.withNS 'Admin.DashboardStats', (ns) ->
  
  ns.withContainer = (container_id, callback) ->
    labels = []
    values = []
    data = $("##{container_id} dl")
    data.find("dt").each ->
      current = $ @
      labels.push current.text()
      values.push current.next('dd').text()
    callback labels, values if typeof callback is "function" and labels.length > 0
    
  
  ns.showUserSignups = ->
    ns.withContainer 'signups-chart', (labels, values) ->
      TEDxPerth.Admin.ColumnChart.create 'signups-chart', ->
        @setTitle      'Signups Per Day'
        @setCategories labels
        @setSideTitle  'Signups per Day'
        @addSeries     'Signups', $.map(values, Number)
        @setDataToolTip -> "#{@y} #{@series.name.toLowerCase()}<br/>on #{@x}."
      
  ns.setup = ->
    ns.showUserSignups()
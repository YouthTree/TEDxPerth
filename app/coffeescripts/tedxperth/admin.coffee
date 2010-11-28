TEDxPerth.withNS 'Admin', (ns) ->

  ns.setupDatePickers = ->
    $(document).ready ->
      if $.fn.datepicker?
        $('input.ui-date-picker').datepicker()
      if $.fn.datetimepicker?
        $('input.ui-datetime-picker').datetimepicker
          ampm:       true,
          timeFormat: 'hh:mm TT'
          dateFormat: 'dd MM yy'
          
      

  ns.setup = -> ns.setupDatePickers()
TEDxPerth.withNS 'Admin', (ns) ->

  ns.cloneValue = (from, to) ->
    to.val from.val() if from.length and to.length
    
  ns.setupValueCloner = ->
    $('a.clone-form-value').each ->
      current = $ this
      from_selector = current.dataAttr 'clone-from'
      to_selector = current.dataAttr 'clone-to'
      current.click ->
        if from_selector? and to_selector?
          ns.cloneValue $(from_selector), $(to_selector)
        false

  ns.setupDatePickers = ->
    $(document).ready ->
      ns.setupValueCloner()
      if $.fn.datepicker?
        $('input.ui-date-picker').datepicker()
      if $.fn.datetimepicker?
        $('input.ui-datetime-picker').datetimepicker
          ampm:       true,
          timeFormat: 'hh:mm TT'
          dateFormat: 'dd MM yy'
          
      

  ns.setup = -> ns.setupDatePickers()
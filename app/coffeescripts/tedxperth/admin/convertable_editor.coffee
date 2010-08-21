TEDxPerth.withNS 'Admin.ConvertableEditor', (ns) ->

  ns.containerSelector = 'fieldset.inputs.convertable'
  ns.editorSelector =    'textarea'
  ns.formatSelector =    'select'
  
  ns.showEditor = (s) ->
    TEDxPerth.CKEditor.makeEditor s
    
  ns.hideEditor = (s) ->
    TEDxPerth.CKEditor.destroyEditor s
    
  ns.shouldShowEditor = (s) ->
    s.find(ns.formatSelector).val() is "raw"
  
  ns.toggleEditorOn = (scope) ->
    ns.debug scope
    $scope = $ scope
    if ns.shouldShowEditor $scope
      ns.showEditor $scope.find(ns.editorSelector)
    else
      ns.hideEditor $scope.find(ns.editorSelector)
  
  ns.attachEvents = ->
    $(ns.containerSelector).each ->
      $(@).find(ns.formatSelector).change =>
        ns.toggleEditorOn @

  ns.setup = -> ns.attachEvents()
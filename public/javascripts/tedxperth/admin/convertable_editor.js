var __bind = function(func, context) {
    return function(){ return func.apply(context, arguments); };
  };
TEDxPerth.withNS('Admin.ConvertableEditor', function(ns) {
  ns.containerSelector = 'fieldset.inputs.convertable';
  ns.editorSelector = 'textarea';
  ns.formatSelector = 'select';
  ns.showEditor = function(s) {
    return TEDxPerth.CKEditor.makeEditor(s);
  };
  ns.hideEditor = function(s) {
    return TEDxPerth.CKEditor.destroyEditor(s);
  };
  ns.shouldShowEditor = function(s) {
    return s.find(ns.formatSelector).val() === "raw";
  };
  ns.toggleEditorOn = function(scope) {
    var $scope;
    ns.debug(scope);
    $scope = $(scope);
    return ns.shouldShowEditor($scope) ? ns.showEditor($scope.find(ns.editorSelector)) : ns.hideEditor($scope.find(ns.editorSelector));
  };
  ns.attachEvents = function() {
    return $(ns.containerSelector).each(function() {
      return $(this).find(ns.formatSelector).change(__bind(function() {
        return ns.toggleEditorOn(this);
      }, this));
    });
  };
  return (ns.setup = function() {
    return ns.attachEvents();
  });
});
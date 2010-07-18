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
      return $(this).find(ns.formatSelector).change((function(__this) {
        var __func = function() {
          return ns.toggleEditorOn(this);
        };
        return (function() {
          return __func.apply(__this, arguments);
        });
      })(this));
    });
  };
  ns.setup = function() {
    return ns.attachEvents();
  };
  return ns.setup;
});
// Generated by CoffeeScript 1.9.2
(function() {
  angular.module('HueThesis').controller('CanvasController', function($scope, $hue) {
    return $hue.lights().then(function(lights) {
      return $scope.lights = lights;
    });
  });

}).call(this);

//# sourceMappingURL=canvasController.js.map

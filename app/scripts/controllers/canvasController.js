// Generated by CoffeeScript 1.9.2
(function() {
  angular.module('HueThesis').controller('CanvasController', function($scope, $hue) {
    $hue.lights().then(function(lights) {
      return $scope.lights = lights;
    });
    return setTimeout(function() {
      return $scope.lights[0].state.x = 0;
    }, 1000);
  });

}).call(this);

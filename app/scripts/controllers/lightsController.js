// Generated by CoffeeScript 1.9.2
(function() {
  'use strict';
  angular.module('HueThesis').controller('LightsController', function($rootScope, $scope, $hue) {
    $scope.sync = function() {
      return $hue.sync();
    };
    $scope.$watch($rootScope.lights, function() {
      return console.log(arguments);
    });
    console.log($rootScope.lights);
    $scope.toggle = $hue.toggle.bind($hue);
    return $scope.getStyleFromState = function(state) {
      var k, obj, payload, rgb, v;
      if (!state) {
        return;
      }
      payload = {
        x: state.xy[0],
        y: state.xy[1],
        bri: state.bri / 255
      };
      rgb = $hue.xyBriToRgb(payload);
      for (k in rgb) {
        v = rgb[k];
        rgb[k] = Math.round(255 * v);
      }
      obj = {
        'background-color': "rgb(" + rgb.r + "," + rgb.g + "," + rgb.b + ")"
      };
      if (state.on === false) {
        obj.filter = 'grayscale(100%)';
        obj.webkitFilter = 'grayscale(100%)';
      }
      return obj;
    };
  });

}).call(this);

//# sourceMappingURL=lightsController.js.map

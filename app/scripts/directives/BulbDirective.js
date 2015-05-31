// Generated by CoffeeScript 1.9.2
(function() {
  console.log("loading directive");

  angular.module('HueThesis').directive('bulb', function($hue) {
    return {
      restrict: 'C',
      scope: {
        light: "=",
        listenTo: "="
      },
      link: function(scope, element, attrs) {
        var getStyleFromState;
        console.log("keks");
        getStyleFromState = function(state) {
          var k, payload, rgb, v;
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
          return "background-color: rgb(" + rgb.r + "," + rgb.g + "," + rgb.b + ")";
        };
        return scope.$watch('light', function(newValue) {
          if (newValue) {
            return attrs.$set('style', getStyleFromState(newValue.state));
          }
        });
      }
    };
  });

}).call(this);
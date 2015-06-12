angular.module('HueThesis').controller 'CanvasController', ( $scope, $hue ) ->

    $hue.lights().then ( lights ) ->
        $scope.lights = lights



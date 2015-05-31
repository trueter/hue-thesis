angular.module('HueThesis').controller 'CanvasController', ( $scope, $hue ) ->

    $hue.lights().then ( lights ) ->
        $scope.lights = lights

    setTimeout ->

        $scope.lights[0].state.x = 0
    , 1000

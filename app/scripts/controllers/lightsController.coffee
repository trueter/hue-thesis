'use strict';

##
 # @ngdoc function
 # @name HueThesis.controller:HomeController
 # @description
 # # HomeController
 #
angular.module('HueThesis').controller 'LightsController', ( $scope, $hue ) ->

    $scope.lights = $hue.lights().then ( lights ) ->
        console.log lights
        $scope.lights = lights


    $scope.sync = ->
        $scope.lights = []
        $hue.sync().lights().then ( lights ) ->
            $scope.lights = lights



    $scope.getStyleFromState = ( state ) ->

        payload =
            x   : state.xy[ 0 ]
            y   : state.xy[ 1 ]
            bri : state.bri / 255

        rgb = $hue.xyBriToRgb payload

        for k,v of rgb
            rgb[ k ] = Math.round( 255 * v )


        'background-color': "rgb(#{ rgb.r },#{ rgb.g },#{ rgb.b })"



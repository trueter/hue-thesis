'use strict';

##
 # @ngdoc function
 # @name HueThesis.controller:HomeController
 # @description
 # # HomeController
 #
angular.module('HueThesis').controller 'LightsController', ( $rootScope, $scope, $hue ) ->

    $scope.sync = ->
        $hue.sync()

    $scope.$watch $rootScope.lights, ->
        console.log arguments

    console.log $rootScope.lights


    $scope.toggle = $hue.toggle.bind($hue)

    $scope.getStyleFromState = ( state ) ->
        return if not state

        payload =
            x   : state.xy[ 0 ]
            y   : state.xy[ 1 ]
            bri : state.bri / 255

        rgb = $hue.xyBriToRgb payload

        for k,v of rgb
            rgb[ k ] = Math.round( 255 * v )


        obj =
            'background-color': "rgb(#{ rgb.r },#{ rgb.g },#{ rgb.b })"

        if state.on is off
            obj.filter = 'grayscale(100%)'
            obj.webkitFilter = 'grayscale(100%)'

        obj



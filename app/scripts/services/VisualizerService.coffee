angular.module('HueThesis').service '$visualizer', class VisualizerService

    constructor :  ( $rootScope ) ->

        @get = ->
            @song


        @set = ( song ) ->
            $rootScope.$emit 'song:set', song
            @song = song




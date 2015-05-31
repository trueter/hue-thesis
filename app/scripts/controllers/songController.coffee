angular.module('HueThesis').controller 'SongController', ( _, $rootScope, $scope, $interval, Echonest, $visualizer, $spotify ) ->

    $scope.history = [ ]

    $rootScope.$on 'song:set', ( e, song ) ->
        console.log arguments
        $scope.song = song

    $rootScope.$on 'song:event', ( e, data ) ->
        $scope.history.unshift data

    HVOB = "ARPDAZA13A6C1557F5"

    Echonest.songs.search(
        artist: "HVOB"
        title : "Last Song"
    ).then ( songs ) ->
        if songs.length is 1
            song = songs[0]
            Echonest.songs.get(
                id : song.id
                bucket: [
                    'id:spotify'
                    'tracks'
                    'audio_summary'

                ]
            ).then ( song ) ->
                console.log song

                $visualizer.set
                    title     : song.title
                    artist    : song.artist_name
                    spotifyId : song.tracks[0].foreign_id
                    analysis  : song.audio_summary


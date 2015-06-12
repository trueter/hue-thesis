angular.module('HueThesis').controller 'SongController', ( _, $rootScope, $scope, $interval, $http, Echonest, $visualizer, $spotify ) ->


    $scope.history = [ ]
    $scope.secondsPassed = 0

    $rootScope.$on 'song:select', ( e, song ) ->
        $scope.song = song

        $interval ->
            $scope.secondsPassed += 1
        , 1000



    $rootScope.$on 'song:event', ( e, data ) ->
        #return if data.type is 'beat'

        $scope.$apply ->
            $scope.lastTime = data.start
            $scope.history.unshift data



    $scope.artist = 'HVOB'
    $scope.title = 'Last Song'
    key = 'hue-thesis.' + encodeURIComponent( $scope.artist + "-" + $scope.title )
    console.log key

    if x = window.localStorage.getItem(key)
        $rootScope.$emit 'song:select', JSON.parse x
    else

        HVOB = "ARPDAZA13A6C1557F5"

        Echonest.songs.search(
            #combined : $scope.artist + " " + $scope.title
            artist: $scope.artist
            title : $scope.title
        ).then ( songs ) ->
            console.log songs
            songs.length = 1
            if songs.length is 1
                song = songs[0]
                Echonest.songs.get(
                    id : song.id
                    bucket: [
                        'id:spotify', 'tracks', 'audio_summary', 'tracks'
                    ]
                ).then ( song ) ->
                    # console.log song
                    $http.get( song.audio_summary.analysis_url ).then ( resp ) ->

                        payload =
                            title     : song.title
                            artist    : song.artist_name
                            spotifyId : song.tracks[0].foreign_id
                            analysis  : resp.data

                        $rootScope.$emit 'song:select', payload


                        window.localStorage.setItem key, JSON.stringify payload


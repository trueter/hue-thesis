mock = true
angular.module('HueThesis').service '$spotify', class SpotifyService

    TOKEN_SERVICE  = "http://www.torsten-rueter.com"
    CLIENT_ID      =

    audioplayer    = null

    constructor :  ( $rootScope, $http, $interval, $q ) ->

        console.log "trying to authenticate"



        spotify.authenticate 'test-scheme', 'aRandomClientId1234', 'code', 'http://tok.en', ['streaming'], ( err, session ) ->
            if not mock then console.log "authenticated"
            if not mock then console.log arguments

            audioplayer = spotify.createAudioPlayer CLIENT_ID
            if not mock then console.log "creating audio player"
            audioplayer.login session, ( ) ->
                if not mock then console.log "audio player created"
                if not mock then console.log arguments
                if not mock then console.log "playing song"

                audioplayer.play 'spotify:track:3XpXhVtZwqh2eM5d9ieXT5', ( err, data ) ->
                    if not mock then console.log "song playing"
                    if not mock then console.log arguments

                    if mock
                        $interval ->
                            $rootScope.$emit 'song:event',
                                type : "beat"
                                time : performance.now()
                                duration : 0.3
                        , 1000
                        $interval ->
                            $rootScope.$emit 'song:event',
                                type : "bar"
                                time : performance.now()
                                duration : 4
                        , 4002
                        $interval ->
                            $rootScope.$emit 'song:event',
                                type : "section"
                                time : performance.now()
                                duration : 0.5
                        , 8000







    isSessionValid : ( session, callback ) ->
        spotify.isSessionValid session, callback


    renewSession : ( ) ->
        spotify.renewSession session, TOKEN_SERVICE, callback


if mock
    window.spotify =
        authenticate : ( a, b, c, d, e, cb ) ->
            cb()
        createAudioPlayer: ->
            login : ( a, cb ) ->
                cb()
            play : ( a, cb ) ->
                cb()

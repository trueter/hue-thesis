mock = true
angular.module('HueThesis').service '$spotify', class SpotifyService

    TOKEN_SERVICE  = "http://www.torsten-rueter.com"
    CLIENT_ID      =

    audioplayer    = null

    constructor :  ( $rootScope, $http, $interval, $q ) ->

        @mock = mock

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

                $rootScope.$on 'song:select', ( e, song ) ->

                    audioplayer.play song.spotifyId, ( err, data ) ->
                        if not mock then console.log "song playing"
                        if not mock then console.log arguments

                        setTimeout ->
                            $rootScope.$emit 'song:play'
                        , 500



    isSessionValid : ( session, callback ) ->
        spotify.isSessionValid session, callback


    renewSession : ( ) ->
        spotify.renewSession session, TOKEN_SERVICE, callback


if mock
    this.spotify =
        authenticate : ( a, b, c, d, e, cb ) ->
            cb()
        createAudioPlayer: ->
            login : ( a, cb ) ->
                cb()
            play : ( a, cb ) ->
                cb()

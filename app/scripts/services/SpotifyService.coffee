angular.module('HueThesis').service '$spotify', class SpotifyService

    TOKEN_SERVICE  = "http://www.torsten-rueter.com"
    CLIENT_ID      =

    audioplayer    = null

    constructor :  ( $rootScope, $http, $q, config, $console ) ->

        console.log "trying to authenticate"



        spotify.authenticate 'test-scheme', 'aRandomClientId1234', 'code', 'http://tok.en', ['streaming'], ( err, session ) ->
            console.log "authenticated"
            console.log arguments

            audioplayer = spotify.createAudioPlayer CLIENT_ID
            console.log "creating audio player"
            audioplayer.login session, ( ) ->
                console.log "audio player created"
                console.log arguments
                console.log "playing song"

                audioplayer.play 'spotify:track:3XpXhVtZwqh2eM5d9ieXT5', ( err, data ) ->
                    console.log "song playing"
                    console.log arguments




    isSessionValid : ( session, callback ) ->
        spotify.isSessionValid session, callback


    renewSession : ( ) ->
        spotify.renewSession session, TOKEN_SERVICE, callback



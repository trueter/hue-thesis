// Generated by CoffeeScript 1.9.2
(function() {
  var SpotifyService;

  angular.module('HueThesis').service('$spotify', SpotifyService = (function() {
    var CLIENT_ID, TOKEN_SERVICE, audioplayer;

    TOKEN_SERVICE = "http://www.torsten-rueter.com";

    CLIENT_ID = audioplayer = null;

    function SpotifyService($rootScope, $http, $q, config, $console) {
      console.log("trying to authenticate");
      spotify.authenticate('test-scheme', 'aRandomClientId1234', 'code', 'http://tok.en', ['streaming'], function(err, session) {
        console.log("authenticated");
        console.log(arguments);
        audioplayer = spotify.createAudioPlayer(CLIENT_ID);
        console.log("creating audio player");
        return audioplayer.login(session, function() {
          console.log("audio player created");
          console.log(arguments);
          console.log("playing song");
          return audioplayer.play('spotify:track:3XpXhVtZwqh2eM5d9ieXT5', function(err, data) {
            console.log("song playing");
            return console.log(arguments);
          });
        });
      });
    }

    SpotifyService.prototype.isSessionValid = function(session, callback) {
      return spotify.isSessionValid(session, callback);
    };

    SpotifyService.prototype.renewSession = function() {
      return spotify.renewSession(session, TOKEN_SERVICE, callback);
    };

    return SpotifyService;

  })());

}).call(this);
// Generated by CoffeeScript 1.9.2
(function() {
  angular.module('HueThesis').controller('SongController', function(_, $rootScope, $scope, $interval, $http, Echonest, $visualizer, $spotify) {
    var HVOB, key, x;
    $scope.history = [];
    $scope.secondsPassed = 0;
    $rootScope.$on('song:select', function(e, song) {
      $scope.song = song;
      return $interval(function() {
        return $scope.secondsPassed += 1;
      }, 1000);
    });
    $rootScope.$on('song:event', function(e, data) {
      return $scope.$apply(function() {
        $scope.lastTime = data.start;
        return $scope.history.unshift(data);
      });
    });
    $scope.artist = 'HVOB';
    $scope.title = 'Last Song';
    key = 'hue-thesis.' + encodeURIComponent($scope.artist + "-" + $scope.title);
    console.log(key);
    if (x = window.localStorage.getItem(key)) {
      return $rootScope.$emit('song:select', JSON.parse(x));
    } else {
      HVOB = "ARPDAZA13A6C1557F5";
      return Echonest.songs.search({
        artist: $scope.artist,
        title: $scope.title
      }).then(function(songs) {
        var song;
        console.log(songs);
        songs.length = 1;
        if (songs.length === 1) {
          song = songs[0];
          return Echonest.songs.get({
            id: song.id,
            bucket: ['id:spotify', 'tracks', 'audio_summary', 'tracks']
          }).then(function(song) {
            return $http.get(song.audio_summary.analysis_url).then(function(resp) {
              var payload;
              payload = {
                title: song.title,
                artist: song.artist_name,
                spotifyId: song.tracks[0].foreign_id,
                analysis: resp.data
              };
              $rootScope.$emit('song:select', payload);
              return window.localStorage.setItem(key, JSON.stringify(payload));
            });
          });
        }
      });
    }
  });

}).call(this);

//# sourceMappingURL=songController.js.map

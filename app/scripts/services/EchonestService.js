// Generated by CoffeeScript 1.9.2
(function() {
  var EchonestService;

  angular.module('HueThesis').service('$echo', EchonestService = (function() {
    EchonestService.prototype.api_key = 'QQKP1N3XKJO7YTSRS';

    EchonestService.prototype.api_version = 'v4';

    EchonestService.prototype.host = 'http://developer.echonest.com';

    function EchonestService() {
      console.log("Creating echonest service");
    }

    EchonestService.prototype.getSong = function(id) {
      return console.log("Getting song ", id);
    };

    return EchonestService;

  })());

}).call(this);

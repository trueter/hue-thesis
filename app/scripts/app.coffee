angular
    .module( 'HueThesis', ['ionic', 'ngCordova', 'ngResource', 'angular-echonest']).run ( $ionicPlatform, $spotify ) ->

        $ionicPlatform.ready ->




    .config ( EchonestProvider, $httpProvider, $stateProvider, $urlRouterProvider ) ->
        # register $http interceptors, if any. e.g.
        # $httpProvider.interceptors.push('interceptor-name')
        EchonestProvider.setApiKey 'YSSOAU0PJYAK6WUYD'
        # Application routing
        $stateProvider
          .state('app', {
            url: '/app',
            abstract: true,
            templateUrl: 'templates/main.html',
            controller: 'MainController'
          })
          .state('app.home', {
            url: '/home',
            cache: true,
            views: {
              'viewContent': {
                templateUrl: 'templates/views/home.html',
                controller: 'HomeController'
              }
            }
          })
          .state('app.settings', {
            url: '/settings',
            cache: true,
            views: {
              'viewContent': {
                templateUrl: 'templates/views/settings.html',
                controller: 'SettingsController'
              }
            }
          })
          .state('app.canvas', {
            url: '/canvas',
            cache: true,
            views: {
              'viewContent': {
                templateUrl: 'templates/views/canvas.html',
                controller: 'CanvasController'
              }
            }
          })
          .state('app.song', {
            url: '/song',
            cache: true,
            views: {
              'viewContent': {
                templateUrl: 'templates/views/song.html',
                controller: 'SongController'
              }
            }
          })
          .state('app.lights', {
            url: '/lights',
            cache: true,
            views: {
              'viewContent': {
                templateUrl: 'templates/views/lights.html',
                controller: 'LightsController'
              }
            }
          })


        # redirects to default route for undefined routes
        $urlRouterProvider.otherwise('/app/home')



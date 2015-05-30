angular
  .module( 'HueThesis', ['ionic', 'ngCordova', 'ngResource']).run ( $ionicPlatform ) ->

    $ionicPlatform.ready ->
      # save to use plugins here

    # add possible global event handlers here


  .config ( $httpProvider, $stateProvider, $urlRouterProvider ) ->
    # register $http interceptors, if any. e.g.
    # $httpProvider.interceptors.push('interceptor-name')

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



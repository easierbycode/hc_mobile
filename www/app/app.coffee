
angular.module("hcMobile", [
  "ionic"
  'ngResource'
  "hcMobile.controllers"
  "hcMobile.services"
]).run(($ionicPlatform, $rootScope, $ionicLoading, $timeout, $state, SessionFactory) ->
  $ionicPlatform.ready ->
    # Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    # for form inputs)
    if window.cordova and window.cordova.plugins.Keyboard
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar true

    # org.apache.cordova.statusbar required
    StatusBar.styleDefault()  if window.StatusBar

  $rootScope.showLoading = (msg) ->
    $ionicLoading.show
      template: msg or "Loading"
      animation: "fade-in"
      showBackdrop: true
      maxWidth: 200
      showDelay: 0

  $rootScope.hideLoading = ->
    $ionicLoading.hide()

  $rootScope.toast = (msg) ->
    $rootScope.showLoading msg
    $timeout (->
      $rootScope.hideLoading()
    ), 2999

  $rootScope.logout = ->
    SessionFactory.deleteSession()
    $state.go 'login'

).config ($stateProvider, $urlRouterProvider) ->

  $stateProvider
    .state('app',
      url: '/app'
      templateUrl: 'app/layout/menu-layout.html'
      abstract: true
    ).state('app.dash',
      url: '/dash'
      views:
        mainContent:
          templateUrl: 'templates/dashboard.html'
          controller: 'DashCtrl'
    ).state('app.sensorSetup',
      resolve:
        resolvedCustomerAccount: ($http) ->
          $http.get 'http://homeclub.us/api/me/customer-account'
      url: '/sensor-setup'
      views:
        mainContent:
          templateUrl: 'templates/sensor-setup.html'
          controller: 'SensorSetupCtrl'
  ).state('login',
    url: '/login'
    views:
      '':
        templateUrl: 'templates/login.html'
        controller: 'SignInCtrl'
  )

  $urlRouterProvider.otherwise '/login'
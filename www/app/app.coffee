
angular.module("hcMobile", [
  "ionic"
  'ngResource'
  "hcMobile.controllers"
  "hcMobile.services"
]).run(($ionicPlatform, $rootScope, $ionicLoading, $timeout, $state, SessionFactory) ->
  $ionicPlatform.ready ->

    pushNotification = window.plugins.pushNotification

    # - `token`: string.  Google registration ID or Apple device token.
    token = localStorage.getItem 'token'

    unless token

      # register with APN/GCM, then send token to alerts server
      if ionic.Platform.isAndroid()
        pushNotification.register pushCallbacks.GCM.successfulRegistration, pushCallbacks.errorHandler,
          senderID  : '125902103424'
          ecb       : 'pushCallbacks.GCM.onNotification'

      if ionic.Platform.isIOS()
        pushNotification.register pushCallbacks.APN.successfulRegistration, pushCallbacks.errorHandler,
          badge : 'true'
          sound : 'true'
          alert : 'true'
          ecb   : 'pushCallbacks.APN.onNotification'


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
# Ionic Starter App

# angular.module is a global place for creating, registering and retrieving Angular modules
# 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
# the 2nd parameter is an array of 'requires'
# 'starter.services' is found in services.js
# 'starter.controllers' is found in controllers.js

# Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
# for form inputs)

# org.apache.cordova.statusbar required
angular.module("hcMobile", [
  "ionic"
  "starter.controllers"
  "starter.services"
  'highcharts-ng'
]).run(($ionicPlatform) ->
  $ionicPlatform.ready ->
    cordova.plugins.Keyboard.hideKeyboardAccessoryBar true  if window.cordova and window.cordova.plugins.Keyboard
    StatusBar.styleDefault()  if window.StatusBar

).config ($stateProvider, $urlRouterProvider) ->

  # Ionic uses AngularUI Router which uses the concept of states
  # Learn more here: https://github.com/angular-ui/ui-router
  # Set up the various states which the app can be in.
  # Each state's controller can be found in controllers.js

  # setup an abstract state for the tabs directive

  # Each tab has its own nav history stack:
  $stateProvider
    .state("home",
      url: "/home"
      templateUrl: "app/home/home.html"
      abstract: true
    ).state('app',
      url: '/app'
      templateUrl: 'app/layout/menu-layout.html'
      abstract: true
    ).state("app.dash",
      url: "/dash"
      views:
        mainContent:
          templateUrl: "templates/tab-dash.html"
          controller: "DashCtrl"
    ).state("app.alerts",
      url: "/alerts"
      views:
        mainContent:
          templateUrl: "templates/tab-alerts.html"
          controller: "AlertsCtrl"
    ).state("app.reports",
      url: "/reports"
      views:
        mainContent:
          templateUrl: "templates/tab-reports.html"
          controller: "ReportsCtrl"
    ).state("login",
      url: '/login'
      views:
        '':
          templateUrl: 'templates/tab-login.html'
          controller: 'SignInCtrl'
    )

  $urlRouterProvider.otherwise "/login"
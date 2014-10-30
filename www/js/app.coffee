# Ionic Starter App

# angular.module is a global place for creating, registering and retrieving Angular modules
# 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
# the 2nd parameter is an array of 'requires'
# 'starter.services' is found in services.js
# 'starter.controllers' is found in controllers.js

# Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
# for form inputs)

# org.apache.cordova.statusbar required
angular.module("starter", [
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
  $stateProvider.state("home",
    url: "/home"
    templateUrl: "app/home/home.html"
  ).state("tab",
    url: "/tab"
    abstract: true
    templateUrl: "templates/tabs.html"
  ).state("tab.dash",
    url: "/dash"
    views:
      "tab-dash":
        templateUrl: "templates/tab-dash.html"
        controller: "DashCtrl"
  ).state("tab.alerts",
    url: "/alerts"
    views:
      "tab-friends":
        templateUrl: "templates/tab-alerts.html"
        controller: "AlertsCtrl"
  ).state "tab.reports",
    url: "/reports"
    views:
      "tab-account":
        templateUrl: "templates/tab-reports.html"
        controller: "ReportsCtrl"



  # if none of the above states are matched, use this as the fallback
#  $urlRouterProvider.otherwise "/tab/dash"
  $urlRouterProvider.otherwise "/home"
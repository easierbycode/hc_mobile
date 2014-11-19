app = angular.module "hcMobile.controllers", []


app.controller("DashCtrl", ($scope, latest, SessionFactory) ->
  $scope.currentUser = SessionFactory.getSession()

  $scope.refreshLatest = ->
    latest.get sensorHubMacAddresses:$scope.currentUser.gateways[0].sensorHubs, (data) ->
      $scope.latest = data

  $scope.refreshLatest()
)


app.controller('SensorSetupCtrl', ($scope, customeraccount, meta, sensorhub, SessionFactory, $rootScope, resolvedCustomerAccount) ->
  $scope.currentUser = SessionFactory.getSession()
  $scope.customerAccount = new customeraccount(resolvedCustomerAccount.data)
  $scope.meta = meta

  sensorhub.query(sensorHubMacAddresses:$scope.currentUser.gateways[0].sensorHubs, (sensorHubs) ->
    $scope.sensorHubs = sensorHubs
  )

  unless $scope.customerAccount.mutedSensorCategories
    $scope.customerAccount.mutedSensorCategories = {}

  $scope.mutedCategories = (shMacAddress) ->
    $scope.customerAccount.mutedSensorCategories[shMacAddress] || []

  $scope.checkIfMuted = (shMacAddress, category) ->
    mutedCategories = $scope.mutedCategories(shMacAddress)
    category in mutedCategories

  $scope.categoryIsNotMuted = (shMacAddress, category) ->
    isMuted = $scope.checkIfMuted(shMacAddress, category)
    !isMuted

  $scope.toggleMuted = (shMacAddress, category) ->
    mutedCategories = $scope.mutedCategories(shMacAddress)
    if category in mutedCategories
      $scope.customerAccount.mutedSensorCategories[shMacAddress].splice mutedCategories.indexOf(category), 1
    else
      unless $scope.customerAccount.mutedSensorCategories[shMacAddress]
        $scope.customerAccount.mutedSensorCategories[shMacAddress] = []
      $scope.customerAccount.mutedSensorCategories[shMacAddress].push category

  $scope.save = ->
    $scope.sensorHubs.forEach (sensorHub) ->
      sensorHub.$update()
    $scope.customerAccount.$update (customerAccount) ->
      $rootScope.toast 'Saved'

)


app.controller('SignInCtrl', ($scope, $state, $http, $rootScope, AuthFactory, SessionFactory, sensorhub, meta) ->
  $scope.login = (user) ->
    $rootScope.showLoading "Authenticating.."
    AuthFactory
      .login(user)
      .success((data) ->
        $http.get('http://homeclub.us/api/me/customer-account').success((currentUser) ->
          sensorhub.query(sensorHubMacAddresses:currentUser.gateways[0].sensorHubs, (sensorHubs) ->
            currentUser.roomNamesBySensorHubMacAddress = {}
            sensorHubs.forEach (sensorHub) ->
              name = meta.roomTypes[sensorHub.roomType] || meta.sensorHubTypes[String(sensorHub.sensorHubType)]
              @[sensorHub._id] = name
            , currentUser.roomNamesBySensorHubMacAddress
            SessionFactory.createSession(currentUser)
            $state.go 'app.dash'
            $rootScope.hideLoading()
          )
        )
      ).error((data) ->
        $rootScope.hideLoading()
        $rootScope.toast 'Invalid Credentials'
      )
)
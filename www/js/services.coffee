angular.module("starter.services", []).factory('SessionFactory', ($window) ->
  _sessionFactory = {}

  _sessionFactory.createSession = (user) ->
    $window.localStorage.user = JSON.stringify(user)

  _sessionFactory.getSession = ->
    JSON.parse($window.localStorage.user)

  _sessionFactory.deleteSession = ->
    delete $window.localStorage.user
    true

  _sessionFactory.checkSession = ->
    return true if $window.localStorage.user
    false

  _sessionFactory
).factory('AuthFactory', ($http) ->
  _authFactory = {}

  _authFactory.login = (user) ->
    $http.post 'http://homeclub.us/api/login', user

  _authFactory
).factory('latest', ($resource) ->

  $resource 'http://homeclub.us/api/latest/sensor-hub-events'

).factory('sensorhub', ($resource) ->

  $resource 'http://homeclub.us/api/sensor-hubs'

).factory('meta', ->
  {
    "sensorHubTypes": {
      "1": "Water Protector",
      "2": "Comfort Director",
      "3": "Home Defender"
    },
    "roomTypes": {
      "53335728e286cb970c88aaa0": "bedroom",
      "53335728e286cb970c88aaa1": "other",
      "53335728e286cb970c88aaa2": "downstairs",
      "53335728e286cb970c88aaa3": "hallway",
      "53335728e286cb970c88aaa4": "den",
      "53335728e286cb970c88aaa5": "living room",
      "53335728e286cb970c88aaa6": "master bedroom",
      "53335728e286cb970c88aaa7": "kids room",
      "53335728e286cb970c88aaa8": "laundry room",
      "53335728e286cb970c88aaa9": "upstairs",
      "53335728e286cb970c88aaaa": "family room",
      "53335728e286cb970c88aaab": "kitchen",
      "53335728e286cb970c88aaac": "dining room",
      "53335728e286cb970c88aaad": "entryway",
      "53335728e286cb970c88aaae": "office",
      "53335728e286cb970c88aaaf": "basement",
      "53920fe9ecfde8e9a5000001": "bathroom"
    },
    "waterSources": {
      "53937bb4c8fa744670f8b854": "Clothes Washer",
      "53937bb4c8fa744670f8b853": "Aquarium",
      "53937bb4c8fa744670f8b855": "Dishwasher",
      "53937bb4c8fa744670f8b858": "Radiator",
      "53937bb4c8fa744670f8b85a": "Sink",
      "53937bb4c8fa744670f8b85d": "Tub & shower",
      "53937bb4c8fa744670f8b85f": "Water Pipe (water supply line)",
      "53937bb4c8fa744670f8b856": "Humidifier",
      "53937bb4c8fa744670f8b852": "AC unit",
      "53937bb4c8fa744670f8b857": "Pool and Fountain",
      "53937bb4c8fa744670f8b859": "Refrigerator",
      "53937bb4c8fa744670f8b85b": "Sump Pump",
      "53937bb4c8fa744670f8b85e": "Water Heater",
      "53937bb4c8fa744670f8b85c": "Toilet"
    }
  }
).factory 'alerttext', (dateFilter) ->

  sensorHubEvent: (message, roomName) ->
    filteredDate  = dateFilter message.timestamp, 'h:mm a'
    eventResolved = message.sensorEventEnd isnt 0

    if eventResolved
      eventType = message.sensorEventEnd
      resolvedText = ' resolved'
    else
      eventType = message.sensorEventStart
      resolvedText = ''

    switch eventType
      when 1 then '<i class="icon ion-waterdrop"></i><h2>Water detect' + resolvedText + '<span class="item-note">' + filteredDate + '</span></h2><p>' + roomName + '</p>'
      when 2 then 'Motion detect'
      when 3 then '<i class="icon ion-thermometer"></i><h2>Low temperature' + resolvedText + '<span class="item-note">' + filteredDate + '</span></h2><p>' + roomName + '</p>'
      when 4 then '<i class="icon ion-thermometer"></i><h2>High temperature' + resolvedText + '<span class="item-note">' + filteredDate + '</span></h2><p>' + roomName + '</p>'
      when 5 then '<i class="icon ion-ios7-rainy"></i><h2>Low humidity' + resolvedText + '<span class="item-note">' + filteredDate + '</span></h2><p>' + roomName + '</p>'
      when 6 then '<i class="icon ion-ios7-rainy"></i><h2>High humidity' + resolvedText + '<span class="item-note">' + filteredDate + '</span></h2><p>' + roomName + '</p>'
      when 7 then '<i class="icon ion-lightbulb"></i><h2>Low light' + resolvedText + '<span class="item-note">' + filteredDate + '</span></h2><p>' + roomName + '</p>'
      when 8 then '<i class="icon ion-lightbulb"></i><h2>High light' + resolvedText + '<span class="item-note">' + filteredDate + '</span></h2><p>' + roomName + '</p>'


  gatewayEvent: (message) ->
    switch message.gatewayEventCode
      when 1 then '<i class="icon-battery-full"> Going from line power to backup battery'
      when 2 then '<i class="icon-power-cord"> Going from backup battery to line power'
      when 3 then '<i class="icon-battery-half"></i> Transition from high to low battery voltage'
      when 4 then '<i class="icon-battery-empty"></i> Transition from low to critical low battery voltage'
      when 5 then '<i class="icon-power-cord"></i> Going from shipping/dead to power on (SDG connected to line power)'
      when 6 then '<i class="icon-connection"></i> Heartbeat'
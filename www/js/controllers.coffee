angular.module("starter.controllers", []).controller("DashCtrl", ($scope) ->
  $scope.latest = JSON.parse('{"0007807925C0":{"rssi":-72,"timestamp":"2014-10-24T14:05:04.218Z","sensorHubData1":71.6,"sensorHubRssi":-94,"sensorHubBattery":77},"0007807901D9":{"rssi":-72,"timestamp":"2014-10-25T00:15:18.388Z","sensorHubData1":75.2,"sensorHubRssi":-63,"sensorHubBattery":82},"0007807F26CF":{"rssi":-72,"timestamp":"2014-10-25T00:15:02.307Z","sensorHubData1":73.4,"sensorHubRssi":-86,"sensorHubBattery":85,"sensorHubData2":60,"sensorHubData3":33}}')
).controller("AlertsCtrl", ($scope, Friends) ->
  $scope.friends = Friends.all()
).controller "ReportsCtrl", ($scope) ->
  $scope.chartConfig =
    title:
      text: null

    xAxis:
      type: "datetime"

    yAxis:
      title:
        text: null

    options:
      tooltip:
        crosshairs: true
        shared: true
        valueSuffix: " lux"

      legend:
        enabled: false

    series: [
      {
        name: "Light"
        data: [
          [
            1414112400000
            0
          ]
          [
            1414116000000
            0
          ]
          [
            1414119600000
            0
          ]
          [
            1414123200000
            0
          ]
          [
            1414126800000
            0
          ]
          [
            1414130400000
            0
          ]
          [
            1414134000000
            0
          ]
          [
            1414137600000
            0
          ]
          [
            1414141200000
            0
          ]
          [
            1414144800000
            0
          ]
          [
            1414148400000
            0
          ]
          [
            1414152000000
            0
          ]
          [
            1414155600000
            10.32857142857143
          ]
          [
            1414159200000
            606.8095238095239
          ]
          [
            1414162800000
            999
          ]
          [
            1414166400000
            999
          ]
          [
            1414170000000
            999
          ]
          [
            1414173600000
            999
          ]
          [
            1414177200000
            941.4658385093168
          ]
          [
            1414180800000
            632.9044585987261
          ]
          [
            1414184400000
            246.71621621621622
          ]
          [
            1414188000000
            199.7902097902098
          ]
          [
            1414191600000
            147.46808510638297
          ]
          [
            1414195200000
            32.84782608695652
          ]
          [
            1414198800000
            0
          ]
        ]
        zIndex: 1
        marker:
          fillColor: "white"
          lineWidth: 2
          lineColor: "#7cb5ec"
      }
      {
        name: "Range"
        data: [
          [
            1414112400000
            0
            0
          ]
          [
            1414116000000
            0
            0
          ]
          [
            1414119600000
            0
            0
          ]
          [
            1414123200000
            0
            0
          ]
          [
            1414126800000
            0
            0
          ]
          [
            1414130400000
            0
            0
          ]
          [
            1414134000000
            0
            0
          ]
          [
            1414137600000
            0
            0
          ]
          [
            1414141200000
            0
            0
          ]
          [
            1414144800000
            0
            0
          ]
          [
            1414148400000
            0
            0
          ]
          [
            1414152000000
            0
            0
          ]
          [
            1414155600000
            0
            56
          ]
          [
            1414159200000
            56
            999
          ]
          [
            1414162800000
            999
            999
          ]
          [
            1414166400000
            999
            999
          ]
          [
            1414170000000
            999
            999
          ]
          [
            1414173600000
            999
            999
          ]
          [
            1414177200000
            752
            999
          ]
          [
            1414180800000
            305
            999
          ]
          [
            1414184400000
            214
            301
          ]
          [
            1414188000000
            183
            217
          ]
          [
            1414191600000
            95
            219
          ]
          [
            1414195200000
            0
            92
          ]
          [
            1414198800000
            0
            0
          ]
        ]
        type: "arearange"
        lineWidth: 0
        linkedTo: ":previous"
        color: "#7cb5ec"
        fillOpacity: 0.3
        zIndex: 0
      }
    ]
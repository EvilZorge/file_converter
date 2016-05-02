@mainApp.directive "dropboxSaver", ["$http", ($http) ->
  restrict: 'E'
  template: '<input type="checkbox" ng-checked="uploadTo.dropbox.upload" ng-click="saveToDropbox()">{{ "dropbox_saver" | translate }}</input>'
  link: ($scope, $element, $attrs) ->

    $scope.saveToDropbox = ->
      $scope.uploadTo.dropbox.upload = !$scope.uploadTo.dropbox.upload
      if $scope.uploadTo.dropbox.upload
        $scope.dropboxAuth()

    $scope.dropboxAuth = ->
      client = new Dropbox.Client(key: 'yz2smng2q90mc3e')
      client.authDriver(new Dropbox.AuthDriver.Popup({
          receiverUrl: "#{document.location.href}/dropbox_auth.html"
          rememberUser: true
      }))
      if client.isAuthenticated()
        $scope.uploadTo.dropbox.token = client.credentials().token
      else
        client.authenticate (error, client) ->
          if error
            alert(error, 'error')
          else
            $scope.uploadTo.dropbox.token = client.credentials().token
]

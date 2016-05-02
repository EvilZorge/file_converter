@mainApp.directive "googleDriveSaver", ["$http", "lkGoogleSettings", ($http, lkGoogleSettings) ->
  restrict: 'E'
  template: '<input type="checkbox" ng-checked="uploadTo.google_drive.upload" ng-click="saveToGoogleDrive()">{{ "google_drive_saver" | translate }}</input>'
  link: ($scope, $element, $attrs) ->

    $scope.saveToGoogleDrive = ->
      $scope.uploadTo.google_drive.upload = !$scope.uploadTo.google_drive.upload
      if $scope.uploadTo.google_drive.upload
        instanciate()

    instanciate = ->
      gapi.load 'auth', 'callback': onApiAuthLoad

    onApiAuthLoad = ->
      authToken = gapi.auth.getToken()
      if authToken
        handleAuthResult authToken
      else
        gapi.auth.authorize {
          'client_id': lkGoogleSettings.clientId
          'scope': lkGoogleSettings.scopes
          'immediate': false
        }, handleAuthResult

    handleAuthResult = (result) ->
      if result and !result.error
        $scope.uploadTo.google_drive.token = result.access_token
]

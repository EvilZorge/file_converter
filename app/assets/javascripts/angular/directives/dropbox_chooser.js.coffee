@mainApp.directive "dropboxChooser", ["$http", ($http) ->
  restrict: 'E'
  template: '<button class="btn btn-primary" ng-click="dropboxSelect()">Choose From Dropbox</button>'
  link: ($scope, $element, $attrs) ->

    options =
        success: (files) ->
          angular.forEach(files, (file) ->
            $scope.uploadFileFromDropbox(file.link) if file.link && !file.isDir
          )
        linkType: "direct"
        multiselect: true

    $scope.dropboxSelect = ->
      Dropbox.choose(options)

    $scope.uploadFileFromDropbox = (url) ->
      $http.get('/files/file_info', params: { url: url })
        .success (response) ->
          file = new File([response], response.name, response)
          $scope.uploader.addToQueue(file, { external: { url: url, from: 'dropbox' }})
        .error (response) ->
]

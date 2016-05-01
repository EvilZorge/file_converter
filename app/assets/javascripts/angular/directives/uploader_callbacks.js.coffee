@mainApp.directive "uploaderCallbacks", ["$http", "$interval", ($http, $interval) ->
  restrict: 'A'
  link: ($scope, $element, $attrs) ->
    $scope.uploader.onCompleteItem = (item, response, status, headers) ->
      if status == 200
        item.file.status = response.file_upload.state
        item.file.id = response.file_upload.id
        item.file.interval =
          $interval (->
            $scope.checkFileState item
          ), 3000
      else if status == 406
        item.file.status = 'Error'

    $scope.uploader.onAfterAddingFile = (item) ->
      $http.get('/extensions', params: { format: item.file.type })
        .success (response) ->
          item.file.extensions = response.extensions
          item.file.extension_to = response.extensions[0]
        .error (response) ->
          $scope.alert(response.error, 'danger')
          $scope.uploader.removeFromQueue(item)

    $scope.uploader.onBeforeUploadItem = (item) ->
      item.formData.push(extension_to: item.file.extension_to)
      item.formData.push(external: JSON.stringify(item.external)) if item.external
      uploadTo = $scope.filterUploadTo()
      item.formData.push(upload_to: JSON.stringify(uploadTo)) if uploadTo.length != 0
]

@mainApp.controller 'FilesCtrl', ['$scope', '$http', 'FileUploader', '$uibModal', '$interval', "$filter", "$alert", ($scope, $http, FileUploader, $uibModal, $interval, $filter, $alert) ->
  $scope.uploader = new FileUploader(url: '/files/upload')
  $scope.uploadTo =
    dropbox: { upload: false }
    google_drive: { upload: false }

  $scope.filterUploadTo = ->
    uploadTo = []
    angular.forEach($scope.uploadTo, (external, key) ->
      if external.upload && external.token
        angular.merge(external, name: key)
        uploadTo.push(external)
    )
    uploadTo

  $scope.uploadFile = ->
    document.getElementById('file-uploader').click()

  $scope.checkFileState = (item) ->
    $http.get('/files/check_state', params: { id: item.file.id })
      .success (response) ->
        if response.state == 'converted'
          item.file.status = response.state
          item.file.download_url = response.download_url
          $interval.cancel(item.file.interval)
      .error (response) ->
        $scope.alert(response.error, 'danger')

  $scope.openUploadFromUrl = ->
    modalInstance = $uibModal.open(
      animation: true
      templateUrl: 'modals/uploadFromUrl.html'
      controller: 'ModalInstanceCtrl'
      size: 'lg'
    )
    modalInstance.result.then (url) ->
      $scope.uploadFileFromUrl(url)

  $scope.uploadFileFromUrl = (url) ->
    $http.get('/files/file_info', params: { url: url })
      .success (response) ->
        file = new File([response], response.name, response)
        $scope.uploader.addToQueue(file, { external: { url: url, from: 'url' }})
      .error (response) ->
        $scope.alert(response.error, 'danger')

  $scope.alert = (message, type) ->
    $alert(content: message, placement: 'top', type: type, show: true, duration: 5)
]

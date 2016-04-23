@mainApp.controller 'FilesCtrl', ['$scope', '$http', 'FileUploader', '$uibModal', '$interval', "$filter", ($scope, $http, FileUploader, $uibModal, $interval, $filter) ->
  $scope.uploader = new FileUploader(url: '/files/upload')
  $scope.uploadTo =
    dropbox: { upload: false }
    google_drive: { upload: false }

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
        $scope.uploader.removeFromQueue(item)

  $scope.uploader.onBeforeUploadItem = (item) ->
    item.formData.push(extension_to: item.file.extension_to)
    item.formData.push(external: JSON.stringify(item.external)) if item.external
    uploadTo = $scope.filterUploadTo()
    item.formData.push(upload_to: JSON.stringify(uploadTo)) if uploadTo.length != 0

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

  $scope.uploadFileFromUrl = (url) ->
    $http.get('/files/file_info', params: { url: url })
      .success (response) ->
        file = new File([response], response.name, response)
        $scope.uploader.addToQueue(file, { external: { url: url, from: 'url' }})
      .error (response) ->

  $scope.openUploadFromUrl = ->
    modalInstance = $uibModal.open(
      animation: true
      templateUrl: 'modals/uploadFromUrl.html'
      controller: 'ModalInstanceCtrl'
      size: 'lg'
    )
    modalInstance.result.then (url) ->
      $scope.uploadFileFromUrl(url)
]

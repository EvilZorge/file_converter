@mainApp.controller 'FilesCtrl', ['$scope', '$http', 'FileUploader', '$uibModal', ($scope, $http, FileUploader, $uibModal) ->
  $scope.uploader = new FileUploader(url: '/files/upload')

  $scope.uploader.onCompleteItem = (item, response, status, headers) ->
    if status == 200
      item.file.status = response.file_upload.state
      item.file.download_url = response.file_upload.download_url
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
    item.formData.push(uploaded_url: item.uploaded_url) if item.uploaded_url

  $scope.uploadFile = ->
    document.getElementById('file-uploader').click()

  $scope.uploadFileFromUrl = (url) ->
    $http.get('/files/file_info', params: { url: url })
      .success (response) ->
        file = new File([], response.name, response)
        $scope.uploader.addToQueue(file, { uploaded_url: url})
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

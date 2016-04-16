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

  $scope.uploadFile = ->
    document.getElementById('file-uploader').click()

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
    $http.get(url, responseType: "blob").then (response) ->
      data = response.data
      mimetype = data.type
      filename = $scope.filenameFromUrl(url)
      file = new File([data], filename, type: mimetype)
      dummy = new FileUploader.FileItem($scope.uploader, {})
      dummy.file = file
      dummy._file = file
      $scope.uploader.queue.push(dummy)

  $scope.filenameFromUrl = (url) ->
    url.substr(url.lastIndexOf('/') + 1)

  $scope.test = ->
    lol = $scope
    debugger
]

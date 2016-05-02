@mainApp.directive "googleDriveChooser", [ ->
  restrict: 'E'
  template: '<a href="javascript:;" class="btn btn-primary" lk-google-picker on-picked="onPicked(docs)">{{ "google_drive_chooser" | translate }}</a>'
  link: ($scope, $element, $attrs) ->

    $scope.onPicked = (files) ->
      angular.forEach(files, (file) ->
        request = gapi.client.drive.files.get('fileId': file.id)
        request.execute (resp) ->
          $scope.uploadFileFromGoogleDrive(file, resp)
      )

    $scope.uploadFileFromGoogleDrive = (file_data, file_info) ->
      prepared_file = $scope.prepareFile(file_data, file_info)
      file = new File([prepared_file], prepared_file.name, prepared_file)
      external = {
        url: prepared_file.url,
        from: 'google_drive',
        token: gapi.auth.getToken().access_token
      }
      $scope.uploader.addToQueue(file, { external: external })

    $scope.prepareFile = (file, file_info) ->
      {
        size: file.sizeBytes,
        type: if file_info.exportLinks then "application/pdf" else file.mimeType,
        name: file.name,
        url: if file_info.exportLinks then file_info.exportLinks['application/pdf'] else file_info.downloadUrl
      }
]

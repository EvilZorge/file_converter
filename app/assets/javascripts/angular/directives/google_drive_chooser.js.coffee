@mainApp.directive "googleDriveChooser", [ ->
  restrict: 'E'
  template: '<a href="javascript:;" class="btn btn-primary" lk-google-picker on-picked="onPicked(docs)">Choose From Google Drive</a>'
  link: ($scope, $element, $attrs) ->

    $scope.onPicked = (files) ->
      console.log(files)
]

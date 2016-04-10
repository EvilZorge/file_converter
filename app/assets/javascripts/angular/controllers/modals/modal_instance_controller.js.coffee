@mainApp.controller 'ModalInstanceCtrl', ($scope, $uibModalInstance) ->
  $scope.ok = ->
    if isValidUrl($scope.url)
      $uibModalInstance.close $scope.url
    else
      $scope.uploadUrlForm.url.$invalid = true

  $scope.cancel = ->
    $uibModalInstance.dismiss 'cancel'

  isValidUrl = (url) ->
    url.match /^(ht|f)tps?:\/\/[a-z0-9-\.]+\.[a-z]{2,4}\/?([^\s<>\#%"\,\{\}\\|\\\^\[\]`]+)?$/


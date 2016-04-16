@mainApp.controller 'UsersCtrl', ['$scope', '$filter', ($scope, $filter) ->
  $scope.init = (user) ->
    user = JSON.parse(user)
    $scope.user =
      name: user.name
      lastname: user.lastname
      email: user.email
    $scope.files = user.converted_files
]

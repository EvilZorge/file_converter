@mainApp.directive "languageSelect", ["$translate", "$http", "$location", ($translate, $http, $location) ->
  restrict: 'E'
  link: ($scope, $element, $attrs) ->
    $scope.languages = [
        name: 'English'
        key: 'en'
      ,
        name: 'Русский'
        key: 'ru'
    ]
    parts = $location.url().split('/')

    parts.forEach (part) ->
      if part == 'ru'
        $scope.selectedLang = $scope.languages[1]

    $scope.selectedLang = $scope.languages[0] unless $scope.selectedLang
    $translate.use($scope.selectedLang.key)
]

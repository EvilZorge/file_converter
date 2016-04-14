@mainApp.directive "dropboxChooser", [->
  restrict: 'E'
  template: '<button class="btn btn-primary" ng-click="dropboxSelect()">Choose From Dropbox</button>'
  link: ($scope, $element, $attrs) ->

    options =
        success: (files) ->
          console.log(files)
        linkType: "direct"
        multiselect: true

    $scope.dropboxSelect = ->
      Dropbox.choose(options)
]

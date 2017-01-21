'use strict'

class mdderCtrler
  constructor: ($scope, $smoothScroll, $sce, $http) ->
    $scope.e_visible = false;
    $scope.ebtn_text = "Edit";

    # Start Document
    $http.get './doc'
      .then (res) ->
        if res.data
          $scope.raw_md = res.data
          html = marked $scope.raw_md
          $scope.content = $sce.trustAsHtml html

    # For jump to top
    $scope.jumpTo = (id) ->
      $smoothScroll.slow(id, null, null, null)

    # Markdown -> HTML and show html.
    $scope.MdChanged = ->
      html = marked $scope.raw_md
      $scope.content = $sce.trustAsHtml html

    # Editor Button
    $scope.EditBtnClicked = ->
      $scope.e_visible = !$scope.e_visible
      if $scope.e_visible
        $scope.ebtn_text  = "Hide"

      else
        $scope.ebtn_text  = "Edit"

    # File Dialog
    $scope.FileDialog = ->
      document.getElementById('input').click()

    # Watch file upload
    $scope.$watch "mdFile", (mdFile) ->
        if !mdFile
            return

        reader = new FileReader()
        reader.onload = ->
            $scope.$apply ->
                $scope.raw_md = reader.result
                html = marked $scope.raw_md
                $scope.content = $sce.trustAsHtml html

        reader.readAsText mdFile

app = angular.module("mdder", ["smooth-scroll"])

app.directive "fileModel", ($parse) ->
        restrict: "A",
        link: (scope, element, attrs) ->
            model = $parse attrs.fileModel
            element.bind "change", ->
                scope.$apply ->
                    model.assign scope, element[0].files[0]

app.controller("mdder-ctrl", mdderCtrler)


angular.module('app.controllers').controller('MyLinksCtrl', function MyLinksCtrl($scope, Url) {
    $scope.urls = Url.query();
});
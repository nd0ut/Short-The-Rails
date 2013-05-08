angular.module('app.controllers').controller('MyLinksCtrl', function MyLinksCtrl($scope, Url) {
    $scope.urls = Url.query();

    $scope.deleteUrl = function(url_id) {
        $scope.urls.forEach(function(url, index) {
            if (url.id === url_id) {
                url.$delete({id: url.id}, function() {
                    $scope.urls.splice(index, 1);
                });
            }
        });
    }
});
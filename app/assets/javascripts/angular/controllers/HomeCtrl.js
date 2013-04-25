angular.module('app.controllers').controller('HomeCtrl', function NavBarCtrl($scope, Session, Url) {
    $scope.url = new Url();

    $scope.short = function () {
        $scope.url.url = $scope.protocol + $scope.url.url;
        $scope.url.$save();
        console.log($scope.url);
    }

    $scope.onUrlChange = function() {
        var protocol_index = $scope.url.url.indexOf('://');

        if(protocol_index != -1) {
            protocol_index = protocol_index + 3;

            if(protocol_index != $scope.url.url.length) {
                $scope.protocol = $scope.url.url.substr(0, protocol_index);
                $scope.url.url = $scope.url.url.substr(protocol_index);
            }
        }
    };
});
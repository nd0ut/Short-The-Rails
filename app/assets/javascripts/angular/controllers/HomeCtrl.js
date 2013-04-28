angular.module('app.controllers').controller('HomeCtrl', function NavBarCtrl($scope, Url) {
    $scope.url = new Url();

    $scope.short = function () {
        var url = $scope.url.url;

        $scope.url.$save(function(u) {
            if (u.error) {
                alert(u.error);
            }

            u.url = url;
        });

        console.log($scope.url);
    }

    $scope.onUrlChange = function() {
        var protocol_index = $scope.url_without_protocol.indexOf('://');

        if(protocol_index != -1) {
            protocol_index = protocol_index + 3;

            if(protocol_index != $scope.url_without_protocol.length) {
                $scope.protocol = $scope.url_without_protocol.substr(0, protocol_index);
                $scope.url_without_protocol = $scope.url_without_protocol.substr(protocol_index);
            }
        }

        $scope.url.url = $scope.protocol + $scope.url_without_protocol;
    };
});
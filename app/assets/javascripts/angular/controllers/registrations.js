angular.module('app.controllers').controller('RegistrationsCtrl', function RegistrationsCtrl($scope, $location, Session) {

    $scope.registration = Session.userRegistration;

    $scope.create = function() {
        $scope.registration.$save();
    };

    $scope.destroy = function() {
        $scope.registration.$destroy();
    };

});
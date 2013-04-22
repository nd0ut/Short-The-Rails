angular.module('app.controllers').controller('RegistrationsCtrl', function RegistrationsCtrl($scope, $location, $cookieStore, Session) {

    $scope.registration = Session.userRegistration;

    $scope.create = function() {
        $scope.registration.$save()
            .success(function (data, status, headers, config) {
                $cookieStore.put('_angular_devise_user', data['user']);
            });

    };

    $scope.destroy = function() {
        $scope.registration.$destroy()
            .success(function(data, status, headers, config) {
                $cookieStore.remove('_angular_devise_user');
            });
    };

});
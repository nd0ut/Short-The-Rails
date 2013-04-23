angular.module('app.controllers').controller('RegistrationsCtrl', function RegistrationsCtrl($scope, $location, $cookieStore, Session) {

    $scope.registration = Session.createUserRegistration();

    $scope.create = function() {
        $scope.registration.save()
            .success(function (data, status, headers, config) {
                if(data.success) {
                    $cookieStore.put(Session.cookieName, data['user']);
                    Session.update();
                    $location.path('/home');
                }
                else {
                    console.error($scope.registration);
                    console.error(data);
                }
            });

    };
});
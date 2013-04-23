angular.module('app.controllers').controller('SessionsCtrl', function SessionsCtrl($scope, $location, $cookieStore, Session) {

    $scope.session = Session.createUserSession();

    $scope.create = function() {

        if ( Session.signedOut ) {
            $scope.session.save()
                .success(function(data, status, headers, config) {
                    if(data.success) {
                        $cookieStore.put(Session.cookieName, data['user']);
                        Session.update();
                        $location.path('/home');
                    }
                    else {
                        console.error(data);
                    }
                });
        }

    };

    $scope.destroy = function() {
        $scope.session.destroy()
            .success(function(data, status, headers, config) {
                $cookieStore.remove(Session.cookieName);
                Session.update();
            });
    };

    if($location.path() == '/sign_out') {
        $scope.destroy();
        $location.path('/home');
    }

});
angular.module('app.controllers').controller('NavBarCtrl', function NavBarCtrl($scope, Session) {
    $scope.session = Session;
});
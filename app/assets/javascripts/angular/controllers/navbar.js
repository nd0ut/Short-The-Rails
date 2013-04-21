angular.module('app.controllers').controller('NavBarCtrl', function NavBarCtrl($scope) {
    $scope.buttons = [
        { text: "My links", href: "links" },
        { class: "divider" },
        { text: "Sign in", href: "sign_in" },
        { text: "Sign up", href: "sign_up" }
    ];
});
angular.module('app.controllers').controller('NavBarCtrl', function NavBarCtrl($scope, Session) {
    if(Session.signedIn) {
        $scope.buttons = [
            { text: "Logged as " + Session.currentUser.username, href: "user" },
            { text: "My links", href: "links" },
            { class: "divider" },
            { text: "Logout", href: "sign_out" }
        ];
    }

    else {
        $scope.buttons = [
            { text: "My links", href: "links" },
            { class: "divider" },
            { text: "Sign in", href: "sign_in" },
            { text: "Sign up", href: "sign_up" }
        ];
    }
});
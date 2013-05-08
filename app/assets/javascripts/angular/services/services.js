angular.module('app.services').service('Session', function Session($cookieStore, $cookies, UserSession, UserRegistration) {
    this.cookieName = 'current_user';

    this.update = function () {
        if($cookies[this.cookieName])
            this.currentUser = angular.fromJson($.base64.decode($cookies[this.cookieName].replace(/(\n)/gm,"")));
        else
            this.currentUser = null

        this.signedIn = !!this.currentUser
        this.signedOut = !this.signedIn;
    }

    this.update();

    this.createUserSession = function () {
        return userSession = new UserSession( { } );
    }

    this.createUserRegistration = function () {
        return userRegistration = new UserRegistration( { } );
    }
});
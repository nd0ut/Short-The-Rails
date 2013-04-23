angular.module('app.services').service('Session', function Session($cookieStore, UserSession, UserRegistration) {
    this.cookieName =       '_short_the_rails_user';
    this.railsCookieName =  '_short_the_rails_session';

    this.update = function () {
        this.currentUser = $cookieStore.get(this.cookieName);
        this.signedIn = !!$cookieStore.get(this.cookieName);
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
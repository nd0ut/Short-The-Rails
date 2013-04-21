angular.module('app.services').service('Session', function Session($cookieStore, UserSession, UserRegistration) {

    this.currentUser = $cookieStore.get('_angular_devise_user');
    this.signedIn = !!$cookieStore.get('_angular_devise_user');
    this.signedOut = !this.signedIn;
    this.userSession = new UserSession( { email:"foo@bar.com", password:"example"} );
    this.userRegistration = new UserRegistration( { username: Math.floor((Math.random()*1000000)+1), email:"foo-" + Math.floor((Math.random()*10000)+1) + "@bar.com", password:"example", password_confirmation:"example" } );

});
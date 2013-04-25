angular.module('app.resources').factory('Url', function Url($resource) {
    var Url = $resource('/urls/:code', {code:'@code'});

    return Url;
});
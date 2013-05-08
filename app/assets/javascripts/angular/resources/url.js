angular.module('app.resources').factory('Url', function Url($resource) {
    var Url = $resource('/urls/:id', {id:'@id'});

    return Url;
});
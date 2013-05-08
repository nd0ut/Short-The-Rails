angular.module('app.directives').
    directive('autoselect', function() {
        return {
            link: function(scope, element) {
                scope.$watch('url.shorted_url', function(value) {
                    setTimeout(function () {
                        element[0].focus();
                    }, 10);
                });
            }
        };
    });
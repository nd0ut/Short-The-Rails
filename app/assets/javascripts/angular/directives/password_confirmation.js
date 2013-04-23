angular.module('app.directives').
    directive('sameAs', function() {
        return {
            require: 'ngModel',
            link: function(scope, elm, attrs, ctrl) {
                ctrl.$parsers.unshift(function(viewValue) {
                    console.log(scope[attrs.sameAs]);
                    if (viewValue === scope[attrs.sameAs.split('.')[0]][attrs.sameAs.split('.')[1]]) {
                        ctrl.$setValidity('sameAs', true);
                        return viewValue;
                    } else {
                        ctrl.$setValidity('sameAs', false);
                        return viewValue;
                    }
                });
            }
        };
    });
(function () {

    var app = angular.module('usersFactory', ['ngResource']);

    app.factory('Users', ['$resource',function($resource){
        return $resource("/cve/api/users", {}, {
            all: { method: 'GET', isArray: true },
            get: { url: "/cve/api/users/:id", method: 'GET', isArray: false },
        });
    }]);

})();

(function () {

    var app = angular.module('activitiesFactory', ['ngResource']);

    app.factory('Activities', ['$resource',function($resource){
        return $resource("/cve/api/activities", {}, {
            create: { method: 'POST' },
            all: { method: 'GET', isArray: true }
        });
    }]);


    app.factory('Activity', ['$resource', function ($resource) {
        return $resource("/cve/api/activities/:id", {}, {
            get: { method: "GET", isArray: false },
            update: { method: 'PUT' }
        });
    }]);

})();
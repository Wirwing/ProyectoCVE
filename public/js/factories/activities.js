(function () {

    var app = angular.module('activitiesFactory', ['ngResource']);

    app.factory('Activities', ['$resource',function($resource){
        return $resource("/cve/api/activities", {}, {
            create: { method: 'POST' },
            all: { method: 'GET', isArray: true },
            get: { url: "/cve/api/activities/:id", method: 'GET', isArray: false },
            update: { url: "/cve/api/activities/:id", method: 'PUT', isArray: false },
            deleteAttachment: { url: "/cve/api/activities/:id_activity/files/:id_file", method: 'DELETE', isArray: false }
        });
    }]);

/*
    app.factory('Activity', ['$resource', function ($resource) {
        return $resource(, {}, {
            get: { method: "GET", isArray: false },
            update: { method: 'PUT' }
        });
    }]);
*/

})();
(function () {

    var app = angular.module('activitiesFactory', ['ngResource']);

    app.factory('Activities', ['$resource',function($resource){
        return $resource("/cve/api/activities", {}, {
            create: { method: 'POST' },
            all: { method: 'GET', isArray: true },
            get: { url: "/cve/api/activities/:id", method: 'GET', isArray: false },
            getFirstForGroup: { url: "/cve/api/groups/:group_id/single-activity", method: 'GET', isArray: false },
            update: { url: "/cve/api/activities/:id", method: 'PUT', isArray: false },
            remove: { url: "/cve/api/activities/:id", method: 'DELETE', isArray: false },
            deleteAttachment: { url: "/cve/api/activities/:id_activity/files/:id_file", method: 'DELETE', isArray: false }
        });
    }]);

})();
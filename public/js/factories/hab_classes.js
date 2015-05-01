(function () {

    var app = angular.module('habClassesFactory', ['ngResource']);

    app.factory('HabClasses', ['$resource',function($resource){
        return $resource("/cve/api/hab_class", {}, {
            all: { method: 'GET', isArray: true },
            create: { method: 'POST' },
            get: { url: "/cve/api/hab_class/:id", method: 'GET', isArray: false },
            remove: { url: "/cve/api/hab_class/:id", method: 'DELETE', isArray: false },
            update: { url: "/cve/api/hab_class/:id", method: 'PUT', isArray: false }
        });
    }]);

})();
(function () {

    var app = angular.module('groupsFactory', ['ngResource']);

    app.factory('Groups', ['$resource',function($resource){
        return $resource("/cve/api/groups", {}, {
            all: { method: 'GET', isArray: true },
            create: { method: 'POST' },
            get: { url: "/cve/api/groups/:id", method: 'GET', isArray: false },
            getActivity : { url: "/cve/api/groups/:id/activity", method: 'GET', isArray: true },
            remove: {url: "/cve/api/groups/:id", method: 'DELETE', isArray: false},
            update: { url: "/cve/api/groups/:id", method: 'PUT', isArray: false }
        });
    }]);

})();

(function () {

    var app = angular.module('modelsFactory', ['ngResource']);

    app.factory('Models', ['$resource',function($resource){
        return $resource("/cve/api/interaction-models", {}, {
            all: { method: 'GET', isArray: true },
            create: { method: 'POST' },
            get: { url: "/cve/api/interaction-models/:id", method: 'GET', isArray: false }
        });
    }]);

})();
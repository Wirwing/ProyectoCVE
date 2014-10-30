(function () {

    var app = angular.module('modelsFactory', ['ngResource']);

    app.factory('Models', ['$resource',function($resource){
        return $resource("/cve/api/models", {}, {
            all: { method: 'GET', isArray: true },
            create: { method: 'POST' },
            defaultModel: { url:'/cve/api/models/1', method: 'GET' }
        });
    }]);

})();
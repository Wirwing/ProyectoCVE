(function () {

    var app = angular.module('modelsFactory', ['ngResource']);

    app.factory('Models', ['$resource',function($resource){
        return $resource("/cve/api/models", {}, {
            all: { method: 'GET', isArray: true },
            defaultModel: { url:'/cve/api/models/default', method: 'GET' }
        });
    }]);

})();
(function () {

    var app = angular.module('analisisFactory', ['ngResource']);

    app.factory('AnalisisFactory', ['$resource',function($resource){
        return $resource("/cve/api/analisis", {}, {
            all: { method: 'GET', isArray: true }
        });
    }]);

})();

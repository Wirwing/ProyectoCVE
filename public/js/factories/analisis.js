(function () {

    var app = angular.module('analisisFactory', ['ngResource']);

    app.factory('AnalisisFactory', ['$resource',function($resource){

		var url = "/cve/api/analisis";

        return $resource(url, {}, {
            getForGroup: { url: url + "/grupos/:id", method: 'GET', isArray: true }
        });
    }]);

})();

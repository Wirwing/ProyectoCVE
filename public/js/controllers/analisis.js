(function(){

	var app = angular.module('analisisController', ['analisisFactory']);

	app.controller('AnalisisUsoController',['$scope', '$window', 'AnalisisFactory', function($scope, $window, AnalisisFactory){

		AnalisisFactory.all({}, function (analisis) {
			$scope.analisis = analisis;
		});


	}]);

})();

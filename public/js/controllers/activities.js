(function(){

	var app = angular.module('activitiesController', []);  

	app.controller('ActivitiesController',['$scope', function($scope){
		
		$scope.activities = [
		{nombre: 'Laurent', id_tutor: 1, fecha: new Date('2014-10-09'), tipo: "Constructivista", estrategia_instruccional: "ROMPECABEZAS"},
		{nombre: 'Blandine', id_tutor: 1, fecha: new Date('2014-10-09'), tipo: "Constructivista", estrategia_instruccional: "ROMPECABEZAS"},
		{nombre: 'Francoise', id_tutor: 2, fecha: new Date('2014-10-09'), tipo: "Constructivista", estrategia_instruccional: "ROMPECABEZAS"}
		];

	}]);

})();
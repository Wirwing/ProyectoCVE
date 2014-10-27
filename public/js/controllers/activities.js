(function(){

	var app = angular.module('activitiesController', ['activitiesFactory']);  

	app.controller('ActivitiesController',['$scope', 'Activities', function($scope, Activities){
		
		Activities.all({}, function (activities) {
			$scope.activities = activities;
		});

	}]);

})();
(function(){

	var app = angular.module('activitiesController', ['activitiesFactory']);  

	app.controller('ActivitiesController',['$scope', 'Activities', function($scope, Activities){
		
		Activities.all({}, function (activities) {
			$scope.activities = activities;
		});

	}]);

	app.controller('AddActivityController',['$scope', 'Activities', '$window', function($scope, Activities,  $window){
		
		$scope.useDefaultModel = true;

		this.add = function(activity){

			//TODO: Replace values with session ones.
			activity.id_tutor = 1;
			activity.fecha = new Date();
			activity.adjuntos = 0;
			
			Activities.create({}, activity, function () {
                $window.location.href = '/cve/activities';
            });
			

		}
		
	}]);

})();
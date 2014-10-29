(function(){

	var app = angular.module('activitiesController', ['activitiesFactory']);  

	app.controller('ActivitiesController',['$scope', 'Activities', function($scope, Activities){
		
		Activities.all({}, function (activities) {
			$scope.activities = activities;
		});

	}]);

	app.controller('AddActivityController',['$scope', 'Activities', '$window', function($scope, Activities,  $window){
		

		this.add = function(activity){

			//TODO: Replace values with session ones.
			activity.id_tutor = 1;
			activity.id_modelo = 1;
			activity.fecha = new Date();
			
			Activities.create({}, activity, function () {
                $window.location.href = '/cve/activities';
            });
			

		}
		
	}]);

})();
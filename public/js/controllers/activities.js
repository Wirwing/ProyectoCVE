(function(){

	var app = angular.module('activitiesController', ['activitiesFactory', 'modelsFactory']);

	app.controller('ActivitiesController',['$scope', 'Activities', function($scope, Activities){
		
		Activities.all({}, function (activities) {
			$scope.activities = activities;
		});

	}]);

	app.controller('AddActivityController',['$scope', 'Activities', 'Models', '$window', function($scope, Activities, Models, $window){		

		var defaultModel = {};
		$scope.useDefaultModel = false;

		Models.defaultModel({}, function (defaultModel) {

					//Save default model
					defaultModel = defaultModel;

					//Set model as default
					$scope.model = defaultModel;

					//Create shallow copy to mantain original object
					$scope.backupDefaultModel = angular.copy(defaultModel);

					$scope.useDefaultModel = true;

		});

		$scope.setDefaultModel = function(){
			if ($scope.useDefaultModel){
				$scope.model = angular.copy($scope.backupDefaultModel);
			}else{
				//Remove id and mark as not default.
				$scope.model.id = undefined;
				$scope.model.is_default = 0;
			}
		};

		this.add = function(activity){

			//TODO: Replace values with session ones.
			activity.id_tutor = 1;
			activity.fecha = new Date();
			
			activity.model = $scope.model;

			Activities.create({}, activity, function () {
                $window.location.href = '/cve/activities';
            });

		}
		
	}]);

})();
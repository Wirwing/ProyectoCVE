(function(){

	var app = angular.module('activitiesController', ['activitiesFactory', 'modelsFactory', 'angularFileUpload']);

	app.controller('ActivitiesController',['$scope', 'Activities', function($scope, Activities){
		
		Activities.all({}, function (activities) {
			$scope.activities = activities;
		});

	}]);

	app.controller('ActivityController',['$scope', 'Activities', 'FileUploader', '$attrs', '$window', 
		function($scope, Activities, FileUploader, $attrs, $window){

		$scope.activity = Activities.get({id: $attrs.id});

		var uploader = $scope.uploader = new FileUploader({
            url: $attrs.id + '/files'
        });

        uploader.onSuccessItem = function(fileItem, response, status, headers) {
			var file = {name:  fileItem.file.name};
			$scope.attachedFiles.push(file);
        };

        $scope.attachedFiles = [];

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

				//Remove ids and mark as not default.
				$scope.model.nombre = "";
				$scope.model.id = undefined;
				$scope.model.is_default = 0;

				$scope.model.indicators.forEach(function(indicator){
					indicator.id = undefined;
					indicator.id_modelo = undefined;
				});

			}
		};

		this.add = function(activity){

			//TODO: Replace values with session ones.
			activity.id_tutor = 1;
			activity.fecha = new Date();

			if($scope.model.id === undefined){
				newModelForActivity($scope.model, activity);
			}else{
				defaultModelForActivity($scope.model, activity);
			}

		}

		var newModelForActivity = function(model, activity){
			Models.create({}, model, function (created_model) {
				activity.id_modelo = created_model.id;
				Activities.create({}, activity, function () {
					$window.location.href = '/cve/activities';
				});
			});
		}
		
		var defaultModelForActivity = function(model, activity){
			activity.id_modelo = model.id;
			Activities.create({}, activity, function () {
				$window.location.href = '/cve/activities';
			});
		}

	}]);

})();
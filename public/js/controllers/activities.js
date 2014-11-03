(function(){

	var app = angular.module('activitiesController', ['activitiesFactory', 'modelsFactory', 'angularFileUpload']);

	app.controller('ActivitiesController',['$scope', 'Activities', '$window', function($scope, Activities, $window){
		
		Activities.all({}, function (activities) {
			$scope.activities = activities;
		});

		$scope.view = function(activity){
			$window.location.href = '/cve/activities/' + activity.id;
		}

		$scope.delete = function(activity){

		}

	}]);

	app.controller('EditActivityController',['Activities', 'Models', '$scope', '$attrs', '$window',
		function(Activities, Models, $scope, $attrs, $window){

		Activities.get({id: $attrs.id}, function(activity){
			$scope.activity = activity;

			Models.all({}, function(availables){
				$scope.models = availables;
				var index = findIndex($scope.models, activity.model);
				$scope.selectedModel = $scope.models[index];
			});

		});

		var findIndex = function(arr, obj) {
		    for(var i = 0; i < arr.length; i++){
		        if(angular.equals(arr[i], obj)){
		            return i;
		        }
		    };
		    return -1;
		}

		$scope.update = function(activity){

			activity.id_modelo = $scope.selectedModel.id;

			//Remove activity children, otherwise phpactiverecord goes kaput
			activity.attachments = undefined;
			activity.model = undefined;

			Activities.update({id: activity.id}, activity, function () {
				$window.location.href = '/cve/activities/' + activity.id;
			});
		}

	}]);

	app.controller('ActivityController',['$scope', 'Activities', 'FileUploader', '$attrs', '$window', 
		function($scope, Activities, FileUploader, $attrs, $window){

		$scope.activity = Activities.get({id: $attrs.id});

		var uploader = $scope.uploader = new FileUploader({
            url: "/cve/api/activities/" + $attrs.id + '/files'
        });

        uploader.onSuccessItem = function(fileItem, response, status, headers) {
			$scope.activity.attachments.push(response);
        };

        $scope.downloadAttachment = function(attachment){
			$window.location.href = "/cve/api/activities/" + $attrs.id + '/files/' + attachment.id;
        }

        $scope.removeAttachment = function($index, attachment){

        	Activities.deleteAttachment({id_activity: $attrs.id, id_file: attachment.id }, function (message) {
				$scope.activity.attachments.splice($index, 1);
			});

        }

        $scope.edit = function(){
        	$window.location.href = "/cve/activities/" + $attrs.id + '/edit';
        }

	}]);

	app.controller('AddActivityController',['$scope', 'Activities', 'Models', '$window', function($scope, Activities, Models, $window){

		Models.all({}, function(availables){
			$scope.models = availables;
			$scope.selectedModel = availables[0];
		});
		
		this.add = function(activity){

			//TODO: Replace values with session ones.
			activity.id_tutor = 1;
			activity.fecha = new Date();
			activity.id_modelo = $scope.selectedModel.id;

			Activities.create({}, activity, function () {
				$window.location.href = '/cve/activities';
			});

		}

	}]);

})();
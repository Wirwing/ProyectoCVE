(function(){

	var app = angular.module('modelsController', ['modelsFactory']);

	app.controller('ModelsController',['$scope', 'Models', '$window', function($scope, Models, $window){
		
		Models.all({}, function (models) {
			$scope.models = models;
		});

		$scope.view = function(model){
			$window.location.href = '/cve/interaction-models/' + model.id;
		}

		$scope.delete = function($index, model){

			Models.remove({id: model.id}, function(){
				$scope.models.splice($index, 1);
			});

		}

	}]);

	app.controller('AddModelController',['Models', '$scope', '$window', function(Models, $scope, $window){

		$scope.model = {};

		$scope.model.indicators = [
		{nombre: "Argumento", frecuencia_individual: 0, frecuencia_grupo: 0, tolerancia: 0},
		{nombre: "Idea", frecuencia_individual: 0, frecuencia_grupo: 0, tolerancia: 0},
		{nombre: "Duda", frecuencia_individual: 0, frecuencia_grupo: 0, tolerancia: 0},
		{nombre: "Pregunta", frecuencia_individual: 0, frecuencia_grupo: 0, tolerancia: 0}
		];

		Models.all({}, function(availables){
			$scope.defaultModel = availables[0];
		});
		
		this.add = function(model){

			Models.create({}, model, function (created) {
				$window.location.href = '/cve/interaction-models/' + created.id;
			});

		}

	}]);

	app.controller('ModelController',['$scope', 'Models', '$attrs', '$window', 
		function($scope, Models, $attrs, $window){

		$scope.model = Models.get({id: $attrs.id});

        $scope.edit = function(){
        	$window.location.href = "/cve/interaction-models/" + $attrs.id + '/edit';
        }

        $scope.delete = function(){
        	Activities.remove({id: $scope.model.id}, function(){
				$window.location.href = '/cve/interaction-models';
			});
        }

	}]);


	app.controller('EditModelController',['Models', '$scope', '$attrs', '$window',
		function(Models, $scope, $attrs, $window){

			$scope.model = Models.get({id: $attrs.id});

			$scope.update = function(){

				Models.update({id: $scope.model.id}, $scope.model, function () {
					$window.location.href = '/cve/interaction-models/' + $scope.model.id;
				});

			}

		}]);


})();
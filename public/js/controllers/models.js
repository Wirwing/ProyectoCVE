(function(){

	var app = angular.module('modelsController', ['modelsFactory', 'habClassesFactory']);

	app.controller('ModelsController',['$scope', 'Models', '$window', function($scope, Models, $window){

		Models.all({}, function (models) {
			$scope.models = models;
		});

		$scope.view = function(model){
			$window.location.href = '/cve/teacher/interaction-models/' + model.id;
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
		/*{nombre: "Argumento", frecuencia_individual: 0, frecuencia_grupo: 0, tolerancia: 0},
		{nombre: "Idea", frecuencia_individual: 0, frecuencia_grupo: 0, tolerancia: 0},
		{nombre: "Duda", frecuencia_individual: 0, frecuencia_grupo: 0, tolerancia: 0},
		{nombre: "Pregunta", frecuencia_individual: 0, frecuencia_grupo: 0, tolerancia: 0}
		];*/
		{nombre: "Argumento"},
		{nombre: "Idea"},
		{nombre: "Duda"},
		{nombre: "Pregunta"}
		];

		Models.all({}, function(availables){
			$scope.defaultModel = availables[0];
		});

		this.add = function(model){

			Models.create({}, model, function (created) {
				$window.location.href = '/cve/teacher/interaction-models/' + created.id;
			});

		}

		$scope.cancel = function(){
			$window.location.href = "/cve/teacher/interaction-models";
		}

	}]);

	app.controller('ModelController',['$scope', 'Models', 'HabClasses', '$attrs', '$window',
		function($scope, Models, HabClasses, $attrs, $window){

		Models.get({id: $attrs.id}, function(model){
			$scope.model = model;
			console.log(model.classes);
		});

        $scope.edit = function(){
        	$window.location.href = "/cve/teacher/interaction-models/" + $attrs.id + '/edit';
        }

		$scope.back = function(){
			$window.location.href = "/cve/teacher/interaction-models";
		}

        $scope.delete = function(){
        	Activities.remove({id: $scope.model.id}, function(){
				$window.location.href = '/cve/teacher/interaction-models';
			});
        }

        $scope.viewClass = function(habClass){
            $window.location.href = '/cve/teacher/hab_classes/' + habClass.id;
        }

        $scope.deleteClass = function($index, habClass){
            HabClasses.remove({id: habClass.id}, function(){
                $scope.model.classes.splice($index, 1);
            });
        }

	}]);


	app.controller('EditModelController',['Models','HabClasses', '$scope', '$attrs', '$window',
		function(Models, HabClasses, $scope, $attrs, $window){

			$scope.check = 0;
			$scope.limit = 1;

			HabClasses.all({}, function( classes ){
				$scope.classes = classes;

				Models.get({id: $attrs.id}, function( model ){
					$scope.model = model;

					for( var i = 0; i < $scope.classes.length; i ++ ){
						var available_class = $scope.classes[i];
						for( var k = 0; k < $scope.model.classes.length; k ++ ){
							var model_class = $scope.model.classes[k];
							if( model_class.id == available_class.id ){
								$scope.classes[i].selected = true;
								$scope.check ++;
								break;
							}
						}
					}
				});
			});


			$scope.onClassChecked = function( abClass ){
				if( abClass.selected ){
					abClass.check ++;
				}else{
					abClass.check --;
				}
			}

			$scope.cancel = function(){
				$window.location.href = "/cve/teacher/interaction-models";
			}

			$scope.update = function(){

				for( var i = 0; i < $scope.classes.length; i ++ ){
					if( $scope.classes.selected ){
						$scope.classes[i].model_id = $scope.model.id;
						//$scope.model.classes.push( $scope.classes[i] );
					}else{
						$scope.classes[i].model_id = -1;
					}

					delete $scope.classes[i].selected;
					delete $scope.classes[i].indicators;
				}

				$scope.model.classes = $scope.classes;

				Models.update({id: $scope.model.id}, $scope.model, function () {
					$window.location.href = '/cve/teacher/interaction-models/' + $scope.model.id;
				});

			}

		}]);


})();

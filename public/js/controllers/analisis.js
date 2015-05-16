(function(){

	var app = angular.module('analisisController', ['analisisFactory']);

	app.controller('AnalisisGroupsController',['$scope', 'Groups', '$window', 'AnalisisFactory', 'HabClasses', 'Activities',
		function($scope, Groups, $window, AnalisisFactory, HabClasses, Activities){

	    Groups.all({}, function (groups) {

	      groups.forEach(function(group){

				AnalisisFactory.activeIndicatorsForGroup({id: group.id}, function (analisis) {

					var numeroClasesEnGrupo = _.uniq(_.pluck(_.flatten(analisis), "id_clase")).length;

					Activities.getFirstForGroup({group_id: group.id}, function(activity){

						var id_model = activity.id_modelo;

						HabClasses.allForModel({model_id: id_model}, function(clasesDelModelo){
							var numeroDeclasesEnModelo = clasesDelModelo.length;
							var porcentajeUsabilidad = numeroDeclasesEnModelo == 0? 0 : numeroClasesEnGrupo / numeroDeclasesEnModelo;

							if(porcentajeUsabilidad < .7){
								var dominio = "NS";
							}else if(porcentajeUsabilidad >= .7 && porcentajeUsabilidad < .8){
								var dominio = "S";
							}else if(porcentajeUsabilidad >= .8 && porcentajeUsabilidad < .9){
								var dominio = "SA";
							}else{
								var dominio = "SS";
							}

							group.dominio = dominio;
							group.usabilidadModelo = porcentajeUsabilidad;

						}, function(error){
							console.log(error);
						});

					});

				});
	      });

	      $scope.groups = groups;

	    });

	    $scope.view = function(group){
	      $window.location.href = '/cve/teacher/analisis-uso/groups/' + group.id;
	    }


	    $scope.delete = function(group){
	      AnalisisFactory.deleteByGroup( {group_id: group.id} , function(response){
	      	$window.location.href = '/cve/teacher/analisis-uso';
	      });
	    }


  	}]);

	app.controller('AnalisisUsoController',['$scope', '$window', 'AnalisisFactory', '$attrs', 'HabClasses', function($scope, $window, AnalisisFactory, $attrs, HabClasses){
		var idGrupo = $attrs.id;
		
		AnalisisFactory.getForGroup({id: idGrupo}, function (analisis) {
			$scope.analisis = analisis;
		});



	}]);

})();

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

	    $scope.viewClasses = function(group){
	      	$window.location.href = '/cve/teacher/analisis-uso/groups/' + group.id + '/clases';
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


	app.controller('AnalisisPorClasesController',['$scope', 'Groups', '$window', 'AnalisisFactory', 'HabClasses', 'Activities', '$attrs',
		function($scope, Groups, $window, AnalisisFactory, HabClasses, Activities, $attrs){

		var idGrupo = $attrs.id;

		AnalisisFactory.activeIndicatorsForGroup({id: idGrupo}, function (analisis) { //Analisis activos para grupo Id.

			var objetoAgrupadoPorClases = _.groupBy(analisis, 'id_clase');
			var arregloAgrupadoPorClases = _.values(objetoAgrupadoPorClases);

			Activities.getFirstForGroup({group_id: idGrupo}, function(activity){ 

				var id_model = activity.id_modelo;

				HabClasses.allForModel({model_id: id_model}, function(clasesDelModelo){ //Obteniendo todas las clases del modelo para grupo Id

					var agrupados = _.map(arregloAgrupadoPorClases, function(porClase){
					 	
					 	var clasesUnicasDelIndicador = _.uniq(porClase, "id_indicador");

						var id_clase = clasesUnicasDelIndicador[0].id_clase;

					 	var claseDelModelo = _.find(clasesDelModelo, function(clase) {
					 	  return clase.id == id_clase;
					 	});

						var porcentajeUsabilidadDelGrupo = 0;
					 	var numIndicadoresModelo = claseDelModelo.indicators.length;

					 	if(numIndicadoresModelo != 0){
					 		porcentajeUsabilidadDelGrupo = clasesUnicasDelIndicador.length / numIndicadoresModelo;
					 	}

					 	if(porcentajeUsabilidadDelGrupo < .7){
					 		var dominio = "NS";
					 	}else if(porcentajeUsabilidadDelGrupo >= .7 && porcentajeUsabilidadDelGrupo < .8){
					 		var dominio = "S";
					 	}else if(porcentajeUsabilidadDelGrupo >= .8 && porcentajeUsabilidadDelGrupo < .9){
					 		var dominio = "SA";
					 	}else{
					 		var dominio = "SS";
					 	}

					 	return {
					 		id_clase: id_clase,
					 		clase_subnombre: claseDelModelo.subnombre,
					 		porcentajeUsabilidadDelGrupo: porcentajeUsabilidadDelGrupo,
					 		dominio: dominio
					 	};

					});
					
					$scope.analisisPorGrupo = agrupados;

				}, function(error){
					console.log(error);
				});

			});

		});

  	}]);

})();

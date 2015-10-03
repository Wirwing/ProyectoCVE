(function(){

	var app = angular.module('analisisController', ['analisisFactory']);

	app.controller('AnalisisGroupsController',['$scope', 'Groups', '$window', 'AnalisisFactory', 'HabClasses', 'Activities',
		function($scope, Groups, $window, AnalisisFactory, HabClasses, Activities){

	    Groups.all({}, function (groups) {

	      groups.forEach(function(group){

				AnalisisFactory.activeIndicatorsForGroup({id: group.id}, function (analisis) {

					group.frecuenciaDeGrupo = _.sum(analisis, 'ifrecuencia');

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

	    $scope.viewAlumnos = function(group){
	      	$window.location.href = '/cve/teacher/analisis-uso/groups/' + group.id + '/alumnos';
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
					generateChart(agrupados)

				}, function(error){
					console.log(error);
				});

			});

		});

		var generateChart = function(analisisPorGrupo){
			
			var chartValues = _.map(analisisPorGrupo, function(analisisDeGrupo){
				return {
					"label": analisisDeGrupo.clase_subnombre,
					"value": analisisDeGrupo.porcentajeUsabilidadDelGrupo
				}
			});

			console.log(chartValues);
			$scope.chartData = [{
	                	key: "Participación",
	                	color: "#1f65b4",
	                	values: chartValues
    		}];

    		$scope.chartOptions = {
	            chart: {
	                type: 'discreteBarChart',
	                height: 400,
	                x: function(d){return d.label;},
	                y: function(d){return d.value;},
	                showControls: true,
	                showValues: true,
	                transitionDuration: 500,
	                xAxis: {
	                    showMaxMin: false,
	                    axisLabel: 'Subclases'
	                },
	                yAxis: {
	                    axisLabel: '% Usabilidad',
	                    tickFormat: function(d){
	                        return d3.format(',.2f')(d);
	                    }
	                }
	            }
	        };

			//Generando values de grafica
// {
//             "key": "Participación",
//             "color": "#1f65b4",
//             "values": [
//                  {
//                      "label" : "Alumno 1" ,
//                      "value" : 23.307646510375
//                  } ,
//                  {
//                      "label" : "Alumno 2" ,
//                      "value" : 15.756779544553
//                  } ,
//                  {
//                      "label" : "Alumno 3" ,
//                      "value" : 10.451534877007
//                  }
//             	]
//         	}

		};

  	}]);


	app.controller('AnalisisPorAlumnoController',['$scope', '$window', 'AnalisisFactory', '$attrs', 'Users', function($scope, $window, AnalisisFactory, $attrs, Users){
		var idGrupo = $attrs.id;
		
		AnalisisFactory.getForGroup({id: idGrupo}, function (analisis) {

			var agrupadoPorAlumnos = _.chain(analisis).groupBy('id_usuario').values().value();

			var alumnos = _.map(agrupadoPorAlumnos, function(alumno){

				var frecuenciaDeAlumno = _.sum(alumno, 'ifrecuencia');

				return{
					nombre: alumno[0].alumno_nombre,
					frecuencia: frecuenciaDeAlumno
				};

			});

			$scope.alumnos = alumnos;
			generateChart(alumnos);

		});

		var generateChart = function(alumnos){
			console.log(alumnos);

			var chartValues = _.map(alumnos, function(alumno){
				return {
					"label": alumno.nombre,
					"value": alumno.frecuencia
				}
			});

			console.log(chartValues);
			$scope.chartData = [{
	                	key: "Participación",
	                	color: "#1f65b4",
	                	values: chartValues
    		}];

    		$scope.chartOptions = {
	            chart: {
	                type: 'discreteBarChart',
	                x: function(d){return d.label;},
	                y: function(d){return d.value;},
	                showControls: true,
	                showValues: true,
	                transitionDuration: 500,
	                xAxis: {
	                    showMaxMin: false,
	                    axisLabel: 'Alumno'
	                },
	                yAxis: {
	                    axisLabel: 'Frecuencia',
	                    tickFormat: function(d){
	                        return d3.format(',.2f')(d);
	                    }
	                }
	            }
	        };

		};

	}]);

})();

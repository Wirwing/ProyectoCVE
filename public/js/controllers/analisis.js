(function(){

	var app = angular.module('analisisController', ['analisisFactory']);

	app.controller('AnalisisGroupsController',['$scope', 'Groups', '$window', function($scope, Groups, $window){

	    Groups.all({}, function (groups) {
	      $scope.groups = groups;
	    });

	    $scope.view = function(group){
	      $window.location.href = '/cve/teacher/analisis-uso/groups/' + group.id;
	    }

  	}]);

	app.controller('AnalisisUsoController',['$scope', '$window', 'AnalisisFactory', '$attrs', function($scope, $window, AnalisisFactory, $attrs){

		var idGrupo = $attrs.id;

		AnalisisFactory.getForGroup({id: idGrupo}, function (analisis) {
			$scope.analisis = analisis;
		});


	}]);

})();

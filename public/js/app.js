(function(){

	var app = angular.module('cve', [
			'activitiesController', 'modelsController',
			'groupsController', 'usersController',
			'chatController', 'nvd3ChartDirectives' //controllers
		]);

	$(document).ready(function(){angular.bootstrap(document.body , ['cve']);});

})();

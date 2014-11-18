(function(){

	var app = angular.module('cve', [
			'activitiesController', 'modelsController',
			'groupsController', 'usersController' //controllers
		]);

	$(document).ready(function(){angular.bootstrap(document.body , ['cve']);});

})();

(function(){

	//md.csc added chat_logsController
	var app = angular.module('cve', [
			'activitiesController', 'modelsController', 'analisisController',
			'groupsController', 'usersController', 'habClassesController',
			'analisisFactory',
			'chatController', 'nvd3',
			'ui.bootstrap'
		]);

	$(document).ready(function(){angular.bootstrap(document.body , ['cve']);});

})();

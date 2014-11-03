(function(){

	var app = angular.module('cve', [
		'activitiesController', 'modelsController' //controllers
		]);
	
	$(document).ready(function(){angular.bootstrap(document.body , ['cve']);});

})();
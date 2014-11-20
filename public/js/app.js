(function(){

	var app = angular.module('cve', [
		'activitiesController', 'modelsController','chatController' //controllers
		]);
	
	$(document).ready(function(){angular.bootstrap(document.body , ['cve']);});

})();
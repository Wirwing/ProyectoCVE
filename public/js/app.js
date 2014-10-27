(function(){

	var app = angular.module('cve', [
		'activitiesController', //controllers
		]);
	
	$(document).ready(function(){angular.bootstrap(document.body , ['cve']);});

})();
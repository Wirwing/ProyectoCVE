(function(){
	/*
	var app = angular.module('modelsController', ['modelsFactory']);
	app.controller('ModelsController',['$scope', 'Models', '$window', function($scope, Models, $window){

	Models.all({}, function (models) {
	$scope.models = models;
});
$scope.view = function(model){
$window.location.href = '/cve/interaction-models/' + model.id;
}
$scope.delete = function($index, model){
Models.remove({id: model.id}, function(){
$scope.models.splice($index, 1);
});
}
}]);
*/
var app = angular.module('chatController',[]);

app.controller('ChatController',function(){
	this.messages = messages;
	this.message = {};
	this.user = "jaime"
	this.addMessage = function(msgs){
		this.message.user = this.user;
		msgs.push(this.message);
		this.message = {};
		this.canSubmit = false;
		$anchorScroll();
	};

	this.showSubmit = function(){
		this.canSubmit = true;
	};
	this.canSubmit = false;
});

app.controller('ActivityController',['$scope', 'Activities', 'FileUploader', '$attrs', '$window',
function($scope, Activities, FileUploader, $attrs, $window){

	$scope.activity = Activities.get({id: $attrs.id});

	var uploader = $scope.uploader = new FileUploader({
		url: "/cve/api/activities/" + $attrs.id + '/files'
	});

	uploader.onSuccessItem = function(fileItem, response, status, headers) {
		$scope.activity.attachments.push(response);
	};

	$scope.downloadAttachment = function(attachment){
		$window.location.href = "/cve/api/activities/" + $attrs.id + '/files/' + attachment.id;
	}

	$scope.removeAttachment = function($index, attachment){

		Activities.deleteAttachment({id_activity: $attrs.id, id_file: attachment.id }, function (message) {
			$scope.activity.attachments.splice($index, 1);
		});

	}

	$scope.edit = function(){
		$window.location.href = "/cve/activities/" + $attrs.id + '/edit';
	}

	$scope.delete = function(){
		Activities.remove({id: $scope.activity.id}, function(){
			$window.location.href = '/cve/activities';
		});
	}

}]);

var messages = [
{
	user: 'jaime',
	body: 'hola',
},{
	user: 'mauricio',
	body: 'hola'
},{
	user: 'irving',
	body: 'hola'
},{
	user: 'jaime',
	body: 'que hay que hacer'
},{
	user: 'mauricio',
	body: 'crear un repo'
},{
	user: 'jaime',
	body: 'ok'
},{
	user: 'irving',
	body: 'ya los invite al repo'
}
];


})();

window.onload = function ()
{
  var firepadRef = new Firebase('https://cve.firebaseIO.com');
  
  var codeMirror = CodeMirror(document.getElementById('firepad'), { 
	  	lineWrapping: true,
	  	theme: 'monokai',
	    lineNumbers: true,
		mode: 'javascript' 
	});
  var firepad = Firepad.fromCodeMirror(firepadRef, codeMirror,
      {defaultText: '// JavaScript Editing with Firepad!\nfunction go() {\n var message = "Hello, world.";\n console.log(message);\n}' });
};
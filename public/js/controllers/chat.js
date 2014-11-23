(function(){
	
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

(function(){

	var app = angular.module('chatController',['ngCookies', 'chatsFactory', 'activitiesFactory', 'usersFactory', 'groupsFactory', 'luegg.directives']);


	app.controller('ChatController', ['$scope', 'Chats', 'Activities',
	'Users', 'Groups', '$window', '$cookies', '$interval',
	function($scope, Chats, Activities, Users, Groups, $window, $cookies, $interval){

		// We recover the user data from the session cookie
		$scope.user_id = $cookies.user_id;
		$scope.username = $cookies.username;
		$scope.role = $cookies.role;

		$scope.user = Users.get({id: $scope.user_id});

		Groups.getUserGroup({id: $scope.user_id}, function(group){
			$scope.group = group;
			$scope.activity = group.activity;


			/* Now we recover the previous messages */
			Chats.getPreviousMessages({group_id: $scope.group.id, activity_id: $scope.activity.id},
				function( messages ){
					$scope.messages = messages;
					if( $scope.messages != null && ( $scope.messages.length > 0 ) ){
						$scope.last_message_id = messages[ messages.length - 1 ].id;
					}


					/* now with the previous messages we call the refresh interval */
					$interval(function(){
						Chats.getMessages({group_id: $scope.group.id, activity_id: $scope.activity.id, last_chat_id: $scope.last_message_id },
							function(messages ){
								if( messages != null && ( messages.length > 0 ) ){
									if( !$scope.last_message_id || ( $scope.last_message_id < messages[0].id ) ){
										$scope.last_message_id = messages[ messages.length - 1 ].id;
										$scope.messages = $scope.messages.concat( messages );
									}
								}
							});
						}, 500 /* every 500 milliseconds */, 0 /* repeat indefinitely */);

					}
				);
			});

			$scope.addMessage = function(){
				var message_recipent = {};

				message_recipent.id_grupo = $scope.group.id;
				message_recipent.id_usuario = $scope.user.id;
				message_recipent.id_actividad = $scope.activity.id;
				message_recipent.id_indicador = $scope.selectedIndicator.id;

				//We sent the actual moment
				message_recipent.fecha = new Date();
				message_recipent.message = $scope.message;

				// We send the message asynchrounsly
				Chats.sendMessage({}, message_recipent);

				//hides the chat form
				$scope.canSubmit = false;

				//$anchorScroll();
			};

			$scope.parseTime = function( messageStringTime ){
				return  new Date( messageStringTime ).toLocaleTimeString();
			};

			/* inhabilitates the chat submission */
			$scope.showSubmit = function( indicator ){
				$scope.canSubmit = true;
				$scope.selectedIndicator = indicator;
			};

			$scope.canSubmit = false;


			var values = [
			{
				"key" : "Duda",
				"bar": true,
				"values" : [ [ 1 , 81.89] , [ 2 , 85.51] , [3 , 78.49] , [ 4 , 82.72] , [ 5 , 80.39] , [ 6 , 39.77] , [ 7 , 28.27] , [ 8 , 57.96] , [ 9 , 107.85] , [ 10 , 86.98] ]
			},
			{
				"key" : "Argumento",
				"bar": true,
				"values" : [ [ 1 , 71.89] , [ 2 , 75.51] , [3 , 68.49] , [ 4 , 62.72] , [ 5 , 70.39] , [ 6 , 59.77] , [ 7 , 57.27] , [ 8 , 67.96] , [ 9 , 67.85] , [ 10 , 76.98] ]
			},
			{
				"key" : "Idea",
				"bar": true,
				"values" : [ [ 1 , 11.89] , [ 2 , 25.51] , [3 , 38.49] , [ 4 , 16.72] , [ 5 , 20.39] , [ 6 , 38.77] , [ 7 , 27.27] , [ 8 , 17.96] , [ 9 , 97.85] , [ 10 , 42.98] ]
			},
			{
				"key" : "Pregunta",
				"bar": true,
				"values" : [ [ 1 , 21.89] , [ 2 , 35.51] , [3 , 88.49] , [ 4 , 36.72] , [ 5 , 40.39] , [ 6 , 8.77] , [ 7 , 7.27] , [ 8 , 87.96] , [ 9 , 7.85] , [ 10 , 2.98] ]
			}
			];

			$scope.exampleData = values;

		}]);

		window.onload = function (){
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



		})();

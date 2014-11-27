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

		$scope.interval_time = 0;
		$scope.data_pass = 0;

		$scope.values = [];

		$scope.updateTable = function(){
			if( !$scope.messages || $scope.messages.length == 0 ){
				/* we don't have any data */
				return;
			}

			var indicators = $scope.activity.model.indicators;

			for( var i = 0; i < indicators.length; i ++  ){
				var indicator = indicators[i];
				indicator.total = $scope.getPercentageOfMessagesOfIndicator( indicator.id );
			}

			if( $scope.values.length == 0 ){
				$scope.values = [];
				for( var i = 0; i < indicators.length; i ++  ){
					var indicator = indicators[i];
					$scope.values.push(
						{
							"key" : indicator.nombre,
							"bar" : true,
							"values": [ [ $scope.data_pass, indicator.total ]]
						}
					);
				}
			}else{
				for( var i = 0; i < indicators.length; i ++ ){
					var indicator = indicators[i];
					$scope.values[i].values.push( [ $scope.data_pass, indicator.total]);
				}
			}

			//Update
			nv.graphs[0].update();
	  };

		$scope.getPercentageOfMessagesOfIndicator = function( indicator_id ){
			var total = 0;
			var messages = $scope.messages;
			for( var i = 0; i < messages.length; i ++ ){
				var message = messages[i];
				if( message.indicator.id == indicator_id ){
					total ++;
				}
			}

			var percentage = (total * 100) / messages.length;
			return percentage.toFixed(2);
		}

		Groups.getUserGroup({id: $scope.user_id}, function(group){
			$scope.group = group;
			$scope.activity = group.activity;

			/* Now we recover the previous messages */
			Chats.getPreviousMessages({group_id: $scope.group.id, activity_id: $scope.activity.id},
				function( messages ){
					$scope.messages = messages;
					$scope.updateTable();
					$scope.data_pass ++;

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

								$scope.interval_time += 500;
								// Every 5 seconds we update the table
								if( ($scope.interval_time % 5000) === 0 ){
									$scope.updateTable();
									$scope.data_pass ++;
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
				$scope.message = "";
				//hides the chat form
				$scope.canSubmit = false;
			};

			$scope.parseTime = function( messageStringTime ){
				return new Date( messageStringTime ).toLocaleTimeString();
			};

			/* inhabilitates the chat submission */
			$scope.showSubmit = function( indicator ){
				$scope.canSubmit = true;
				$scope.selectedIndicator = indicator;
			};

			$scope.canSubmit = false;

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

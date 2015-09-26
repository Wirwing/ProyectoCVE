(function(){

	var app = angular.module('chatController',['ngCookies', 'chatsFactory', 'activitiesFactory', 'usersFactory', 'groupsFactory', 'luegg.directives','timer']);


	app.controller('ChatController', ['$scope', 'Chats', 'Activities',
		'Users', 'Groups', '$window', '$cookies', '$interval',
		function($scope, Chats, Activities, Users, Groups, $window, $cookies, $interval){

		// We recover the user data from the session cookie
		$scope.user_id = $cookies.user_id;
		$scope.username = $cookies.username;
		$scope.role = $cookies.role;
		$scope.session_id = $cookies.session_id;

		console.log("Sesion " + $scope.session_id);

		$scope.user = Users.get({id: $scope.user_id});

		$scope.interval_time = 0;
		$scope.data_pass = 0;

		$scope.values = [];

		$scope.updateTable = function(){

			if( !$scope.messages || $scope.messages.length == 0 ){
				/* we don't have any data */
				return;
			}

			var indicators = new Array();
			var classes = $scope.activity.model.classes;

			for( var x = 0; x < classes.length; x ++ ){
				indicators = indicators.concat( classes[x].indicators );
			}

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

		/*
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
		*/

		Groups.getUserGroup({id: $scope.user_id}, function(group){
			
			$scope.group = group;
			$scope.activity = group.activity;

			var currentDateTime = new Date();
			var dateLimit = convertUTCDateToLocalDate(new Date($scope.activity.fecha_limite.toString()));

			$scope.timeLimit = Math.floor((dateLimit - currentDateTime)/1000);
			if($scope.timeLimit < 0){
				$scope.timeLimit = 1;
			}
			if($scope.activity.iniciada == 1){
				$scope.timerRunning = true;
			}else{
				$scope.timerRunning = false;
			}

			//Show Graphs
			Chats.all({group_id: $scope.group.id, activity_id: $scope.activity.id}, function(messages){
				
				//console.log(messages);
				//var students = _.groupBy(messages, 'id_usuario');

				//Generando values de grafica
				// {
    //             "key": "Participación",
    //             "color": "#1f65b4",
    //             "values": [
	   //                  {
	   //                      "label" : "Alumno 1" ,
	   //                      "value" : 23.307646510375
	   //                  } ,
	   //                  {
	   //                      "label" : "Alumno 2" ,
	   //                      "value" : 15.756779544553
	   //                  } ,
	   //                  {
	   //                      "label" : "Alumno 3" ,
	   //                      "value" : 10.451534877007
	   //                  }
    //             	]
    //         	}

				var students = _.chain(messages).groupBy('id_usuario').map(function(value, key) {
					var user = value[0].user;
				    return {
				        label: user.nombre,
				        value: value.length
				    }
				})
				.value();

				console.log(students);
			});

		});

		$scope.addMessage = function(){

			var message_recipent = {};

			message_recipent.id_grupo = $scope.group.id;

				//ad.csc message_recipent.id_sesion = $scope.sesion.id;
				message_recipent.id_usuario = $scope.user.id;
				message_recipent.id_actividad = $scope.activity.id;
				message_recipent.id_indicador = $scope.selectedIndicator.id;
				message_recipent.id_clase = $scope.selectedClass.id;

				//We sent the actual moment
				message_recipent.fecha = new Date();
				message_recipent.message = $scope.message;

				message_recipent.id_sesion = $scope.session_id;

				// We send the message asynchrounsly
				Chats.sendMessage({}, message_recipent);
				$scope.message = "";
				
				//hides the chat form
				$scope.canSubmit = false;

		};

		$scope.addElementMessage = function(idClass){
				
				var message_recipent = {};

				message_recipent.id_grupo = $scope.group.id;
				//ad.csc message_recipent.id_sesion = $scope.sesion.id;
				message_recipent.id_usuario = $scope.user.id;
				message_recipent.id_actividad = $scope.activity.id;

				//Indicador 0
				message_recipent.id_indicador = 0;
				message_recipent.id_clase = idClass;

				//We sent the actual moment
				message_recipent.fecha = new Date();
				message_recipent.message = $scope.message;

				message_recipent.id_sesion = $scope.session_id;

				// We send the message asynchrounsly
				Chats.sendElement({}, message_recipent);
				$scope.message = "";
				//hides the chat form
				$scope.canSubmit = false;
				
		};

		$scope.parseTime = function( messageStringTime ){
				return new Date( messageStringTime ).toLocaleTimeString();
		};

		/* inhabilitates the chat submission */
		$scope.showSubmit = function( indicator, abClass ){
				$scope.canSubmit = true;
				$scope.message = indicator.apertura;
				$scope.selectedIndicator = indicator;
				$scope.selectedClass = abClass;
		};

		$scope.canSubmit = false;
		$scope.canShowTimer = false;

		$scope.startTimer = function (){
			$scope.$broadcast('timer-start');
			$scope.timerRunning = true;
			$scope.activity.iniciada = 1;
			var tempDate = new Date();
			$scope.activity.fecha_limite = new Date(tempDate.getTime() + $scope.activity.duracion_minima*60000);
			
			alert($scope.activity.fecha_limite + " id: " +  $scope.activity.id);
			
			Activities.update({id: $scope.activity.id}, $scope.activity, function () {
				$window.location.href = '/cve/teacher/activities/' + activity.id;
			});
			$scope.canShowTimer = true;
		};

		$scope.showTimer = function (){
			$scope.$broadcast('timer-start');
			$scope.canShowTimer = true;
		};

		function convertUTCDateToLocalDate(date) {
			var newDate = new Date(date.getTime());
			var offset = (date.getTimezoneOffset()+60) / 60;
			var hours = date.getHours();
			newDate.setHours(hours + offset);
			return newDate;   
		}
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
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
		$scope.showStats = false;

		$scope.canSubmit = false;
		$scope.canShowTimer = false;

		//Configuracion grafica nvd3
		$scope.chartOptions = {
            chart: {
                type: 'multiBarHorizontalChart',
                height: 200,
                width: 500,
                x: function(d){return d.label;},
                y: function(d){return d.value;},
                showControls: true,
                showValues: true,
                transitionDuration: 500,
                xAxis: {
                    showMaxMin: false
                },
                yAxis: {
                    axisLabel: 'Participación',
                    tickFormat: function(d){
                        return d3.format(',.2f')(d);
                    }
                }
            }
        };

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

		/* inhabilitates the chat submission */
		$scope.showSubmit = function( indicator, abClass ){
			$scope.canSubmit = true;
			$scope.message = indicator.apertura;
			$scope.selectedIndicator = indicator;
			$scope.selectedClass = abClass;
		};

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

		$scope.collapseStats = function(){
			$scope.showStats = !$scope.showStats;
		}

		$scope.parseTime = function( messageStringTime ){
			return new Date( messageStringTime ).toLocaleTimeString();
		};

		function convertUTCDateToLocalDate(date) {
			var newDate = new Date(date.getTime());
			var offset = (date.getTimezoneOffset()+60) / 60;
			var hours = date.getHours();
			newDate.setHours(hours + offset);
			return newDate;
		}

		var refreshGraph = function(){

			//Show Graphs
			Chats.all({group_id: $scope.group.id, activity_id: $scope.activity.id}, function(messages){

					var chartValues = _.chain(messages).groupBy('id_usuario').map(function(value, key) {
						var user = value[0].user;
					    return {
					        label: user.nombre,
					        value: value.length
					    }
					})
					.value();

					console.log(chartValues);

					$scope.chartData = [{
	                	key: "Participación",
	                	color: "#1f65b4",
	                	values: chartValues
	        		}];

			});

		};

		var pullMessages = function(){

			Chats.all({group_id: $scope.group.id, activity_id: $scope.activity.id}, function(messages){
				$scope.messages = messages;

				//$scope.$apply(function (scope) {
      		    $("#chat_container").scrollTop(1000000);
           		//});

			});

		};

		var init = function(){

			Groups.getUserGroup({id: $scope.user_id}, function(group){
				
				$scope.group = group;
				$scope.activity = group.activity;

				var currentDateTime = new Date();
				var dateLimit = convertUTCDateToLocalDate(new Date($scope.activity.fecha_limite.toString()));

				$scope.timeLimit = Math.floor((dateLimit - currentDateTime)/1000);
				
				if($scope.timeLimit < 0)
					$scope.timeLimit = 1;

				if($scope.activity.iniciada == 1)
					$scope.timerRunning = true;
				else
					$scope.timerRunning = false;
				
				//Populate graph and update it every minute
				refreshGraph();
				$interval(refreshGraph, 1000 * 60 , 0);

				//Pull message every n seconds
				pullMessages();
				$interval(pullMessages, 1000 * 3 , 0);

			});

		};

		init();

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

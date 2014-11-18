(function(){

  var app = angular.module('usersController', ['usersFactory']);

  app.controller('UsersController',['$scope', 'Users', '$window', function($scope, Users, $window){

    Users.all({}, function (activities) {
      $scope.users = users; 
    });

  }]);

})();

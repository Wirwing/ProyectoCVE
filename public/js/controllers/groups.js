(function(){

  var app = angular.module('groupsController', ['groupsFactory', 'usersFactory']);

  app.controller('GroupsController',['$scope', 'Groups', '$window', function($scope, Groups, $window){

    Groups.all({}, function (groups) {
      $scope.groups = groups;
    });

    $scope.view = function(group){
      $window.location.href = '/cve/groups/' + group.id;
    }

    $scope.delete = function($index, group){
      Groups.remove({id: group.id}, function(){
        $scope.groups.splice($index, 1);
      });
    }

  }]);

  app.controller('GroupController',['$scope','Groups', 'Users', '$window',
  function($scope, Groups, Users, $window){

    $scope.group = Groups.get({id: $attrs.id});

    $scope.edit = function(){
      $window.location.href = "/cve/groups/" + $attrs.id + "/edit";
    }

    $scope.delete = function(){
      Groups.remove({id: group.id}, function(){
        $window.location.href = "/cve/groups";
      });
    }

  }]);

  app.controller('AddGroupController',['$scope','Groups', 'Users', '$window',
  function($scope, Groups, Users, $window){

    Users.all({}, function(availableUsers){
      $scope.users = availableUsers;
    });

    //Initial value
    $scope.check = 0;
    $scope.limit = 3;

    $scope.onStudentChecked = function( student ){
      if( student.selected ){
        $scope.check ++;

        if( !$scope.group.selected_users ){
          $scope.group.selected_users = [];
        }

        $scope.group.selected_users.push( student.id );
      }else{
        $scope.check --;
      }
    }

    this.add = function(group){
      if( group.selected_users < $scope.limit ){
        alert("Elige por lo menos a 3 usuarios");
        return;
      }

      //TODO: Replace tutor id with session values
      group.fecha = new Date();
      group.id_tutor = 1;

      Groups.create({}, group, function (created) {
        $window.location.href = '/cve/groups/' + created.id;
      });
    }

  }]);

  app.controller('EditGroupController',['$scope', 'Groups','Users', '$attrs', '$window',
  function($scope, Groups, Users, $attrs, $window){

    $scope.group = Groups.get({id: $attrs.id});

    $scope.edit = function(){
      $window.location.href = "/cve/groups/" + $attrs.id + '/edit';
    }

    $scope.delete = function(){
      Groups.remove({id: $scope.group.id}, function(){
        $window.location.href = '/cve/groups';
      });
    }

  }]);


})();

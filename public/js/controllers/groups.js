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

  app.controller('GroupController',['$scope','Groups', 'Users','$attrs', '$window',
  function($scope, Groups, Users, $attrs, $window){

    $scope.group = Groups.get({id: $attrs.id});

    $scope.edit = function(){
      $window.location.href = "/cve/groups/" + $attrs.id + "/edit";
    }

    $scope.delete = function(){
      Groups.remove({id: $scope.group.id}, function(){
        $window.location.href = "/cve/groups";
      });
    }

  }]);

  app.controller('AddGroupController',['$scope','Groups', 'Users', '$window',
  function($scope, Groups, Users, $window){

    $scope.group = {};

    Users.available({}, function(availableUsers){
      $scope.users = availableUsers;
    });

    // preserves the number of students selected
    $scope.check = 0;
    $scope.limit = 2;

    $scope.onStudentChecked = function( student ){
      if( student.selected ){
        $scope.check ++;
      }else{
        $scope.check --;
      }
    }

    this.add = function( group){
      if( $scope.check < $scope.limit ){
        alert("Elige por lo menos a 2 usuarios");
        return;
      }

      //TODO: Replace tutor id with session values
      group.fecha = new Date();
      group.id_tutor = 1;
      group.num_integrantes = $scope.check;

      group.selected_users = [];
      for( var i = 0; i < $scope.users.length; i++ ){
        var user = $scope.users[i];
        if( user.selected ){
            group.selected_users.push( user.id );
        }
      }

      Groups.create({}, group, function (created) {
        $window.location.href = '/cve/groups/' + created.id;
      });
    }

  }]);

  app.controller('EditGroupController',['$scope', 'Groups','Users', '$attrs', '$window',
  function($scope, Groups, Users, $attrs, $window){

    $scope.check = 0;
    $scope.limit = 2;

    $scope.group = Groups.get({id: $attrs.id}, function(group){
      $scope.group = group;

      Users.all({}, function( users ){
        var prev_group_users = $scope.group.users;
        $scope.users = users;

        /* selects the users from the group */
        for( var i = 0; i < $scope.users.length; i ++ ){
          for( var k = 0; k < prev_group_users.length; k ++ ){
            if( prev_group_users[k].id == $scope.users[i].id ){
              $scope.users[i].selected = true;
              $scope.check ++;
              break;
            }
          }
        }

        delete $scope.group.users;
      });
    });

    $scope.onStudentChecked = function( student ){
      if( student.selected ){
        $scope.check ++;
      }else{
        $scope.check --;
      }
    }

    this.save = function( group ){
      group.fecha = new Date();
      group.num_integrantes = $scope.check;

      group.selected_users = [];
      for( var i = 0; i < $scope.users.length; i++ ){
        var user = $scope.users[i];
        if( user.selected ){
            group.selected_users.push( user.id );
        }
      }

      Groups.update({id: group.id}, group, function(response){
        $window.location.href = "/cve/groups/" + group.id;
      });
    }

    $scope.delete = function(){
      Groups.remove({id: $scope.group.id}, function(){
        $window.location.href = '/cve/groups';
      });
    }

  }]);


})();

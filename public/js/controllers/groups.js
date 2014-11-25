(function(){

  var app = angular.module('groupsController', ['groupsFactory', 'usersFactory', 'activitiesFactory']);

  app.controller('GroupsController',['$scope', 'Groups', '$window', function($scope, Groups, $window){

    Groups.all({}, function (groups) {
      $scope.groups = groups;
    });

    $scope.view = function(group){
      $window.location.href = '/cve/teacher/groups/' + group.id;
    }

    $scope.delete = function($index, group){
      Groups.remove({id: group.id}, function(){
        $scope.groups.splice($index, 1);
      });
    }

  }]);

  app.controller('GroupController',['$scope','Groups', 'Users','$attrs', '$window',
  function($scope, Groups, Users, $attrs, $window){

    Groups.getActivity({id: $attrs.id}, function(activities){
      $scope.activity = activities[0];
    });


    $scope.group = Groups.get({id: $attrs.id});

    $scope.edit = function(){
      $window.location.href = "/cve/teacher/groups/" + $attrs.id + "/edit";
    }

    $scope.delete = function(){
      Groups.remove({id: $scope.group.id}, function(){
        $window.location.href = "/cve/teacher/groups";
      });
    }

  }]);

  app.controller('AddGroupController',['$scope','Groups', 'Users','Activities', '$window',
  function($scope, Groups, Users, Activities, $window){

    $scope.group = {};

    Activities.all({},function(activities){
      $scope.activities = activities;
      $scope.selectedActivity = activities[0];
    });

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

    $scope.cancel = function(){
      $window.location.href = '/cve/teacher/groups';
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

      if($scope.selectedActivity){
        group.activity_id = $scope.selectedActivity.id;
      }
      
      Groups.create({}, group, function (created) {
        $window.location.href = '/cve/teacher/groups/' + created.id;
      });
    }

  }]);

  app.controller('EditGroupController',['$scope', 'Groups','Users', 'Activities', '$attrs', '$window',
  function($scope, Groups, Users, Activities, $attrs, $window){

    Activities.all({},function(activities){
      $scope.activities = activities;
      Groups.getActivity({id: $attrs.id}, function(selected){
        $scope.selectedActivity = selected[0];
      });
    });

    $scope.check = 0;
    $scope.limit = 2;

    $scope.group = Groups.get({id: $attrs.id}, function(group){
      $scope.group = group;

      Users.available({}, function( availableUsers ){
        $scope.users = availableUsers;
        var group_users = $scope.group.users;

        for( var i = 0; i < group_users.length; i ++ ){
            var group_user = group_users[i];
            group_user.selected = true;
            $scope.users.push( group_user );
            $scope.check++;
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

    $scope.cancel = function(){
      $window.location.href = '/cve/teacher/groups';
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

      if($scope.selectedActivity){
        group.activity_id = $scope.selectedActivity.id;
      }

      Groups.update({id: group.id}, group, function(response){
        $window.location.href = "/cve/teacher/groups/" + group.id;
      });
    }

    $scope.delete = function(){
      Groups.remove({id: $scope.group.id}, function(){
        $window.location.href = '/cve/teacher/groups';
      });
    }

  }]);


})();

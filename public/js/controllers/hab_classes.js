(function(){

    var app = angular.module('habClassesController', ['habClassesFactory']);

    app.controller('HabClassesController',['$scope', 'HabClasses', '$window', function($scope, HabClasses, $window){

        HabClasses.all({}, function ( habClasses ) {
            $scope.habClasses = habClasses;
        });

        $scope.view = function(habClass){
            $window.location.href = '/cve/teacher/hab_classes/' + habClass.id;
        }

        $scope.delete = function($index, habClass){
            HabClasses.remove({id: habClass.id}, function(){
                $scope.habClasses.splice($index, 1);
            });
        }

    }]);

    app.controller('AddHabClassController',['HabClasses', '$scope', '$window', function(HabClasses, $scope, $window){

        $scope.habClass = {};

        // fixed model
        $scope.habClass.model_id = 1;

        $scope.habClass.indicators = [
        {nombre: "Argumento", apertura: "Hola 1"},
            {nombre: "Idea", apertura: "Hola 2"},
            {nombre: "Duda", apertura: "Hola 3"},
            {nombre: "Pregunta", apertura: "Hola 4"}
        ];
            /*{nombre: "Argumento", apertura: "Hola 1", frecuencia_individual: 0, frecuencia_grupo: 0, tolerancia: 0},
            {nombre: "Idea", apertura: "Hola 2", frecuencia_individual: 0, frecuencia_grupo: 0, tolerancia: 0},
            {nombre: "Duda", apertura: "Hola 3",frecuencia_individual: 0, frecuencia_grupo: 0, tolerancia: 0},
            {nombre: "Pregunta", apertura: "Hola 4",frecuencia_individual: 0, frecuencia_grupo: 0, tolerancia: 0}
        ];*/

        this.add = function(habClass){
            HabClasses.create({}, habClass, function (created) {
                $window.location.href = '/cve/teacher/hab_classes/' + created.id;
            });
        }

        $scope.cancel = function(){
            $window.location.href = "/cve/teacher/hab_classes";
        }

    }]);

    app.controller('HabClassController',['$scope', 'HabClasses', '$attrs', '$window',
        function($scope, HabClasses, $attrs, $window){

            $scope.habClass = HabClasses.get({id: $attrs.id});

            $scope.edit = function(){
                $window.location.href = "/cve/teacher/hab_classes/" + $attrs.id + '/edit';
            }

            $scope.delete = function(){
                HabClasses.remove({id: $scope.habClass.id }, function(){
                    $window.location.href = '/cve/teacher/hab_classes';
                });
            }

        }]);

    app.controller('EditHabClassController',['HabClasses', '$scope', '$attrs', '$window',
        function(HabClasses, $scope, $attrs, $window){

            $scope.habClass = HabClasses.get({id: $attrs.id});

            $scope.cancel = function(){
                $window.location.href = "/cve/teacher/hab_classes";
            }

            $scope.update = function(){
                HabClasses.update({id: $scope.habClass.id}, $scope.habClass, function () {
                    $window.location.href = '/cve/teacher/hab_classes/' + $scope.habClass.id;
                });
            }

        }]);


})();

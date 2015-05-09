<?php

require 'vendor/autoload.php';

ActiveRecord\Config::initialize(function($cfg)
{
   $cfg->set_model_directory('models');
   $cfg->set_connections(
     array(
       'development' => 'mysql://root:@localhost/db_cve_fmat_uady'
     )
   );
});

// Prepare app
$app = new \Slim\Slim(array(
    'templates.path' => 'templates',
    'cookies.encrypt' => false,
    'cookies.lifetime' => time() + (1*24*60*60), // 1 day
));

/*
// todo un encrypt cookies
Enctypted cookies
$app = new \Slim\Slim(array(
'templates.path' => 'templates',
'cookies.encrypt' => true,
'cookies.lifetime' => time() + (1*24*60*60), // 1 day
'cookies.cipher' => MCRYPT_RIJNDAEL_256,
'cookies.cipher_mode' => MCRYPT_MODE_CBC
));
*/

//Set Mime Type Middleware
$app->add(new \Slim\Middleware\ContentTypes());

// Create monolog logger and store logger in container as singleton
// (Singleton resources retrieve the same log resource definition each time)
$app->container->singleton('log', function () {
    $log = new \Monolog\Logger('slim-skeleton');
    $log->pushHandler(new \Monolog\Handler\StreamHandler('logs/app.log', \Monolog\Logger::DEBUG));
    return $log;
});

// Prepare view
$app->view(new \Slim\Views\Twig());
$app->view->parserOptions = array(
    'charset' => 'utf-8',
    'cache' => realpath('templates/cache'),
    'auto_reload' => true,
    'strict_variables' => false,
    'autoescape' => true
);
$app->view->parserExtensions = array(new \Slim\Views\TwigExtension());

$twig_instance = $app->view->getInstance();
$lexer = new Twig_Lexer($twig_instance, array(
    'tag_comment'   => array('[#', '#]'),
    'tag_block'     => array('[%', '%]'),
    'tag_variable'  => array('[[', ']]'),
    'interpolation' => array('#[', ']'),
));
$twig_instance->setLexer($lexer);

// Define routes
$app->get('/', function () use ($app) {
    //We check if the user has a valid cookie
    $cookieRole = $app->getCookie('role');
    if(is_null($cookieRole)){
      $app->redirect("/cve/login");
      return;
    }

    switch ( @$cookieRole ) {
      case 1:
        $app->redirect("/cve/teacher/activities");
        break;
      case 2:
        $app->redirect("/cve/student/chat");
        break;
      default:
        $app->redirect("/cve/login");
        break;
    }

});

 $auth = function($role = 'member'){
  return function() use ($role){

    $app = \Slim\Slim::getInstance();
    $cookieRole = $app->getCookie('role');

    if(is_null($role)){
      $app->redirect("/cve/login");
      return;
    }

    if( ( $role == "teacher" && $cookieRole != 1 ) ||
        ( $role == "student" && $cookieRole != 2 ) ){
          $app->redirect("/cve/login");
    }

  };
};


$app->map("/login", function() use ($app) {
  if($app->request()->isPost()){
    //If valid login, set auth cookie and redirect
    $post = $app->request()->post();
    $username = $post['username'];
    $password = $post['password'];

    if( !is_null($username) && !is_null($password) ){

      $user = User::find('first', array('conditions' => array('usuario = ? AND password = ?', $username, $password)));
      if( is_null($user) ){
        $app->redirect("/cve/login");
        return;
      }

      $app->setCookie('username', $username);
      $app->setCookie('user_id', $user->id);
      $app->setCookie('role', $user->tipo);

      //Set session id
      $length = 10;
      $original_string = array_merge(range(0,9), range('a','z'), range('A', 'Z'));
      $original_string = implode("", $original_string);
      $session_id = substr(str_shuffle($original_string), 0, $length);

      $app->setCookie('session_id', $session_id);

      //Verificando tipo de alumno
      $userType = $user->tipo;
      if( $userType == 1 ){
        /* maestro */
        $app->redirect("/cve/teacher/activities");
      }else{
        /* estudiante */

        //Creando matriz de analisis de uso
        $group_user = GroupUser::find('first', array('conditions' => array('user_id = ?', $user->id)));
        $activity = $group_user->activity;
        $model = $activity->model;
        $classes = $model->classes;

        foreach ($classes as $class) {

          $indicators = $class->indicators;

          foreach ($indicators as $indicator) {

            $attributes = array(
              'id_grupo' => $group_user->group_id,
              'id_sesion' => $session_id, 
              'id_usuario' => $user->id, 
              'id_modelo' => $model->id, 
              'id_clase' => $class->id,
              'id_indicador' => $indicator->id, 
              'bUso' => 0,
              'ifrecuencia' => 0
            );

            $dato = new AnalisisUso($attributes);
            $dato->save();

          }

        }

        $app->redirect("/cve/student/chat");
      }
    }else{
      $app->redirect("/cve/login");
    }
  }

  $app->render("login.html");
})->via('GET', 'POST');

$app->get('/logout', function () use ($app) {
  //Remove the cookie and redirect to login page
  $app->deleteCookie('username');
  $app->deleteCookie('user_id');
  $app->deleteCookie('role');
  $app->deleteCookie('session_id');

  $app->redirect("/cve/login");
});


// Define routes
require_once "routes/routes.php"; //include the file which contains all the routes/route inclusions

// Run app
$app->run();

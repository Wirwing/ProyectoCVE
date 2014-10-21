<?php
require 'vendor/autoload.php';

ActiveRecord\Config::initialize(function($cfg)
{
   $cfg->set_model_directory('models');
   $cfg->set_connections(
     array(
       'development' => 'mysql://root:@localhost/db_cve'
     )
   );
});

// Prepare app
$app = new \Slim\Slim(array(
    'templates.path' => 'templates',
));

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

// Define routes
$app->get('/', function () use ($app) {
    
    // Sample log message
    $app->log->info("Slim-Skeleton '/' route");
    // Render index view
    $app->render('index.html');

});

// Define routes
$app->get('/users', function () use ($app) {

    $users = User::all(array('readonly' => true, 'limit' => 50));

    $response = $app->response();
    $response->header('Content-Type', 'application/json');
    $response->status(200);

    $json = json_encode(array_map(function($res){
      return $res->to_array();
    }, $users));

    $app->response()->write($json);

});

// Run app
$app->run();

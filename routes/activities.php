<?php 

$app->get('/activities', function () use ($app) {
    
    // Sample log message
    $app->log->info("Slim-Skeleton '/activities' route");
    // Render index view
    $app->render('activities/index.html');

});

?>
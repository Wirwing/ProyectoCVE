<?php

$app->get('/student/chat',$auth('student'), function () use ($app) {

    // Sample log message
	$app->log->info("Slim-Skeleton '/chat' route");
    // Render index view
	$app->render('chat/index.html');

});

?>

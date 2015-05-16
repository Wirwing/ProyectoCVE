<?php

/*
* Rutas del recurso analisis. Renderizan plantillas HTML con los datos obtenidos de la BD.
*/
$app->get('/teacher/analisis-uso', $auth('teacher'), function () use ($app) {

    // Sample log message
	$app->log->info("Slim-Skeleton '/analisis-uso' route");
    // Render index view
	$app->render('analisis/index.html');

});

?>

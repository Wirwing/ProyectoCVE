<?php

/*
* Rutas del recurso modelos de interaccion. Renderizan plantillas HTML con los datos obtenidos de la BD.
*/
$app->get('/teacher/interaction-models',$auth('teacher'), function () use ($app) {

    // Sample log message
	$app->log->info("Slim-Skeleton '/interaction-models' route");
    // Render index view
	$app->render('interaction-models/index.html');

});

$app->get('/teacher/interaction-models/new',$auth('teacher'), function () use ($app) {

    // Sample log message
	$app->log->info("Slim-Skeleton '/interaction-models/new' route");
    // Render index view
	$app->render('interaction-models/new.html');

});

$app->get('/teacher/interaction-models/:id',$auth('teacher'), function ($id) use ($app) {

	$data = array('id_model' => $id);
	$app->render('interaction-models/show.html', $data);

});

$app->get('/teacher/interaction-models/:id/edit',$auth('teacher'), function ($id) use ($app) {

	$data = array('id_model' => $id);
	$app->render('interaction-models/edit.html', $data);

});

?>

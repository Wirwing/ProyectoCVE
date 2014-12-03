<?php

/*
* Rutas del recurso actividades. Renderizan plantillas HTML con los datos obtenidos de la BD.
*/
$app->get('/teacher/activities',$auth('teacher'), function () use ($app) {

    // Sample log message
	$app->log->info("Slim-Skeleton '/activities' route");
    // Render index view
	$app->render('activities/index.html');

});

$app->get('/teacher/activities/new',$auth('teacher'), function () use ($app) {

    // Sample log message
	$app->log->info("Slim-Skeleton '/activities/new' route");
    // Render index view
	$app->render('activities/new.html');

});

$app->get('/teacher/activities/:id',$auth('teacher'), function ($id) use ($app) {

	$data = array('id_activity' => $id);
	$app->render('activities/show.html', $data);

});

$app->get('/teacher/activities/:id/edit',$auth('teacher'), function ($id) use ($app) {

	$data = array('id_activity' => $id);
	$app->render('activities/edit.html', $data);

});

?>

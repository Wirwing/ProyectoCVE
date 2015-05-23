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

$app->get('/teacher/analisis-uso/groups/:id', $auth('teacher'), function ($id) use ($app) {

	$data = array('id_group' => $id);
	$app->render('analisis/group_detail.html', $data);

});


$app->get('/teacher/analisis-uso/groups/:id/clases', $auth('teacher'), function ($id) use ($app) {

	$data = array('id_group' => $id);
	$app->render('analisis/group_classes_detail.html', $data);

});

?>

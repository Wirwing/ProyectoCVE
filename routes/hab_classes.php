<?php

/*
* Rutas del recurso actividades. Renderizan plantillas HTML con los datos obtenidos de la BD.
*/
$app->get('/teacher/hab_classes',$auth('teacher'), function () use ($app) {

    // Sample log message
    $app->log->info("Slim-Skeleton '/hab-classes' route");
    // Render index view
    $app->render('hab_classes/index.html');

});

$app->get('/teacher/hab_classes/new',$auth('teacher'), function () use ($app) {

    // Sample log message
    $app->log->info("Slim-Skeleton '/hab-classes/new' route");
    // Render index view
    $app->render('hab_classes/new.html');

});

$app->get('/teacher/hab_classes/:id',$auth('teacher'), function ($id) use ($app) {

    $data = array('id_habClass' => $id);
    $app->render('hab_classes/show.html', $data);

});

$app->get('/teacher/hab_classes/:id/edit',$auth('teacher'), function ($id) use ($app) {

    $data = array('id_habClass' => $id);
    $app->render('hab_classes/edit.html', $data);

});


?>

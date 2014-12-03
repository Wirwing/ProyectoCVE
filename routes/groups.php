<?php

/*
* Rutas del recurso grupos. Renderizan plantillas HTML con los datos obtenidos de la BD.
*/
$app->get('/teacher/groups',$auth('teacher'), function () use ($app) {

    // Sample log message
  $app->log->info("Slim-Skeleton '/groups' route");
    // Render index view
  $app->render('groups/index.html');

});

$app->get('/teacher/groups/new',$auth('teacher'), function () use ($app) {

    // Sample log message
  $app->log->info("Slim-Skeleton '/groups/new' route");
    // Render index view
  $app->render('groups/new.html');

});

$app->get('/teacher/groups/:id',$auth('teacher'), function ($id) use ($app) {

  $data = array('id_group' => $id);
  $app->render('groups/show.html', $data);

});

$app->get('/teacher/groups/:id/edit',$auth('teacher'), function ($id) use ($app) {

  $data = array('id_group' => $id);
  $app->render('groups/edit.html', $data);

});

?>

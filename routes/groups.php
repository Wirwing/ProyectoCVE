<?php

$app->get('/groups', function () use ($app) {

    // Sample log message
  $app->log->info("Slim-Skeleton '/groups' route");
    // Render index view
  $app->render('groups/index.html');

});

$app->get('/groups/new', function () use ($app) {

    // Sample log message
  $app->log->info("Slim-Skeleton '/groups/new' route");
    // Render index view
  $app->render('groups/new.html');

});

$app->get('/groups/:id', function ($id) use ($app) {

  $data = array('id_group' => $id);
  $app->render('groups/show.html', $data);

});

$app->get('/groups/:id/edit', function ($id) use ($app) {

  $data = array('id_group' => $id);
  $app->render('groups/edit.html', $data);

});

?>

<?php 

$app->get('/interaction-models', function () use ($app) {

    // Sample log message
	$app->log->info("Slim-Skeleton '/interaction-models' route");
    // Render index view
	$app->render('interaction-models/index.html');

});

$app->get('/interaction-models/new', function () use ($app) {

    // Sample log message
	$app->log->info("Slim-Skeleton '/interaction-models/new' route");
    // Render index view
	$app->render('interaction-models/new.html');

});

$app->get('/interaction-models/:id', function ($id) use ($app) {

	$data = array('id_model' => $id);
	$app->render('interaction-models/show.html', $data);

});

$app->get('/interaction-models/:id/edit', function ($id) use ($app) {

	$data = array('id_model' => $id);
	$app->render('interaction-models/edit.html', $data);

});

?>
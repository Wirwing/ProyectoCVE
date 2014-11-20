<?php

$app->get('/api/chat/:id', function ($id) use ($app) {

	$activity = Chat::find($id);

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	$json = $activity->to_json();

	$response->write($json);

});

?>
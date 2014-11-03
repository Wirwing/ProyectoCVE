<?php 

$app->get('/api/activities', function () use ($app) {

	$activities = Activity::all(array('readonly' => true, 'limit' => 50));

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	$json = json_encode(array_map(function($res){
		return $res->to_array();
	}, $activities));

	$response->write($json);

});

$app->post('/api/activities', function () use ($app) {

	$attributes = $app->request()->getBody();
    //$attributes = json_decode($body, true);

    $activity = new Activity($attributes);
    $activity->save();

    $response = $app->response();
    $response->header('Content-Type', 'application/json');
    $response->status(201);

    $json = $activity->to_json();
    $response->write($json);

});

$app->get('/api/activities/:id', function ($id) use ($app) {

	$activity = Activity::find($id);

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	# you can nest includes .. here model also has an indicators association
	$json = $activity->to_json(array(
	  'include' => array( 'attachments', 'model' => array('include' => 'indicators'))
	));

	$response->write($json);

});

?>
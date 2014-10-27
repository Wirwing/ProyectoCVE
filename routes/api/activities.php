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

	$body = $app->request()->getBody();

	$activity = new Activity($body);
	$activity->save();

	$app->response()->write($activity->to_json());

});

$app->get('/api/activities/:id', function ($id) use ($app) {

	$activity = Activity::find($id);

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	$response->write($activity->to_json());

});

?>
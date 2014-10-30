<?php 

$app->get('/api/models', function () use ($app) {

	$models = Model::all(array('readonly' => true, 'limit' => 50));

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	$json = json_encode(array_map(function($res){
		return $res->to_array();
	}, $models));

	$response->write($json);

});

$app->get('/api/models/default', function () use ($app) {

	$model = Model::first();

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	$json = $model->to_json(array('include' => array('indicators')));

	$response->write($json);

});

?>
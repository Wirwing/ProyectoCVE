<?php 

$app->get('/api/models', function () use ($app) {

	$models = Model::all(array('readonly' => true, 'limit' => 50));

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	$json = json_encode(array_map(function($res){
		return $res->to_array(array('include' => array('indicators')));
	}, $models));

	$response->write($json);

});

$app->post('/api/models', function () use ($app) {

	$attributes = $app->request()->getBody();

    $new_indicators = $attributes["indicators"];
    unset($attributes["indicators"]);

    $model = new Model($attributes);
    $model->new_indicators = $new_indicators;
    $model->save();

    $json = $model->to_json(array('include' => array('indicators')));

    $response = $app->response();
    $response->header('Content-Type', 'application/json');
    $response->status(201);
    $response->write($json);

});

$app->get('/api/models/:id', function ($id) use ($app) {

	$model = Model::find($id);

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	$json = $model->to_json(array('include' => array('indicators')));
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
<?php

/*
* Rutas API del recurso modelos de interaccion
*/
$app->get('/api/interaction-models', function () use ($app) {

	$models = Model::all(array('readonly' => true, 'limit' => 50));

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	$json = json_encode(array_map(function($res){
		return $res->to_array(array('include' => array('indicators')));
	}, $models));

	$response->write($json);

});

$app->post('/api/interaction-models', function () use ($app) {

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

$app->put('/api/interaction-models/:id', function ($id) use ($app) {

	$model = Model::find($id);

	$attributes = $app->request()->getBody();
	//$attributes = json_decode($body, true);

	$new_indicators = $attributes["indicators"];
    unset($attributes["indicators"]);

    $model = Model::find($id);
    $model->new_indicators = $new_indicators;

	$model->update_attributes($attributes);
	$model->save();

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	# you can nest includes .. here model also has an indicators association
	$json = $model->to_json(array('include' => array('indicators')));

	$response->write($json);

});


$app->get('/api/interaction-models/:id', function ($id) use ($app) {

	$model = Model::find($id);

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	$json = $model->to_json(array('include' => array('indicators')));
	$response->write($json);

});

?>

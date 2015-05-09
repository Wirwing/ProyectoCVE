<?php

/*
* Rutas API del recurso modelos de interaccion
 *
 *
 * La API esta lista para recibir las clases, pero por ahora la función se encuentra
 * desactivada
*/
$app->get('/api/interaction-models', function () use ($app) {

	$models = Model::all(array('readonly' => true, 'limit' => 50));

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	$json = json_encode(array_map(function($res){
		return $res->to_array(array('include' => array('classes' => array('include' => 'indicators'))));
	}, $models));

	$response->write($json);

});

$app->post('/api/interaction-models', function () use ($app) {

	$attributes = $app->request()->getBody();

    $classes = $attributes["classes"];
    unset($attributes["classes"]);

    $model = new Model($attributes);
    $model->classes = $classes;
    $model->save();

    $json = $model->to_json(array('include' => array('classes')));

    $response = $app->response();
    $response->header('Content-Type', 'application/json');
    $response->status(201);
    $response->write($json);

});

$app->put('/api/interaction-models/:id', function ($id) use ($app) {

	$attributes = $app->request()->getBody();

	$new_classes = $attributes["classes"];
    unset($attributes["classes"]);

    $model = Model::find($id);
    $model->classes_ = $new_classes;

	$model->update_attributes($attributes);
	$model->save();

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	# you can nest includes .. here model also has an indicators association
	$json = $model->to_json(array('include' => array('classes')));

	$response->write($json);

});


$app->get('/api/interaction-models/:id', function ($id) use ($app) {

	$model = Model::find($id);

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	$json = $model->to_json(array('include' => array('classes')));
	$response->write($json);

});

?>

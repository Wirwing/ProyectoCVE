<?php

$app->get('/api/users', function () use ($app) {

	$users = User::all(array('readonly' => true, 'limit' => 50));

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	$json = json_encode(array_map(function($res){
		return $res->to_array();
	}, $users));

	$response->write($json);

});

$app->get('/api/users/available', function() use ($app) {


	$availableUsers = User::find_by_sql('SELECT * FROM usuarios WHERE usuarios.id NOT IN (SELECT user_id FROM grupos_colaborativos_usuarios)');

	$json = json_encode(array_map(function($res){
		return $res->to_array();
	}, $availableUsers));

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	$response->write($json);

});

$app->post('/api/users', function () use ($app) {

	$body = $app->request()->getBody();
    $attributes = json_decode($body, true);

	$user = new User($attributes);
	$user->save();

	$app->response()->write($user->to_json());

});

$app->get('/api/users/:id', function ($id) use ($app) {

	$user = User::find($id);

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	$response->write($user->to_json());

});

$app->put('/api/users/:id', function ($id) use ($app) {

	$body = $app->request()->getBody();
    $attributes = json_decode($body, true);

	$user = User::find($id);
	$user->update_attributes($attributes);


	$response->header('Content-Type', 'application/json');
	$response->status(200);

	$response->write($user->to_json());

});

$app->delete('/api/users/:id', function ($id) use ($app) {

	$user = User::find($id);
	$user->delete();

	$app->response()->status(204);

});

?>

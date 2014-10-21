<?php 

$app->get('/users', function () use ($app) {

	$users = User::all(array('readonly' => true, 'limit' => 50));

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	$json = json_encode(array_map(function($res){
		return $res->to_array();
	}, $users));

	$app->response()->write($json);

});


?>
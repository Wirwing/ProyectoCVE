<?php

/*
* Rutas API del recurso actividades
*/
$app->get('/api/analisis', function () use ($app) {

	$analisArreglo = AnalisisUso::all(array('readonly' => true, 'limit' => 50));

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	$json = json_encode(array_map(function($res){
		return $res->to_array();
	}, $analisArreglo));

	$response->write($json);

});

?>
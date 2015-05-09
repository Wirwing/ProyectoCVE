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

/*
* Rutas API del recurso actividades
*/
$app->post('/api/analisis/current', function () use ($app) {

	$user = User::find(5);
	$group_user = GroupUser::find('first', array('conditions' => array('user_id = ?', $user->id)));
	$activity = $group_user->activity;
	$model = $activity->model;
	$classes = $model->classes;

	//Por cada clase, obtener su relacion con la tabla indicadores.
	$matriz_datos = [];

	foreach ($classes as $class) {

		$indicators = $class->indicators;

		foreach ($indicators as $indicator) {

			$attributes = array(
				'id_grupo' => $group_user->group_id,
				'id_sesion' => 'Random', 
				'id_usuario' => $user->id, 
				'id_modelo' => $model->id, 
				'id_clase' => $class->id,
				'id_indicador' => $indicator->id, 
				'bUso' => 0,
				'ifrecuencia' => 0
			);

			$dato = new AnalisisUso($attributes);
			array_push($matriz_datos, $dato);
			$dato->save();

		}

	}

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	//$response->write($matriz_datos->to_json());
	//$response->write($model->to_json());
	//$response->write($class->to_json());

	$json = json_encode(array_map(function($res){
		return $res->to_array();
	}, $matriz_datos));

	$response->write($json);

});

?>
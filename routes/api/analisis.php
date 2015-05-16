<?php

/*
* Rutas API del recurso actividades
*/
$app->get('/api/analisis/grupos/:id_group', function ($id_group) use ($app) {

	$analisArreglo = AnalisisUso::find('all',  array(
			'conditions' => array('id_grupo = ?', $id_group), 
			'order' => 'id_usuario ASC, id_clase ASC'
			)
		);

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	$json = json_encode(array_map(function($analisis){
		
		$clase = HabClass::find('first', array('conditions' => array('id = ?', $analisis->id_clase)));
		$indicador = indicator::find('first', array('conditions' => array('id = ?', $analisis->id_indicador)));

		$indicadoresUsados = AnalisisUso::all(
			array('conditions' => array('id_usuario = ? AND id_clase = ? AND bUso = 1',
					$analisis->id_usuario, $analisis->id_clase))
			);

		$totalIndicadoresDeClase = sizeof($clase->indicators);
		$contadorIndicadoresUSados = sizeof($indicadoresUsados);

		if($totalIndicadoresDeClase != 0){
			$porcentajeUsabilidad = $contadorIndicadoresUSados / $totalIndicadoresDeClase;
		}else{
			$porcentajeUsabilidad = 0;
		}

		if($porcentajeUsabilidad < .7){
			$dominio = "NS";
		}else if($porcentajeUsabilidad >= .7 && $porcentajeUsabilidad < .8){
			$dominio = "S";
		}else if($porcentajeUsabilidad >= .8 && $porcentajeUsabilidad < .9){
			$dominio = "SA";
		}else{
			$dominio = "SS";
		}

		$analisisAsArray = $analisis->to_array();
		$analisisAsArray['porcentaje_usabilidad'] = $porcentajeUsabilidad;
		$analisisAsArray['dominio'] = $dominio;

		$analisisAsArray['clase_nombre'] = $clase->nombre;
		$analisisAsArray['indicador_nombre'] = $indicador->nombre;

		return $analisisAsArray;

	}, $analisArreglo));

/*
	$model = array(
				'atributo' => 1,
				'sesion' => 'Random'
			);

	$json = json_encode($model);
*/
	$response->write($json);

});

$app->get('/api/analisis/grupos/:id_group/activos', function ($id_group) use ($app) {

	$analisArreglo = AnalisisUso::find('all',  array(
			'conditions' => array('id_grupo = ? AND bUso = 1', $id_group), 
			'order' => 'id_clase asc'
			)
		);


	$json = json_encode(array_map(function($analisis){
		
		$clase = HabClass::find('first', array('conditions' => array('id = ?', $analisis->id_clase)));
		$indicador = indicator::find('first', array('conditions' => array('id = ?', $analisis->id_indicador)));

		$indicadoresUsados = AnalisisUso::all(
			array('conditions' => array('id_usuario = ? AND id_clase = ? AND bUso = 1',
					$analisis->id_usuario, $analisis->id_clase))
			);

		$totalIndicadoresDeClase = sizeof($clase->indicators);
		$contadorIndicadoresUSados = sizeof($indicadoresUsados);

		if($totalIndicadoresDeClase != 0){
			$porcentajeUsabilidad = $contadorIndicadoresUSados / $totalIndicadoresDeClase;
		}else{
			$porcentajeUsabilidad = 0;
		}

		if($porcentajeUsabilidad < .7){
			$dominio = "NS";
		}else if($porcentajeUsabilidad >= .7 && $porcentajeUsabilidad < .8){
			$dominio = "S";
		}else if($porcentajeUsabilidad >= .8 && $porcentajeUsabilidad < .9){
			$dominio = "SA";
		}else{
			$dominio = "SS";
		}

		$analisisAsArray = $analisis->to_array();
		$analisisAsArray['porcentaje_usabilidad'] = $porcentajeUsabilidad;
		$analisisAsArray['dominio'] = $dominio;

		$analisisAsArray['clase_nombre'] = $clase->nombre;
		$analisisAsArray['indicador_nombre'] = $indicador->nombre;

		return $analisisAsArray;

	}, $analisArreglo));

	$json = json_encode(array_map(function($analisis){
		return $analisis->to_array();
	}, $analisArreglo));

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

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
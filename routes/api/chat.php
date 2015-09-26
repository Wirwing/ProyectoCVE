<?php

/*
* Rutas API del recurso chat
*/
$app->get('/api/chat/:id', function ($id) use ($app) {

	$activity = Chat::find($id);

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status(200);

	$json = $activity->to_json();

	$response->write($json);

});

$app->post('/api/chat/elements', function() use ($app){

	$attributes = $app->request()->getBody();

	//Actualizando matriz de datos analisis
	$id_grupo = $attributes['id_grupo'];
	$id_session = $attributes['id_sesion'];
	$id_usuario = $attributes['id_usuario'];
	$id_clase = $attributes['id_clase'];
	$id_indicador = $attributes['id_indicador'];

	$dato_analisis = AnalisisUso::find('first', 
		array('conditions' => array('id_sesion = ? AND id_usuario = ? AND id_clase = ?',
		 $id_session, $id_usuario, $id_clase))
		);

	$response = $app->response();

	if($dato_analisis == null){

		//Creando matriz de analisis de uso
        $group_user = GroupUser::find('first', array('conditions' => array('user_id = ?', $id_usuario)));
        $activity = $group_user->activity;
        $model = $activity->model;

		$attributes_analisis = array(
              'id_grupo' => $id_grupo,
              'id_sesion' => $id_session, 
              'id_usuario' => $id_usuario, 
              'id_modelo' => $model->id,
              'id_clase' => $id_clase,
              'id_indicador' => $id_indicador, 
              'bUso' => 0,
              'ifrecuencia' => 0
            );


		$app->log->info("Atributos Dato Analisis");
		$app->log->info(json_encode($attributes_analisis));

        $dato_analisis = new AnalisisUso($attributes_analisis);

		// $response->header('Content-Type', 'application/json');
		// $json = json_encode(array("result" => "Dato analisis no encontrado"));
		// $response->status(404);
		// $response->write($json);
		// return;
	}

	$dato_analisis->buso = 1;
	$dato_analisis->ifrecuencia++;
	$dato_analisis->save();

	//Id Clase
	$dato_analisis->id_clase = $id_clase;
	$dato_analisis->save();

	$response->header('Content-Type', 'application/json');
	$response->status(201);

	$json = $dato_analisis->to_json();
	$app->log->info("Dato Analisis");
	$app->log->info($json);

	$response->write($json);
	
});

$app->post('/api/chat/messages', function() use ($app){

	$attributes = $app->request()->getBody();

	//Actualizando matriz de datos analisis
	$id_grupo = $attributes['id_grupo'];
	$id_session = $attributes['id_sesion'];
	$id_usuario = $attributes['id_usuario'];
	$id_clase = $attributes['id_clase'];
	$id_indicador = $attributes['id_indicador'];

	$dato_analisis = AnalisisUso::find('first', 
		array('conditions' => array('id_sesion = ? AND id_usuario = ? AND id_clase = ? AND id_indicador = ?',
		 $id_session, $id_usuario, $id_clase, $id_indicador))
		);

	$response = $app->response();

	if($dato_analisis == null){

		$response->header('Content-Type', 'application/json');
		$json = json_encode(array("result" => "Dato analisis no encontrado"));
		$response->status(404);
		$response->write($json);
		return;

	}

	$dato_analisis->buso = 1;
	$dato_analisis->ifrecuencia++;
	$dato_analisis->save();

	$app->log->info("Atributos Dato Analisis En Mensaje");
	$app->log->info($dato_analisis->to_json());

	//Guardando Log
	$chat_log = new ChatLog($attributes);
	$chat_log->save();

	$response->header('Content-Type', 'application/json');
	$response->status(201);

	$json = $chat_log->to_json();

	$response->write($json);
	
});

$app->get('/api/chat/messages/:group_id/:activity_id/', function($group_id, $activity_id)
use($app){

	$chat_logs = ChatLog::all(array('conditions' => array('id_grupo = ? AND id_actividad = ?',
	$group_id, $activity_id)));

	$response = $app->response();

	if( !is_null( $chat_logs ) ){
		$json = json_encode(array_map(function($res){
			return $res->to_array(array(
				'include' => array('user', 'indicator')
			));
		}, $chat_logs));

		$status_code = 200;
	}else{
		$json = json_encode( array('result' => 'There are no messages'));
		$status_code = 400;
	}

	$response->header('Content-Type', 'application/json');
	$response->status($status_code);
	$response->write($json);

});


$app->get('/api/chat/messages/:group_id/:activity_id/:last_chat_id', function($group_id, $activity_id, $last_chat_id)
	use($app){

	$chat_logs = ChatLog::all(array('conditions' => array('id_grupo = ? AND id_actividad = ? AND id > ?',
		$group_id, $activity_id, $last_chat_id)));

	$response = $app->response();

	if( !is_null( $chat_logs ) ){
		$json = json_encode(array_map(function($res){
			return $res->to_array(array(
				'include' => array('user', 'indicator')
			));
		}, $chat_logs));

		$status_code = 200;
	}else{
		$json = json_encode( array('result' => 'There are no messages'));
		$status_code = 400;
	}

	$response->header('Content-Type', 'application/json');
	$response->status($status_code);
	$response->write($json);

});

?>

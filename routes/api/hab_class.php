<?php
/*
* Rutas API del recurso clases de habilidades colaborativas
*/
$app->get('/api/hab_class', function () use ($app) {

    $models = HabClass::all(array('readonly' => true, 'limit' => 50));

    $response = $app->response();
    $response->header('Content-Type', 'application/json');
    $response->status(200);

    $json = json_encode(array_map(function($res){
        return $res->to_array(array('include' => array('indicators')));
    }, $models));

    $response->write($json);

});


$app->get('/api/models/:id/hab_class', function ($id) use ($app) {

    $classes = HabClass::all(array('conditions' => array('model_id = ?', $id)));

    $json = json_encode(array_map(function($class){
        return $class->to_array();
    }, $classes));

    $response = $app->response();
    $response->header('Content-Type', 'application/json');
    $response->status(200);

    $response->write($json);

});

$app->post('/api/hab_class', function () use ($app) {

    $attributes = $app->request()->getBody();

    $new_indicators = $attributes["indicators"];
    unset($attributes["indicators"]);

    $model = new HabClass($attributes);
    $model->new_indicators = $new_indicators;
    $model->save();

    $json = $model->to_json(array('include' => array('indicators')));

    $response = $app->response();
    $response->header('Content-Type', 'application/json');
    $response->status(201);
    $response->write($json);

});

$app->put('/api/hab_class/:id', function ($id) use ($app) {

    $attributes = $app->request()->getBody();
    //$attributes = json_decode($body, true);

    $new_indicators = $attributes["indicators"];
    unset($attributes["indicators"]);

    $model = HabClass::find($id);
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


$app->get('/api/hab_class/:id', function ($id) use ($app) {

    $habClass = HabClass::find($id);

    $response = $app->response();
    $response->header('Content-Type', 'application/json');
    $response->status(200);

    $json = $habClass->to_json(array('include' => array('indicators')));
    $response->write($json);

});

$app->delete('/api/hab_class/:id', function($id) use ($app) {

    try {
        $habClass = HabClass::find($id);
        $delete = $habClass->delete();
        $message = ($delete == true)? 'Clase de habilidad eliminada' : "Couldn't delete ability class";
        $status_code = 204;
    } catch (\ActiveRecord\RecordNotFound $e) {
        $message = "Ability class not found";
        $status_code = 404;
    }

    $json = json_encode(array("result" => $message));

    $response = $app->response();
    $response->header('Content-Type', 'application/json');
    $response->status($status_code);
    $response->write($json);

});


?>

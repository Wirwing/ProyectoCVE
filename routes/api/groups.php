<?php

/*
* Rutas API del recurso grupos colaborativos
*/
$app->get('/api/groups', function () use ($app) {

  $groups = Group::all(array('readonly' => true, 'limit' => 50));

  $response = $app->response();
  $response->header('Content-Type', 'application/json');
  $response->status(200);

  $json = json_encode(array_map(function($res){
    return $res->to_array();
  }, $groups));

  $response ->write($json);

});

$app->get('/api/groups/:id/single-activity', function ($id) use ($app) {

  $group = GroupUser::first(array('conditions' => array('group_id = ?', $id)));

  $activity = $group->activity;

  $response = $app->response();
  $response->header('Content-Type', 'application/json');
  $response->status(200);

  $response ->write($activity->to_json());

});

$app->post('/api/groups', function () use ($app) {

    $attributes = $app->request()->getBody();

    $users_ids = $attributes["selected_users"];
    unset($attributes["selected_users"]);


    $activity_id = $attributes['activity_id'];
    unset($attributes['activity_id']);


    $group = new Group($attributes);
    $group->users_ids = $users_ids;
    $group->activity_id = $activity_id;
    $group->save();

    $response = $app->response();
    $response->header('Content-Type', 'application/json');
    $response->status(201);

    $json = $group->to_json();

    $response->write($json);
});


/* gets the group of the given user */
$app->get('/api/groups/user/:user_id', function($user_id) use($app) {

  $group_user = GroupUser::find('first', array('conditions' => array('user_id = ?', $user_id)));

  $response = $app->response();
  $response->header('Content-Type', 'application/json');
  $json;

  if( !is_null($group_user) ){
    /* we obtained the group user */
    $group = $group_user->group;
    $json = $group->to_json(array(
      'include' => 'users'
    ));

    /* we recover the activity */
    $group_id = $group->id;
    $sql = "SELECT * FROM actividades_colaborativas WHERE id = (SELECT activity_id FROM grupos_colaborativos_usuarios WHERE group_id = $group_id LIMIT 0,1)";
    $activities = Activity::find_by_sql($sql);

    if( !is_null( $activities )){
      $json_elements = json_decode( $json, true );
      $activity = $activities[0];

      $activity_json = $activity->to_json(
          array('include' => array( 'attachments', 'model' => array('include' => array('classes' => array('include' => 'indicators'))))
      ));
      $activity_json_decode = json_decode( $activity_json, true );

      $final_json_array = array_merge( $json_elements, array('activity' => $activity_json_decode ) );

      $json = json_encode( $final_json_array );
    }

    $response->status(201);
  }else{
    $json = json_encode(array("result" => "No existen grupos para este usuario"));
    $response->status(200);
  }

  $response->write($json);
});


$app->get('/api/groups/:id/activity', function($id) use($app){
    #sql sentence <i hate phpactiverecord>
    $sql = "SELECT * FROM actividades_colaborativas WHERE id = (SELECT activity_id FROM grupos_colaborativos_usuarios WHERE group_id = $id LIMIT 0,1)";
    $activities = Activity::find_by_sql($sql);

    $response = $app->response();
    $response->header('Content-Type', 'application/json');
    $response->status(201);

    $json = json_encode(array_map(function($res){
      return $res->to_array();
    }, $activities));

    $response ->write($json);
});

$app->get('/api/groups/:id', function ($id) use ($app) {

  $group = Group::find($id);

  $response = $app->response();
  $response->header('Content-Type', 'application/json');
  $response->status(200);

  $json = $group->to_json(array(
    'include' => 'users'
  ));

  $response->write($json);
});

$app->put('/api/groups/:id', function ($id) use ($app) {

  $group = Group::find($id);
  $attributes = $app->request()->getBody();

  $group->users_ids = $attributes['selected_users'];
  unset($attributes['selected_users']);

  $group->activity_id = $attributes['activity_id'];
  unset($attributes['activity_id']);

  $group->update_attributes($attributes);
  $group->save();

  $response = $app->response();
  $response->header('Content-Type', 'application/json');
  $response->status(200);

  $json = $group->to_json(
    array('include' => 'users')
  );

  $response->write($json);
});

$app->delete('/api/groups/:id', function ($id) use ($app) {

  try {
    $group = Group::find($id);
    $delete = $group->delete();
    $message = ($delete == true)? 'Group deleted' : "Couldn't delete group";
    $status_code = 204;
  } catch (\ActiveRecord\RecordNotFound $e) {
    $message = "Group not found";
    $status_code = 404;
  }

  $json = json_encode(array("result" => $message));

  $response = $app->response();
  $response->header('Content-Type', 'application/json');
  $response->status($status_code);
  $response->write($json);

});

?>

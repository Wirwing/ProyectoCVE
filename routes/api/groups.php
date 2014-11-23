<?php

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

$app->post('/api/groups', function () use ($app) {

    $attributes = $app->request()->getBody();

    $users_ids = $attributes["selected_users"];
    unset($attributes["selected_users"]);

    $group = new Group($attributes);
    $group->users_ids = $users_ids;
    //Change to the real value later
    $group->activity_id = 1;
    $group->save();

    $response = $app->response();
    $response->header('Content-Type', 'application/json');
    $response->status(201);

    $json = $group->to_json();

    $response->write($json);
});

$app->get('/api/groups/:id', function ($id) use ($app) {

  $group = Group::find($id);

  $response = $app->response();
  $response->header('Content-Type', 'application/json');
  $response->status(200);

  $lastQuery = Group::connection()->last_query;

  $json = $group->to_json(array(
    'include' => 'users'
  ));

  $response->write($json);
});

$app->put('/api/groups/:id', function ($id) use ($app) {

  $group = Group::find($id);
  $attributes = $app->request()->getBody();

  $users_ids = $attributes['selected_users'];
  unset($attributes['selected_users']);

  $group->users_ids = $users_ids;
  $group->update_attributes($attributes);
  //Change to the real value later
  $group->activity_id = 1;
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

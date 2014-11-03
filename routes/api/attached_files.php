<?php 

$app->post('/api/activities/:id/files', function ($id_activity) use ($app) {

	$app->log->info("File upload route");

	try {
		$json = AttachedFile::attach_new($id_activity)->to_json();
		$status_code = 201;
	} catch (\ActiveRecord\RecordNotFound $e) {
		$json = json_encode(array("result" => $result));
		$status_code = 404;
	}

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status($status_code);
	$response->write($json);

});


$app->delete('/api/activities/:id_activity/files/:id', function ($id_activity, $id) use ($app) {

	$app->log->info("File delete route");

	try {
		$delete = AttachedFile::delete_attachment($id, $id_activity);
		$message = ($delete == true)? 'Attachment deleted' : "Couldn't delete attachment";
		$status_code = 204;
	} catch (\ActiveRecord\RecordNotFound $e) {
		$message = "Couldn't delete attachment";
		$status_code = 404;
	}

	$json = json_encode(array("result" => $message));

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status($status_code);
	$response->write($json);

});

$app->get('/activities/:id_actividad/files/:id_file', function ($id_actividad, $id_file) use ($app) {

	$app->log->info("File download route");

	$attachment = AttachedFile::find_by_id_and_activity($id_file, $id_actividad);

	$file = $attachment->get_attachment();

	$res = $app->response();
	$res['Content-Description'] = 'File Transfer';
	$res['Content-Type'] = 'application/octet-stream';
	$res['Content-Disposition'] ='attachment; filename=' . basename($file);
	$res['Content-Transfer-Encoding'] = 'binary';
	$res['Expires'] = '0';
	$res['Cache-Control'] = 'must-revalidate';
	$res['Pragma'] = 'public';
	$res['Content-Length'] = filesize($file);
	readfile($file);

});

?>
<?php 

$app->get('/activities', function () use ($app) {

    // Sample log message
	$app->log->info("Slim-Skeleton '/activities' route");
    // Render index view
	$app->render('activities/index.html');

});

$app->get('/activities/new', function () use ($app) {

    // Sample log message
	$app->log->info("Slim-Skeleton '/activities/new' route");
    // Render index view
	$app->render('activities/new.html');

});

$app->get('/activities/:id', function ($id) use ($app) {

	$data = array('id_activity' => $id);
	$app->render('activities/show.html', $data);

});

$app->post('/activities/:id/files', function ($id_activity) use ($app) {

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


$app->get('/activities/:id_actividad/files/:id_file', function ($id_actividad, $id_file) use ($app) {

	$app->log->info("File download route");

	$attachments = AttachedFile::all(array('id_actividad' => $id_actividad, 'id' => $id_file));
	$attachment = $attachments[0];

	$file = "C:\cve\public\uploads\activities\\" . $attachment->id_actividad . "\\files\\" . $attachment->nombre;

	//var_dump($file);

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
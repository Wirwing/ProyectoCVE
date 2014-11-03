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
		$result = AttachedFile::attach_new($id_activity);
		$status_code = 201;
	} catch (\ActiveRecord\RecordNotFound $e) {
		$result = "Activity doesn't exist";
		$status_code = 404;
	}

	$json = json_encode(array("result" => $result));

	$response = $app->response();
	$response->header('Content-Type', 'application/json');
	$response->status($status_code);
	$response->write($json);

});


$app->get('/activities/:id/files/:id_file', function ($id) use ($app) {

	$app->log->info("File download route");

	$file = 'C:\cve\public\uploads\activities\1\files\Articulo.docx';

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
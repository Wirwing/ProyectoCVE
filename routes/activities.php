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

$app->post('/activities/:id/files', function ($id) use ($app) {

	$app->log->info("File upload route");

	if (!isset($_FILES['upload'])) {
		echo "No files uploaded!!";
		return;
	}

	$imgs = array();

	$file = $_FILES['upload'];
	$filename = $file['tmp_name'];

	$upload_path = '/cve/public/uploads/activities/'. $id . '/files';
	$destination =  $upload_path . '/' . $file["name"];

	if ($file['error'] === 0) {

		if (!file_exists($upload_path)) {
			mkdir($upload_path, 0777, true);
		}

		if (move_uploaded_file($filename, $destination)) {
			echo "Success.\n";
		}else{
			echo "Error move";
		}
	}else{
		echo "Error code";
	}


	echo 'Here is some more debugging info:';
	print_r($_FILES);

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
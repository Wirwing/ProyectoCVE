<?php	

	require_once("misc.php");
	require_once("ims-blti/blti_util.php");
	include("conn.php");
	
 	$lmsdata = array(
 		"resource_link_id" => "", //"2",
 		"resource_link_title" => "", //"Tutorial de Aprendizaje Colaborativo",
 		"resource_link_description" => "", //"Tutorial que describe el ciclo basico de desarrollo del aprendizaje colaborativo y explica la funcionalidad de la interoperabilidad que permite a sistemas de gestion del aprendizaje como Moodle interactuar con sistemas externos.",
 		"user_id" => "", //"2",
 		"roles" => "", //"Instructor",  // or Learner
 		"lis_person_name_full" => "", //'=Admin User',
 		"lis_person_contact_email_primary" => "", //cyntsc@yahoo.com",
 		// DATOS NO LOCALIZADOS "tool_consumer_instance_description" => "University of School (LMSng)",
 		//"lis_person_sourcedid" => "school.edu:user",
 		"context_id" => "", //"5",
 		"context_title" => "", //"Informatica Basica e Internet",
 		"context_description" => "", //csc
 		"context_label" => "", //"CBI",
 		"tool_consumer_instance_guid" => "", //"localhost",
	 );
 	
 foreach ($lmsdata as $k => $val ) {
 	//if ( $_POST[$k] && strlen($_POST[$k]) > 0 ) {
 	if ( @$_POST[$k] && strlen(@$_POST[$k]) > 0 ) {
 		$lmsdata[$k] = $_POST[$k];
 		//echo $lmsdata[$k]; 		  // barrido de parametros -
 	}
 }
 $cur_url = curPageURL();
 //$key = $_REQUEST["key"];
 @$key = $_REQUEST["key"];
 if ( ! $key ) $key = "12345";
 @$secret = $_REQUEST["secret"];
 if ( ! $secret ) $secret = "secret";
 @$endpoint = $_REQUEST["endpoint"];

 if ( ! $endpoint ) $endpoint = str_replace("lms.php","tool.php",$cur_url);
 @$urlformat = $_REQUEST["format"];

 $urlformat = ( $urlformat != 'XML' );
 $tool_consumer_instance_guid = $lmsdata['tool_consumer_instance_guid'];
 @$tool_consumer_instance_description = $lmsdata['tool_consumer_instance_description'];
 
 @$xmldesc = str_replace("\\\"","\"",$_REQUEST["xmldesc"]);
 
 if ( ! $xmldesc ) $xmldesc = $default_desc;
 
 $IDMoodle =$lmsdata["user_id"];
 $Nombre= $lmsdata["lis_person_name_full"];
 $CourseID= $lmsdata["context_id"];
 $Nombre_Curso= $lmsdata["context_title"];
 $emailMoodle= $lmsdata["lis_person_contact_email_primary"];
 $ContextDescription= $lmsdata["context_description"]; //csc
 $rol = 0;
 // csc- variable global que devuelve los datos generales de Moodle
 if ($lmsdata["roles"]=="Learner"){
 	$rol =2;
  }
 else {
 	$rol=1; //teacher
 }
 	$GLOBALS['Rol'] = $rol;  
 	//$GLOBALS['IDMoodle'] =$lmsdata["user_id"]; 	// csc- global variable used for control de moodle access and setup cll groups (basically is the "matricula moodle")
 	//echo "ID moodle". $IDMoodle;
 	$GLOBALS['User'] = $emailMoodle;  
 	$d=date("Y-m-d h:i:sa");
 	$ap_paterno="ap_paterno";
 	$ap_materno="ap_materno";
 	$password="password";
 	//echo "Fecha:" . $d;
  	//$sql="INSERT INTO moodle_rcd(id_User, userName, rol, id_course, course_name, email_sesion, fecha_inicio, close_sesion)
 	//VALUES ('$IDMoodle','$Nombre','$rol','$CourseID','$Nombre_Curso','prueba desde moodle+cve','$d','1')";
	$rs = mysqli_query($con,"SELECT email from usuarios where email='$emailMoodle'");
	if ($row = mysqli_fetch_row($rs)) {
		//$user_validation =   trim($row[0]);	// csc - global variable for open/close session - get from identity insert into moodle_rcd table
	} 	 	
	else {
		$sql="INSERT INTO usuarios(nombre, apellido_paterno, apellido_materno, usuario, password, email, tipo, curso_moodle)
	 	VALUES ('$Nombre','$ap_paterno','$ap_materno','$emailMoodle','$password','$emailMoodle','$rol','$Nombre_Curso')";
	 	//'$nombre'=usuario - login
	 	//'$emailMoodle' = password - login
	 	if (!mysqli_query($con,$sql)) {
	 		die('Error: ' . mysqli_error($con));
	 	}
	} 	
/* 	else {
  		//Obtiene el Id unico asignado en la tabla moodle_rcd
 		$rs = mysqli_query($con,"SELECT @@identity AS id");
 		if ($row = mysqli_fetch_row($rs)) {
 			$GLOBALS['IDUser'] =   trim($row[0]);	// csc - global variable for open/close session - get from identity insert into moodle_rcd table
 		} 	 	
  		//echo "  ID User:". $IDUser;  	 
  	}  	 	*/
 	mysqli_close($con);
 	header ("Location:". "//localhost/CVE/");
 	die();

  ?>
 

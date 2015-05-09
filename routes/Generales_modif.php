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
 

 $Nombre= $lmsdata["lis_person_name_full"];
 $CourseID= $lmsdata["context_id"];
 $Nombre_Curso= $lmsdata["context_title"];
 $emailMoodle= $lmsdata["lis_person_contact_email_primary"];
 $ContextDescription= $lmsdata["context_description"]; //csc
 // csc- variable global que devuelve los datos generales de Moodle
 if ($lmsdata["roles"]=="Learner"){
 	$GLOBALS['Rol'] = 0; //alumno
 }
 else {
 	$GLOBALS['Rol'] = 1;  // maestro
 }
  
 //function moodle_user(){
 	
 	$GLOBALS['IDMoodle'] =$lmsdata["user_id"]; 	// csc- global variable used for control de moodle access and setup cll groups (basically is the "matricula moodle")
 	//echo "ID moodle". $IDMoodle;
 	$d=date("Y-m-d h:i:sa");
 	//echo "Fecha:" . $d;
  	$sql="INSERT INTO moodle_rcd(id_user, username, rol, Id_Course, Course_Name, Email_Sesion, Fecha_Inicio, Close_Sesion)
 	VALUES ('$IDMoodle','$Nombre','$Rol','$CourseID','$Nombre_Curso','$emailMoodle','$d','1')";

 	if (!mysqli_query($con,$sql)) {
 		die('Error: ' . mysqli_error($con));
 	}
 	else {
  		//Obtiene el Id unico asignado en la tabla moodle_rcd
 		//printf("Nuevo registro con el id %d.\n", mysqli_insert_id($con));
 		$rs = mysqli_query($con,"SELECT @@identity AS id");
 		if ($row = mysqli_fetch_row($rs)) {
 			$GLOBALS['IDUser'] =   trim($row[0]);	// csc - global variable for open/close session - get from identity insert into moodle_rcd table
 		} 	 	
  		//echo "  ID User:". $IDUser;  	 
  	}  	 	
 	mysqli_close($con);
 //}
  ?>
 

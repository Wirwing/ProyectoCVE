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
 		"context_label" => "", //"CBI",
 		"tool_consumer_instance_guid" => "", //"localhost",
	 );
 	
 foreach ($lmsdata as $k => $val ) {
 	//if ( $_POST[$k] && strlen($_POST[$k]) > 0 ) {
 	if ( @$_POST[$k] && strlen(@$_POST[$k]) > 0 ) {
 		$lmsdata[$k] = $_POST[$k];
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
 
 /* Devuelve los datos generales de Moodle 
    alumno =0 
    maestro=1
  */
 if ($lmsdata["roles"]=="Learner"){
 	$Rol = 0;
 }
 else {
 	$Rol= 1;   /*maestro o admon*/
 }


 $UserId=$lmsdata["user_id"];
 //$IDUser =$lmsdata["user_id"];
 $Nombre= $lmsdata["lis_person_name_full"];
 $CourseID= $lmsdata["context_id"];
 $Nombre_Curso= $lmsdata["context_title"];
 $emailMoodle= $lmsdata["lis_person_contact_email_primary"];
 
//ABRE UNA SESION EN LA TABLA DE REGISTRO MOODEL_RCD
 
 $d=date("Y-m-d h:i:sa");
 echo "Fecha:" . $d;
  $sql="INSERT INTO moodle_rcd(IdUser, UserName, Rol, IdCourse, CourseName, EmailSesion, FechaIni, CloseSesion)
 VALUES ('$UserId','$Nombre','$Rol','$CourseID','$Nombre_Curso','$emailMoodle','$d','1')";
 if (!mysqli_query($con,$sql)) {
 	die('Error: ' . mysqli_error($con));
 }
 else {
 	//echo "Sesion abierta de moodle para" . $Nombre;
 	$ResultQry =mysqli_fetch_array(mysqli_query($con,	"SELECT ID FROM `moodle_rcd` order by ID DESC")); 
 	$GLOBALS['IDMoodle1']= $ResultQry['ID'];
 	$IDMood1= $ResultQry['ID'];
  	mysqli_close($con);
 }
 ?>
 
 

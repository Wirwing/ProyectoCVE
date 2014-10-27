<?php
include("conn.php");

function Alta_FromMoodle($UserId,$Nombre,$rol,$CourseID,$Nombre_Curso,$emailMoodle) {
	/*ABRE UNA SESION EN LA TABLA DE REGISTRO MOODEL_RCD*/
	$d=date("Y-m-d h:i:sa");

	$sql="INSERT INTO moodle_rcd(IdUser, UserName, Rol, IdCourse, CourseName, EmailSesion, FechaIni, CloseSesion)
	VALUES ('$UserId','$Nombre','$rol','$CourseID','$Nombre_Curso','$emailMoodle','$d','1')";
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
}
?>
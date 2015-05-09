<?php

	/*
	* Las rutas del lado del servidor estan divididas en dos espacios de nombre: uno que resuelve paginas HTML, 
	y otra RESTful (con prefijo /api/)
	*/

	#HTML Namespace
	include "activities.php";
	include "models.php";
	include "groups.php";
	include "chat.php";
    include "hab_classes.php";    
    include "analisis_uso.php";    /* ad.by.csc */

	#API Namespace
	include "api/users.php";
	include "api/activities.php";
	include "api/attached_files.php";
	include "api/models.php";
    include "api/hab_class.php";
	include "api/groups.php";
	include "api/chat.php";
	include "api/analisis.php"; 	/* ad.by.csc */
?>

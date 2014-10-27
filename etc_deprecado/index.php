<html>
<head>
<link rel="stylesheet" type="text/css" href="CSS/CSS_TblDiv.css">
</head>

<body>
<div id="container">
<div id="header">
	<h1>TUTORIAL DE APRENDIZAJE COLABORATIVO</h1>
	<?php
		include ("Funciones/Generales.php");	
//		require_once("Funciones/ABC_MoodleAccess.php");
		
//		Alta_FromMoodle($UserId,$Nombre,$rol,$CourseID,$Nombre_Curso,$emailMoodle);
		
		session_start();		
		if(isset($_SESSION['UserSesionID1']))
			unset($_SESSION['UserSesionID1']); //destruye la sesion
		else
			$_SESSION['UserSesionID1']=$emailMoodle;
	?>	
	<form action="Close_MoodleSesion.php" method="POST">
		Bienvenido 
		<?php 
			if ($Rol==0) {
				$RolDescription="Alumno";
				echo $RolDescription;
				//echo Alumno;
			}
			else {
				$RolDescription="Maestro";
				echo $RolDescription;
				//echo Maestro;
			}	
		?> 
		<input type="text" value="<?php echo $Nombre?>"> Curso Moodle <input type="text" value="<?php echo $Nombre_Curso?>"> 
	 	Sesion de Usuario <input type="text" name="email" value="<?php echo $emailMoodle?>">
		<input type="hidden" name="IdM" value="<?php echo $IDMood1?>">
		<input type="submit" value="Cerrar Sesion">
	</form>
	<script type="index.php">
	setTimeout("redireccionar("index.php")",4000  //4 seg abrir pagina 
	</script>
		
</div>
<div id="menu">
	<div class="uno">
	<b><a href=index.php>MENU TUTORIAL (Regresar)</a><br><br></b>
	<a href=AprCLL.html>Aprendizaje Colaborativo</a><br>
	<a href=CSCL.html>CSCL "Computed Supported Collaborative Learning"</a><br>
	<a href=LMS.html>LMS "Learnign Manager Systems"</a><br>
	Ciclo de gestion de los CSCL<br>
	Modelos de interactividad CSCL<br>
	<a href=RegistroExternos.php>Reg. Usuarios Externos</a><br><br><br>	
	
	PROTOTIPO EVC :<br>
	<a href=JuegoCll.php>Prototipo experimental</a><br><br>	
	
	REGISTROS MOODLE<br>
	<?php	
	if (!$IDMood1==0) {/*Si es usuario de moodle entonces selecciona el tipo de indicadoresa mostrar */ 
	if (!$Rol==0) //Maestro 
	{ 
		echo "<a href='RegMoodle_Tutor.php?IdUser="; echo $UserId; echo "'>CLL Indicadores maestros</a>";
	} else {
		//echo "<a href='RegMoodle_Tutor.php?IdUser="; echo $UserId; echo "'>CLL Indicadores alumnos</a>";
		echo "<a href='RegMoodle_Alum.php?IdUser="; echo $UserId; echo "'>CLL Indicadores alumnos</a>";
	}
	}
	?>
	</div>	
</div>
<div id="content">
	<br>
	<p>Este sitio ha sido creado para explicar que son los entornos virtuales colaborativos, sus componentes estructurales de su ciclo de gestion y desarrollo desde una perpectiva informatica y pedagogica en base a los sistemas CSCL "Computer Supported Colaborative Learning".    
	</p><br>
	<p>Asi mismo, se abordara detalladamente la fases de entorno de aprendizaje compartido, analisis de la interaccion de grupo mediante modelado computacional y resultados de la iteraccion como indicadores de aprendizaje. Para lo cual se " 
	experimentara mediante la replica de dos modelos de interaccion que permitan evaluar si es realmente posible intervenir sistematicamente en las interacciones de determindado grupo, para tales experimentos se utilizaran dos juegos de aprendizaje colaborativo " 
	dirigidos a estudiantes de nivel de educacion elemental.
</p>
</div>
<div id="footer">
	Universidad Autonoma de Yucatan, FMAT (MCC)<br>
	<?php 
	echo $_SERVER['SERVER_PROTOCOL'] . " " . $_SERVER['SERVER_NAME'] . " " . $_SERVER['HTTP_HOST'];
	echo "<br>";
	echo $_SERVER['HTTP_REFERER'] . " " .  $_SERVER['HTTP_USER_AGENT'] . " " . $_SERVER['SCRIPT_NAME'];
	?>
</div>
</div>
</body>
</html>
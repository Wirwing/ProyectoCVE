<?php
// conexion a mysql
$con=mysqli_connect("localhost","root","root","cve_fmat_uady");
// Check connection
if (mysqli_connect_errno())
{
	echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

?>

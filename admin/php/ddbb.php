<?php
    $host = "localhost";
    $user = "dev";
    $pass = "dev";
    $ddbb = "therockproject";

    $connect = mysqli_connect($host,$user,$pass,$ddbb);

    if (!$connect){

        echo "Error en base de datos.";
    }

?>

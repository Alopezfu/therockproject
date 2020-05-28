<?php
    require_once 'core.php';
    require_once 'ddbb.php';
    checkLogin(true);
    
    $dir_subida = '/sitios/'.$_SESSION['username'].'/';
    $fichero_subido = $dir_subida . basename($_FILES['files']['name']);

    if (move_uploaded_file($_FILES['files']['tmp_name'], $fichero_subido)) {
        echo "El fichero es válido y se subió con éxito.\n";
    } else {
        echo "¡Posible ataque de subida de ficheros!\n";
    }

    header("Location: ../files.php");

?>
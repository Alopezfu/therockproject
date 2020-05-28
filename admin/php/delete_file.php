<?php

    require_once 'core.php';
    require_once 'ddbb.php';
    checkLogin(true);

    unlink("/sitios/". $_SESSION['username'] . "/" . $_GET['name']);
    header("Location: ../files.php");

?>
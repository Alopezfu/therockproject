<?php

    require_once 'core.php';
    require_once 'ddbb.php';

    $query = mysqli_query($connect,"DELETE from users WHERE id='$_GET[id]'");
    exec("deployment/add_user.sh " . $_SESSION['username']);
    header("Location: b.php");
    

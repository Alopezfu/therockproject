<?php

    require_once 'core.php';
    require_once 'ddbb.php';

    $user = trim($_POST['user']);
    $pass = trim($_POST['pass']);

    if (!empty($user) && !empty($pass)){

        $query = mysqli_query($connect,"SELECT * FROM users WHERE username='$user' AND pass='$pass'");

        if ($result = mysqli_fetch_array($query)){

            $_SESSION['username'] = $result[1];
            header("Location: ../home.php");
        }else{

            header("Location: ../index.php?loginerror");
        }

    }else{

        header("Location: ../index.php?err");
    }

?>
<?php
    error_reporting(0);
    session_start();

    function checkLogin($status){

        if (!isset($_SESSION['username']) && $status){

            header("Location: /index.php");
        }else if (isset($_SESSION['username']) && !$status){

            header("Location: /home.php");
        }
    }

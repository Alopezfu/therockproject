<?php

    require_once 'core.php';
    require_once 'ddbb.php';

    $user = trim($_POST['user']);
    $pass = trim($_POST['pass']);
    $email = trim($_POST['email']);

    if (!empty($user) && !empty($pass) && !empty($email)){

        if (filter_var($email, FILTER_VALIDATE_EMAIL)){

            $query = mysqli_query($connect,"SELECT username FROM users WHERE username='$user'");

            if ($result = mysqli_fetch_array($query)){

                header("Location: ../reg.php?reguser");
            }else{

<<<<<<< HEAD
                $query = mysqli_query($connect,"INSERT INTO `users` (`username`, `email`, `pass`, `saldo`, `suscripcion`, `url`, `phpmyadmin`, `mysql_user`) VALUES ('$user', '$email', '$pass', '100.00', 'Anual', '$user.rock.com', '$user.rock.com/phpmyadmin', 'root')");
    		    exec("deployment/add_user.sh " . $user);
=======
                $query = mysqli_query($connect,"INSERT INTO `users` (`username`, `email`, `pass`, `saldo`, `suscripcion`, `phpmyadmin`, `url`, `mysql_user`) VALUES ('$user', '$email', '$pass', '100.00', 'Anual', '$user.rock.com', '$user.rock.com/phpmyadmin', 'root')");
    		exec("deployment/add_user.sh " . $user);
>>>>>>> 6ef0b0213390bf868e191f13e9e24e45c7ead273

                $_SESSION['username'] = $user;
                header("Location: ../home.php");
            }

        }else{

            header("Location: ../reg.php?emailerr");
        }

    }else{

        header("Location: ../reg.php?err");
    }

?>

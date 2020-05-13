<?php
    require_once 'php/core.php';
    checkLogin(false)
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <?php require_once 'includes/head.php'; ?>
</head>
<body id="bg-login">
    <div id="lg-form">
        <div class="title">
            <p>The Rock Project Registro</p>
        </div>
        <form action="php/reg.php" method="POST">
            <input type="name" placeholder="Nombre de usuario" name="user" autofocus autocomplete="off">
            <input type="email" placeholder="Correo" name="email">
            <input type="password" placeholder="Contraseña" name="pass">
            <input type="submit" value="Acceder">
        <a id="reg" href="index.php">Iniciar sesión</a>
        </form>
    </div>
    <?php
        if (isset($_GET['err'])){

            ?>
            <div class="msg-box-error">
                <p>Rellena todos los campos</p>
            </div>
            <?php
        }else if (isset($_GET['emailerr'])){

            ?>
            <div class="msg-box-error">
                <p>Email no válido.</p>
            </div>
            <?php
        }else if (isset($_GET['reguser'])){

            ?>
            <div class="msg-box-error">
                <p>Usuario en uso.</p>
            </div>
            <?php
        }
        
    ?>
</body>
</html>
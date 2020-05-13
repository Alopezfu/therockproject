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
            <p>The Rock Project Cpanel</p>
        </div>
        <form action="php/login.php" method="POST">
            <input type="name" placeholder="Nombre de usuario" name="user" autofocus autocomplete="off">
            <input type="password" placeholder="Contraseña" name="pass">
            <input type="submit" value="Acceder">
            <a id="reg" href="reg.php">Crear una cuenta</a>
        </form>
    </div>
    <?php
        if (isset($_GET['err'])){

            ?>
            <div class="msg-box-error">
                <p>Rellena todos los campos</p>
            </div>
            <?php
        }else if (isset($_GET['loginerror'])){

            ?>
            <div class="msg-box-error">
                <p>Datos introducidos no encontrados.</p>
            </div>
            <?php
        }
    ?>
</body>
</html>
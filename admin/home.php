<?php
    require_once 'php/core.php';
    require_once 'php/ddbb.php';
    checkLogin(true);
    $query = mysqli_query($connect,"SELECT * FROM users WHERE username='$_SESSION[username]'");
    $result = mysqli_fetch_array($query);

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <?php require_once 'includes/head.php'; ?>
</head>
<body id="bg-login">
    <main>
        <table>
            <thead>
                <td>Suscripción</td>
                <td>URL</td>
                <td>Mysql username</td>
                <td>Phpmyadmin</td>
            </thead>
            <tbody>
                <td><?= $result['suscripcion'] ?></td>
                <td><?= $result['url'] ?></td>
                <td><?= $result['mysql_user'] ?></td>
                <td><?= $result['phpmyadmin'] ?></td>
            </tbody>
        </table>
        <p id="user">Has entrado como <?= $_SESSION['username']; ?> (<a href="php/exit.php">Salir</a>)</p>
    </main>
</body>
</html>
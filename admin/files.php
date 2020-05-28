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
        <div id="folder">
            <?php
                $path    = '/sitios/'.$_SESSION[username];
                $files = scandir($path);
                foreach ($files as $key => $value) {
                    if ($key > 1){

                        echo $value . " <a href='php/delete_file.php?name=$value'>(delete)</a><br>";
                    }
                }
            ?>
        </div>
        <div id="folder">
            <form action="php/upload.php" method="post" enctype="multipart/form-data">
                <input type="file" name="files">
                <br>
                <input type="submit" value="Upload now" name="upload">
            </form>
        </div>
        <p id="user">Has entrado como <?= $_SESSION['username']; ?> (<a href="index.php">Ir a Home</a>)  (<a href="php/exit.php">Salir</a>)</p>
    </main>
</body>
</html>

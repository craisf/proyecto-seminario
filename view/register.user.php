<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Estilos bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
        <link rel="stylesheet" href="../style/register.user.css">
        <title>Registrate en Refugio Patitas del Sur</title>
    </head>

    <body>
        <div class="navbar">
            <div class="navbar-left">
                <span class="navbar-text" style="cursor:pointer;" onclick="window.location.href='../Index.php'">Restaurant Gusteau's</span>
            </div>
            <button class="login-button" type="button" onclick="window.location.href='./login.php'">Log in</button>
        </div>
        <div class="container">
            <img src="../img/gusteau.jpg" alt="Logo de la empresa" class="logo">
            <span class="registrar-titulo">
                Register at the gusteau's restaurant and start the experience of your life!
            </span>
            <form method="post" id="registro-form" action="../Controller/Registrar.Usuario.Controller.php">
                <input type="email" name="email" id="email" class="textbox" placeholder="Enter your email" required>
                <button class="button" type="submit" name="btn-registrar">Register</button>
            </form>
        </div>    
        <footer>
            <p>All rights reserved Gusteau's Restaurant © 2023</p>
        </footer>
    </body>
</html>
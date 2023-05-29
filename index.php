<?php
session_start();
if (isset($_SESSION["seguridad"]) && $_SESSION["seguridad"]["login"]) {
	header("Location:./view/menu.php");
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <!-- estilo bootstrap -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>

<body class="bg-secondary d-flex justify-content-center align-items-center vh-100">
	<div class="bg-white p-5 rounded-5 text-secondary shadow">
		<div class="d-flex justify-content-center text-secondary" style="width:25 rem"> 
			<img src="./img/ratatouille.png" alt="login-logo"
			 style="height: 10rem">
		</div>
		<div class="text-center fs-1 fw-bold">Login</div>
		<div class="input-group mt-4">
			<div class="input-group-text bg-info">
				<img src="./img/ramen.png" alt="username-icon"
				style="height: 1.5rem"/>
			</div>
			<input class="form-control" type="text" placeholder="username" id="userName">
		</div>
		<div class="input-group mt-1">
			<div class="input-group-text bg-info">
				<img src="./img/pizza.png" alt="password-icon"
				style="height: 1.5rem" />
			</div>
			<input class="form-control" type="password" placeholder="password" id="password">
		</div>
		<div class="d-flex justify-content-around mt-1">
			<div class="d-flex align-items-center gap-1">
				<input class="form-check-input" type="checkbox">
				<div class="pt-1" style="font-size: 0.9rem">Remenber me</div>
			</div>
			<div class="pt-1">
				<a href="" class="text-decoration-none text-info fw-semibold fst-italic" style="font-size: 0.9rem">Forgot your password</a>
			</div>
		</div>
		<div class="btn btn-info text-white w-100 mt-1 fw-senibold shadow-sm" id="Log_in">Login</div>
		
		<div class="d-flex gap-1 justify-content-center mt-1">
			<div>Don't have an account?</div>
			<a href="./register.user.php" class="text-decoration-none text-info fw-semibold">Register</a>
		</div>
		<div class="p-3">
			<div class="border-bottom text-center" style="height: 0.9rem">
				<span class="bg-white px-3">or</span>
			</div>
		</div>
		<div class="btn d-flex gap-2 justify-conter-center border mt-3 shadow-sm">
			<img src="./img/google.png" alt="google-icon"
			style="height: 1.6rem">
			<div class="fw-semibold text-secondary">Continue with google?</div>
		</div>
	</div>


 <!--  <div class="container mt-3">
		<div class="row">
			<div class="col-md-5">
				<div class="card mt-5">
					<div class="card-header ">
						<strong>Fast and Hot Restaurant</strong>
					</div>
					<div class="card-body py-4 ">
						<form action="" id="form" autocomplete="of">
							<div class="mb-3">
								<label for="email" class="form-label">User Name</label>
								<input type="text" id="userName" class="form-control" autocomplete="off">
							</div>
							<div class="mb-3">
								<label for="password" class="form-label">Password</label>
								<input type="password" id="password" class="form-control" autocomplete="off">
							</div>
							<div><span>Don't have an account? <a href="./register.user.php">Register here?</a></span></div>
						</form>
					</div>
					<div class="card-footer text-end">
						<button class="btn btn-sm btn-primary" id="Log_in">Log in</button>
						<a class="btn btn-sm btn-primary" width="45" href="../index.php">Cancel</a>						
					</div>
				</div>
			</div>	
		</div>
		
	</div> -->

	<script src="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/alertify.min.js" integrity="sha512-JnjG+Wt53GspUQXQhc+c4j8SBERsgJAoHeehagKHlxQN+MtCCmFDghX9/AcbkkNRZptyZU4zC8utK59M5L45Iw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script>
        document.addEventListener("DOMContentLoaded", () => {
						const username = document.querySelector("#userName");
						const password = document.querySelector("#password");
            const Login = document.querySelector("#Log_in");


            function login(){
              const parametros = new URLSearchParams();
              parametros.append('operacion','iniciarSesion');
              parametros.append("nombreusuario", username.value);
							parametros.append("password", password.value);
              fetch ("./controllers/login.controller.php",{
                method: 'POST',
                body: parametros
              })
                .then(response =>response.json())
                .then(datos=>{					
					if(datos.login){
						if(datos){
							location.href = './view/graphic.php'
						}else{
							location.href = 'index.php'										
						}
					}else{	
					}							
                })
            }

						Login.addEventListener("click", login);
						// password.keypress(function(evt){
						// 	if(evt.Keycode == 13){
						// 		login();
						// 	}
						// })
						

        })
    </script>
</body>
</html>
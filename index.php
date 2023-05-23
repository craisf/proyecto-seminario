<?php
session_start();
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GUSTEAU'S</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<link rel="stylesheet" href="./style/index.style.css">
	<link rel="stylesheet" href="./Bootstrap/css/bootstrap.min.css"> 
	<link rel="stylesheet" href="">
</head>

<body>
	<div class="container-fluid">
		<div class="row">
			<div class="d-flex flex-column justify-content-between col-auto bg-dark min-vh-100">
				<div class="mt-4">
					<a href="" class="text-white d-none d-sm-inline text-decoration-none d-flex align-items-center ms-4" role="button">
						<span class="fs-5">GUSTEAU</span>	
					</a>
					<hr class="text-white d-none d-sm-block" />
					<ul class="nav nav-pills flex-column mt-2 mt-sm-0 " id="menu">
						<li class="nav-item my-sm-1 my-2">
							<a href="#" class="nav-link text-white text-center text-sm-start" aria-current="page">
								<i class="fa fa-gauge"></i>
								<span class="ms-2 d-none d-sm-inline">Dahboard</span>
							</a>
						</li>
						<li class="nav-item my-sm-1 my-2">
							<a href="#" class="nav-link text-white" aria-current="page">
								<i class="fa fa-house"></i>
								<span class="ms-2 d-none d-sm-inline">Home</span>
							</a>
						</li>
						<li class="nav-item my-ms-1 my-2 disabled ">
							<a href="#sidemenu" data-bs-toggle = "collapse" class="nav-link text-white"aria-current="page">
								<i class="fa fa-table"></i>
								<span class="ms-2 d-none d-sm-inline ">Product</span>
								<i class="fa fa-caret-down"></i>
							</a>
							<ul class="nav collapse ms-1 flex-column" id="sidemenu" data-bs-parent="#menu">
									<li class="nav-item">
											<a class="nav-link text-white" href="#" aria-current="page">Item 1</a>
									</li>
									<li class="nav-item">
											<a class="nav-link text-white" href="#">Item 2</a>
									</li>								
							</ul>
						</li>
						<li class="nav-item my-sm-1 my-2">
							<a href="#" class="nav-link text-white" aria-current="page">
								<i class="fa fa-users"></i>
								<span class="ms-2 d-none d-sm-inline">Users</span>
							</a>
						</li>
					</ul>						
				</div>	
				<div>
					<?php
					if (isset($_SESSION["seguridad"]) && $_SESSION["seguridad"]["login"]) {
						$nombreusuario = $_SESSION["seguridad"]["nombre"] . ' ' . $_SESSION["seguridad"]["apellido"];
						echo '
							<div class="dropdown open">
							<a class="btn border-none outline-none text-white dropdown-toggle" type="button" id="triggerId" data-bs-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false">
								 <i class="fa fa-user"><span class="ms-1 d-none d-sm-inline">'. $nombreusuario . '</span> </i>
							</a>
							<div class="dropdown-menu" aria-labelledby="triggerId">
								<a class="dropdown-item" href="#">Profile</a>
								<a class="dropdown-item" href="./controllers/login.controller.php?operacion=cerrarSesion">Log out</a>
							</div>
						</div>
							';
					} else {
						echo '<a lass="btn border-none outline-none text-white dropdown-toggle" type="button" id="triggerId" data-bs-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false" href="./index.php>Log in</a></li>';
					}
					?>					
				</div>
			</div>
		</div>
	</div>

	<nav class="navbar bg-light" >
		<div class="container-fluid">
			<a  class="nav-brand" href="#">
				<img src="./img/gusteau.jpg" alt="logo"  class="logo" width="120" height="90" >
			</a>
			<div class="d-flex">
						<?php
						if (isset($_SESSION["seguridad"]) && $_SESSION["seguridad"]["login"]) {
							$nombreusuario = $_SESSION["seguridad"]["nombre"] . ' ' . $_SESSION["seguridad"]["apellido"];
							echo '
								<div class="dropdown">
								<button class="btn bg-primary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">' .
								$nombreusuario . ' 
								</button>
								<ul class="dropdown-menu">						
									<li><a class="dropdown-item" href="./controllers/login.controller.php?operacion=cerrarSesion">Log out</a></li>									
								</ul>
							</div>
								';
						} else {
							echo '<a class="btn bg-primary" href="./view/login.php">Log in</a>';
						}
						?>
					</div>
		</div>
	</nav>
<!-- <header class="">
		<nav class="navbar bg-light py-2">
			<div class="container">			
						<a class="navbar-brand">
							<img src="./img/gusteau.jpg" alt="Logo de la empresa" class="logo">
						</a>							
				<div class="d-flex">
					<?php
					if (isset($_SESSION["seguridad"]) && $_SESSION["seguridad"]["login"]) {
						$nombreusuario = $_SESSION["seguridad"]["nombre"] . ' ' . $_SESSION["seguridad"]["apellido"];
						echo '
							<div class="dropdown">
							<button class="btn bg-primary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">' .
							$nombreusuario . ' 
							</button>
							<ul class="dropdown-menu">						
								<li><a class="dropdown-item" href="./controllers/login.controller.php?operacion=cerrarSesion">Log out</a></li>
								<li><a class="dropdown-item" href="./controllers/">grapic</a></li>
								<li><a class="dropdown-item" href="./controllers/">Log out</a></li>
							</ul>
						</div>
							';
					} else {
						echo '<a class="btn bg-primary" href="./view/login.php">Log in</a>';
					}
					?>
				</div>
			</div>
		</nav>
	</header> -->

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
</body>
</html>
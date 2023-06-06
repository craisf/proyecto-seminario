<?php
session_start();
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link rel="stylesheet" href="../style/index.style.css">
    <script src="https://kit.fontawesome.com/f676365a42.js" crossorigin="anonymous"></script>
</head>

<body>

    <div class="container-fluid">
        <div class="row flex-nowrap">
            <div class="d-flex  flex-column justify-content-between col-auto bg-dark min-vh-100">
                <div class="mt-4">
                    <a class="text-white d-none d-sm-inline text-decoration-none d-flex align-items-center ms-4"
                        role="button">
                        <span class="fs-5">GUSTEAU</span>
                    </a>
                    <hr class="text-white" />
                    <ul class="nav nav-pills flex-column mt-2 mt-sm-0" id="menu">
                        <li class="nav-item my-1">
                            <a href="graphic.php" class="nav-link text-white" aria-current="page">
                                <i class="fa fa-home"></i>
                                <span class="ms-2 d-none d-sm-inline">Home</span>
                            </a>
                        </li>
                        <li class="nav-item my-1 disabled">
                            <a href="#sidemenu" data-bs-toggle="collapse" class="nav-link text-white"
                                aria-current="page">
                                <i class="fa fa-table"></i>
                                <span class="ms-2 d-none d-sm-inline">Dashboar</span>
                                <i class="fa fa-caret-down"></i>
                            </a>
                            <ul class="nav collapse ms-1 flex-column" id="sidemenu" data-bs-parent="#menu">
                                <li class="nav-item">
                                    <a class="nav-link text-white" href="menu.php" aria-current="page">Orden</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link text-white" href="Producto.php" aria-current="page">Producto</a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item my-1 disabled">
                            <a href="#sidemenupdf" data-bs-toggle="collapse" class="nav-link text-white"
                                aria-current="page">
                                <i class="fa fa-table"></i>
                                <span class="ms-2 d-none d-sm-inline">PDF</span>
                                <i class="fa fa-caret-down"></i>
                            </a>
                            <ul class="nav collapse ms-1 flex-column" id="sidemenupdf" data-bs-parent="#menu">
                                <li class="nav-item">
                                    <a class="nav-link text-white" href="#" aria-current="page">PDF 1</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link text-white" href="#">PDF 2</a>
                                </li>
                            </ul>
                        </li>

                    </ul>
                </div>
                <div>
                    <?php
					if (isset($_SESSION["seguridad"]) && $_SESSION["seguridad"]["login"]) {
						$nombreusuario = $_SESSION["seguridad"]["apellido"];
						echo '					
						<div class="dropdown open">
							<a class="btn border-none outline-none text-white dropdown-toggle" type="button" id="triggerId" data-bs-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false">
								 <i class="fa fa-user"><span class="ms-1 d-none d-sm-inline">'. $nombreusuario . '</span> </i>
							</a>
							<div class="dropdown-menu" aria-labelledby="triggerId">
								<a class="dropdown-item" href="#">Profile</a>
								<a class="dropdown-item" href="../controllers/login.controller.php?operacion=cerrarSesion">Log out</a>
							</div>
						</div>
							';
					} else {
						echo '
						<a class="btn border-none outline-none text-white " type="button" id="triggerId" href="../index.php">log in</a>';
					}
					?>

                </div>
            </div>
            <div class="p-3 col-md-10 mt-3">
                <div class="row col-md-10 mt-3">
                    <div class="col-md-6">
                        <canvas id="grafico"></canvas>
                    </div>
                    <div class="col-md-6">
                        <canvas id="grafico1"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    </div>
    <div>
        <?php
					if (isset($_SESSION["seguridad"]) && $_SESSION["seguridad"]["login"]) {
						$nombreusuario =  $_SESSION["seguridad"]["apellido"];
						echo '					
						<div class="dropdown open">
							<a class="btn border-none outline-none text-white dropdown-toggle" type="button" id="triggerId" data-bs-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false">
								 <i class="fa fa-user"><span class="ms-1 d-none d-sm-inline">'. $nombreusuario . '</span> </i>
							</a>
							<div class="dropdown-menu" aria-labelledby="triggerId">
								<a class="dropdown-item" href="#">Profile</a>
								<a class="dropdown-item" href="../controllers/login.controller.php?operacion=cerrarSesion">Log out</a>
							</div>
						</div>
							';
					} else {
						echo '
						<a class="btn border-none outline-none text-white " type="button" id="triggerId" href="../index.php">log in</a>';
					}
					?>

    </div>

    </div>
    <div class="p-3 col-md-10 mt-3">
        <div class="row">
            <!-- Aqui renderizamos el grafico -->
            <div class="col-md-6">
                <canvas id="grafico"></canvas>
            </div>
        </div>
		<div class="col-md-6">
			<canvas id="grafico1"></canvas>
		</div>
    </div>
    </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous">
    </script>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>
    document.addEventListener("DOMContentLoaded", () => {
        const lienzo = document.getElementById('grafico');
        const lienzo1 = document.getElementById('grafico1');
        const bgcolores = ['#E56619','#F9C607', '#FF7420', '#07D8F9']

        const graficoBarras = new Chart(lienzo, {
            type: 'bar',
            data: {
                labels: [],
                datasets: [{
                    borderColor: '#E74C3C',
                    backgroundColor: bgcolores,
                    label: 'Cant Categoria',
                    data: [],
                    borderWidth: 1
                }]
            }
        })

        const graficoPie = new Chart(lienzo1, {
            type: 'doughnut',
            data: {
                labels: [],
                datasets: [{
                    borderColor: '#E74C3C',
                    backgroundColor: bgcolores,
                    label: 'Ventas',
                    data: [],
                    borderWidth: 1
                }]
            }
        })

		function cargargrafico(){
			const parametros = new URLSearchParams();
			parametros.append("operacion", "graficof")
			fetch("../controllers/Grafico.controller.php",{
				method: 'POST',
				body: parametros
			})			
				.then(res => res.json())
				.then(datos => {
					const idor =[];
					const canti = [];
					datos.forEach(element=>{
						idor.push(element.categoria);
						canti.push(element.cantidad);
					})
					graficoBarras.data.labels = idor;
					graficoBarras.data.datasets[0].data = canti;
					graficoBarras.update();
				})
		}


		function cargargrafico1(){
			const parametros = new URLSearchParams();
			parametros.append("operacion", "graficose");
			fetch("../controllers/Grafico.controller.php",{
				method: 'POST',
				body: parametros
			})
				.then( res => res.json())
				.then( datos =>{
					const emp = [];
					const ven = [];
					datos.forEach(element=>{
						emp.push(element.Empleado);
						ven.push(element.Ventas);
					})
					graficoPie.data.labels = emp;
					graficoPie.data.datasets[0].data = ven;
					graficoPie.update();
				})

		}

		cargargrafico();
		cargargrafico1();
    });
    </script>
</body>

</html>
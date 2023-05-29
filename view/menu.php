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
  <link rel="stylesheet" href="../style/index.style.css">  	
  <script src="https://kit.fontawesome.com/f676365a42.js" crossorigin="anonymous"></script>
</head>

<body>
	<div class="container-fluid">
		<div class="row flex-nowrap">
			<div class="d-flex  flex-column justify-content-between col-auto bg-dark min-vh-100">
				<div class="mt-4">
					<a class="text-white d-none d-sm-inline text-decoration-none d-flex align-items-center ms-4" role="button">
						<span class="fs-5">GUSTEAU</span>
					</a>
					<hr class="text-white"/>
					<ul class="nav nav-pills flex-column mt-2 mt-sm-0" id="menu">
						<li class="nav-item my-1">
							<a href="graphic.php" class="nav-link text-white" aria-current="page">
								<i class="fa fa-home"></i>
								<span class="ms-2 d-none d-sm-inline">Home</span>
							</a>
						</li>						
						<li class="nav-item my-1 disabled">
							<a href="#sidemenu" data-bs-toggle="collapse" class="nav-link text-white" aria-current="page">
								<i class="fa fa-table"></i>
								<span class="ms-2 d-none d-sm-inline">Dashboar</span>
								<i class="fa fa-caret-down"></i>
							</a>
							<ul class="nav collapse ms-1 flex-column" id="sidemenu" data-bs-parent="#menu">
								<li class="nav-item">
									<a class="nav-link text-white" href="menu.php" aria-current="page">Orden</a>
								</li>	
                <li class="nav-item">
									<a class="nav-link text-white" href="#" aria-current="page">Detalle</a>
								</li>													
							</ul>
						</li>
						<li class="nav-item my-1 disabled">
							<a href="#sidemenupdf" data-bs-toggle="collapse" class="nav-link text-white" aria-current="page">
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
				<!-- -- <button type="button" class="btn btn-sm btn-dark" data-bs-toggle="modal" data-bs-target="#modalId">Registrar Orden</button> -->
				<a href="" class="btn btn-dark btn-sm" type="button" data-bs-toggle="modal" data-bs-target="#modalId"><i class="fa-solid fa-money-bill-1-wave"></i>  Registrar Orden</a>
				<table id="tbmenu" class="table table-striped table-sm mt-3">
					<thead>
						<tr>
						<th>#</th>					
						<th>N° Mesa</th>
						<th>Empleado</th>
						<th>FechaOrden</th>
						<th>Estado</th>
						<th>Operaciones</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
					</table>

					<!-- Modal Body -->
					<!-- if you want to close by clicking outside the modal, delete the last endpoint:data-bs-backdrop and data-bs-keyboard -->
					<div class="modal fade" id="modalId" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" role="dialog" aria-labelledby="modalTitleId" aria-hidden="true">
						<div class="modal-dialog modal-dialog-scrollable modal-dialog-centered " role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="modalTitleId">Registar Orden</h5>
										<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<form action="" id="formProducts">																				
										<div class="mb-3">
											<label for="Mesa" class="form-label">Mesa</label>
											<input type="text" class="form-control form-control-sm text-end" id="mesa">
										</div>
										<div class="mb-3">
											<label for="Empleado" class="form-label">Empleado</label>
											<input type="text" class="form-control form-control-sm" id="empleado">
										</div>
										<div class="mb-3">
											<label for="Estado" class="form-label">Estado</label>
											<input type="text" class="form-control form-control-sm " id="estado">
										</div>																				
									</form>									
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-sm btn-secondary" data-bs-dismiss="modal">Cerrar</button>
									<button type="button" class="btn btn-sm btn-info" id="registrar">Registrar</button>
								</div>
							</div>
						</div>
					</div>			
			</div>			
		</div>

	</div>
	<div class="modal fade" id="modal-automoviles" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" role="dialog" aria-labelledby="modalTitleId" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-sm" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="modalTitleId">Actualizar Pedido</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="mb-3">
            <label for="md-Marca" class="form-label">Cliente</label>
            <input type="text" class="form-control form-control-sm" id="md-cliente">
          </div>
          <div class="mb-3">
            <label for="md-modelo" class="form-label">Producto</label>
            <input type="text" class="form-control form-control-sm" id="md-producto">
          </div>
          <div class="mb-3">
            <label for="md-precio" class="form-label">Mesa</label>
            <input type="text" class="form-control form-control-sm text-end" id="md-precio">
          </div>
          <div class="mb-3">
            <label for="md-tipoCombustible" class="form-label">Empleado</label>
            <input type="text" class="form-control form-control-sm" id="md-tipoCombustible">
          </div>
          <div class="mb-3">
            <label for="md-color" class="form-label">Estado</label>
            <input type="text" class="form-control form-control-sm " id="md-color">
          </div>          
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
          <button type="button" class="btn btn-primary" id="actualizar">Actualizar</button>
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
	<script>
		document.addEventListener("DOMContentLoaded", ()=>{


			const mesa =  document.getElementById("mesa");
			const empleado =  document.getElementById("empleado");
			const estado =  document.getElementById("estado");
			const btGuardar = document.getElementById("registrar");

			const tablaMenu = document.querySelector("#tbmenu");
      const cuerpoTabla = tablaMenu.querySelector("tbody");

			function renderData(){
				const parametros = new URLSearchParams();
				parametros.append("operacion", "listarMenu");

				fetch("../controllers/Menu.controller.php",{
					method: 'POST',
					body: parametros
				})
					.then(response => response.json())
					.then(datos =>{
						cuerpoTabla.innerHTML=``;
						datos.forEach(element =>{
              let fila = `
              <tr>
                <td>${element.idorden	}</td>  
                <td>${element.numesa}</td>
                <td>${element.Empleado}</td>
                <td>${element.fechahoraorden}</td>
								<td>${element.estado}</td>									
                <td>
                  <a href='#' class='eliminar' btn btn-danger btn-sm' data-idorden='${element.idorden}'><i class="fa-solid fa-trash"></i></a>
                  <a href='#' class='editar' btn btn-info btn-sm' data-idorden='${element.idorden}'><i class="fa-solid fa-pen-nib"></i></a>
                </td>
              </tr>
              `;
              cuerpoTabla.innerHTML +=fila;
					})	
				})				
			}
			function registrarMenu(){
				if(confirm("Esta seguro de Guardar La Orden")){
					const parametros = new FormData();
					parametros.append("operacion", "registrarMenu");
					parametros.append("mesa", mesa.value);
					parametros.append("empleado", empleado.value);
					parametros.append("estado", estado.value);
					fetch("../controllers/Menu.controller.php",{
						method: 'POST',
						body: parametros
					})
						.then(response => response.json())
						.then(datos=>{
							document.getElementById("formProducts").reset();
							renderData();
						})
				}
			}
			btGuardar.addEventListener("click",registrarMenu);
			

			renderData();
		});

	</script>
</body>
</html>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

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
            <div class="container">
                <div class="row mt-3 mb-3">
                    <div class="col-md-11">
                        <div class="card">
                            <div class="card-header bg-secondary text-light">
                                Registrar Producto
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <button type="button" class="btn btn-secondary col-md-12" data-bs-toggle="modal"
                                            data-bs-target="#modal-ag-producto">Registrar Producto</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- TABLA -->
                <div class="row">
                    <div class="col-md-12">
                        <table id="table-producto" class="table table-sm" style="width: 90%;" >
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>NombreProducto</th>
                                    <th>Descripcion</th>
                                    <th>Precio</th>
                                    <th>Categoria</th>
                                    <th>Detalle</th>
                                </tr>
        
                            </thead>
                            <tbody>
        
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- Modal Body -->
    <div class="modal fade" id="modal-ag-producto" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" role="dialog"
        aria-labelledby="modalTitleId" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg " role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitleId">Modal title</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="" id="form-producto">
                        <div class="form-group">
                            <label for="nombreProducto" class="form-label">Nombre del Producto</label>
                            <input type="text" id="nombreProducto" class="form-control form-control-sm">
                        </div>
                        <div class="form-group">
                            <label for="descripcion" class="form-label">Descripción</label>
                            <input type="text" id="descripcion" class="form-control form-control-lg">
                        </div>
                        <div class="form-group">
                            <label for="precio" class="form-label">Precio</label>
                            <input type="text" id="precio" class="form-control form-control-sm">
                        </div>
                        <div class="form-group">
                            <label for="categoria" class="form-label">Categoría</label>
                            <input type="text" id="categoria" class="form-control form-control-sm">
                        </div>                    
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-outline-secondary"  data-bs-dismiss="modal" id="ag-registrar">Guardar</button>
                </div>
            </div>
        </div>
    </div>


    <!-- Modal Body -->
    <div class="modal fade" id="md-update" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" role="dialog" aria-labelledby="modalTitleId" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitleId">Modal title</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="" id="form-producto">
                        <div class="form-group">
                            <label for="nombreProducto" class="form-label">Nombre del Producto</label>
                            <input type="text" id="md-nombreProducto" class="form-control form-control-sm">
                        </div>
                        <div class="form-group">
                            <label for="descripcion" class="form-label">Descripción</label>
                            <input type="text" id="md-descripcion" class="form-control form-control-sm">
                        </div>
                        <div class="form-group">
                            <label for="precio" class="form-label">Precio</label>
                            <input type="text" id="md-precio" class="form-control form-control-sm">
                        </div>
                        <div class="form-group">
                            <label for="categoria" class="form-label">Categoría</label>
                            <input type="text" id="md-categoria" class="form-control form-control-sm">
                        </div>                    
                    </form>                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="actualizar">Actualizar</button>
                </div>
            </div>
        </div>
    </div>
    
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous">
    </script>

    <script src="../js/Producto.js"></script>

</body>

</html>
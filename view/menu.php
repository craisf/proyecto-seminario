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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

    <link rel="stylesheet" href="../style/index.style.css">

    <script src="https://kit.fontawesome.com/f676365a42.js" crossorigin="anonymous"></script>

</head>

<body>
    <!-- INICIO DASHBOARD -->
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
                                    <a class="nav-link text-white" href="#" aria-current="page">Detalle</a>
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
                <a href="#" class="btn btn-outline-secondary" type="button" data-bs-toggle="modal"
                    data-bs-target="#modal-detalle-orden"><i class="fa-solid fa-money-bill-1-wave"></i> Registrar
                </a>
                <button type="button" class="btn btn-primary btn-lg" data-bs-toggle="modal"
                    data-bs-target="#modal-producto-agregar">
                    Launch
                </button>
                <button type="button" class="btn btn-primary btn-lg" data-bs-toggle="modal" data-bs-target="#modalId">
                    Launch
                </button>
                <div class="container-mesa " id="container-card">
                </div>
            </div>
        </div>
    </div>
    <!-- FIN DASHBOARD -->

    <!-- Modal  nueva orden -->
    <div class="modal fade" id="modal-orden" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false"
        role="dialog" aria-labelledby="modalTitleId" aria-hidden="true">

        <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title" id="modalTitleId">Registar</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="" autocomplete="off" id="form-orden-nueva">
                        <div class="row mb-5 d-flex justify-content-between">
                            <div class="col-md-5mb-1">
                                <div>
                                    <span class="col-form-label fw-semibold">Fecha <span
                                            class="fw-normal"><?php echo date('d/m/Y');?></span></span>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label for="md-mesa" class="col-form-label ">Mesa</label>
                                <input type="text" class="form-control" id="md-mesa" readonly>
                            </div>
                            <div class="col-md-8">
                                <label for="md-empleados" class="col-form-label">Empleados</label>
                                <select id="md-empleados" type="text" class="form-select">
                                    <option value="">Seleccione</option>
                                </select>
                            </div>
                        </div>
                        <div class="row mt-2 mb-5">
                            <div class="col-md-6">
                                <label for="md-producto" class="form-label">Producto</label>
                                <select id="md-producto" class="form-select ">
                                    <option value="">Seleccione</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label for="md-cantidad" class="form-label">Cantidad</label>
                                <input type="number" class="form-control" id="md-cantidad" value="1">
                            </div>
                            <div class="col-md-3">
                                <label for="md-precio" class="form-label">Precio</label>
                                <input type="number" class="form-control" id="md-precio" readonly>
                            </div>
                            <div class="col-md-3 mt-3">
                                <label for="md-total" class="form-label">total</label>
                                <input type="number" class="form-control" id="md-total" readonly>
                            </div>
                            <div class="col-md-1 align-self-end ">
                                <button type="button" class="btn btn-outline-secondary" id="md-producto-agregar"><i
                                        class="fa-solid fa-circle-plus"></i></button>
                            </div>
                        </div>
                        <table class="table table-striped table-sm mt-2 mb-5" id="md-tabla-datalle-orden">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Producto</th>
                                    <th>Cantidad</th>
                                    <th>Precio</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>

                        <div class="row justify-content-end mb-1">
                            <label for="md-total" class="col form-label col-sm-1">Total:</label>
                            <div class="col-sm-2">
                                <input type="md-total" type="tetx" class="form-control text-end" readonly>
                            </div>
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
    <!-- Fin modal  -->


    <!-- INICIO MODAL DETALLE-->
    <div class="modal fade" id="modal-detalle-orden" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false"
        role="dialog" aria-labelledby="modalTitleId" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg " role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title" id="modalTitleId">Detalle Orden</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row  justify-content">
                        <div class="col-md-4">
                            <label class="col-form-label">Hora y fecha</label>
                            <input type="text" class="form-control" id="md-dt-fecha" readonly>
                        </div>
                    </div>

                    <div class=" row mb-3">
                        <div class="col-md-6">
                            <label class="col-form-label ">Mesa </label>
                            <input type="text" class="form-control" id="md-dt-mesa" readonly>
                        </div>
                        <div class="col-md-6">
                            <label class="col-form-label">Empleado</label>
                            <input type="text" id="md-dt-empleado" class="form-control" readonly>
                        </div>
                    </div>
                    <div class="mb-3">
                        <table class="table table-striped table-sm mt-2 mb-5" id="md-dt-tabla-datalle-orden">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Producto</th>
                                    <th>Cantidad</th>
                                    <th>Precio</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                        <div class="row justify-content-end mb-1">
                            <label for="md-dt-total" class="col form-label col-sm-1">Total:</label>
                            <div class="col-sm-2">
                                <input id="md-dt-total" type="text" class="form-control text-end" readonly>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>
    <!-- FIN MODAL -->


    <!-- Inicio modal-agproducto -->
    <div class="modal fade" id="modal-producto-agregar" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false"
        role="dialog" aria-labelledby="modalTitleId" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title" id="modalTitleId">Agregar</h1>
                </div>
                <div class="modal-body">
                    <form action="" autocomplete="off" class="container" id="md-agproducto">
                        <div class="row mb-1">
                            <label for="ag-producto" class="form-label">Producto</label>
                            <select name="" id="ag-producto" class="form-select">
                                <option value="">Seleccione</option>
                            </select>
                        </div>
                        <div class="row mb-1">
                            <div class="col-md-4">
                                <label for="ag-cantidad" class="form-label">Cantidad</label>
                                <input type="number" class="form-control" id="ag-cantidad" value="1">
                            </div>
                            <div class="col-md-4">
                                <label for="ag-precio" class="form-label">Precio</label>
                                <input type="number" class="form-control" id="ag-precio" readonly>
                            </div>
                            <div class="col-md-4">
                                <label for="ag-total" class="form-label">total</label>
                                <input type="number" class="form-control" id="ag-total" readonly>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" id="ag-agregar">Agregar</button>
                </div>
            </div>
        </div>
    </div>
    <!-- FIN MODAL -->

    <!-- Modal trigger button -->


    <!-- Modal Body -->    
    <div class="modal fade" id="modalId" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" role="dialog"
        aria-labelledby="modalTitleId" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitleId">Modal title</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Body
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save</button>
                </div>
            </div>
        </div>
    </div>
    <!-- FIN MODAL -->
                

    <!-- Optional: Place to the bottom of scripts -->
    <script>
    const myModal1 = new bootstrap.Modal(document.getElementById('modalId'), options)
    </script>

    <!-- Optional: Place to the bottom of scripts -->
    <script>
    const myModal = new bootstrap.Modal(document.getElementById('modalId'), options)
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous">
    </script>
    <script src="../js/Orden.js"></script>
</body>

</html>
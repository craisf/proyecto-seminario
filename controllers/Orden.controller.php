<?php
require_once '../models/Orden.model.php';


if(isset($_POST['operacion'])){
  
  $orden = new Orden();


  if($_POST["operacion"] == 'listar'){
    echo json_encode($orden->listar());
    /* $datos = $menu->ListarMenu();
    if ($datos){
      echo json_encode($datos);
    } */
  }

  if($_POST['operacion'] == 'registrarMenu'){
    $datosGuardar = [      
      "idmesa"      => $_POST['idmesa'],
      "idempleado"  => $_POST['idempleado'],      
    ];
    $respuesta = $menu->RegistrarMenu($datosGuardar);
    echo json_encode($respuesta);

  }

  if($_POST['operacion']== 'ListarMesa'){
    $datos = $menu->listarMesas();
    if($datos){
      echo json_encode($datos);
    }
  }

  if($_POST['operacion']== 'Listarcarta'){
    $datos = $menu->listarCarta();
    if($datos){
      echo json_encode($datos);
    }
  }
}
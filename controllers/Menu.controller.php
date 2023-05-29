<?php
require_once '../models/Menu.model.php';


if(isset($_POST["operacion"])){
  
  $menu = new Menu();


  if($_POST["operacion"] == 'listarMenu'){
    echo json_encode($menu->ListarMenu());
    /* $datos = $menu->ListarMenu();
    if ($datos){
      echo json_encode($datos);
    } */
  }

  if($_POST["operacion"] == 'RegistrarMenu'){
    $datosGuardar = [
      "idmesa" => $_POST['idmesa'],
      "idempleado" => $_POST['idempleado'],
      "idcliente" => $_POST['idcliente'],
      "idestadoorden" => $_POST['idestadoorden']
    ];
    $respuesta = $menu->RegistrarMenu($datosGuardar);
    echo json_encode($respuesta);

  }
}
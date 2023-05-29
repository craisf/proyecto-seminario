<?php
require_once '../models/Menu.model.php';


if(isset($_POST['operacion'])){
  
  $menu = new Menu();


  if($_POST["operacion"] == 'listarMenu'){
    echo json_encode($menu->ListarMenu());
    /* $datos = $menu->ListarMenu();
    if ($datos){
      echo json_encode($datos);
    } */
  }

  if($_POST['operacion'] == 'registrarMenu'){
    $datosGuardar = [      
      "idmesa"      => $_POST['idmesa'],
      "idempleado"  => $_POST['idempleado'],      
      "idestado"    => $_POST['idestadoorden']
    ];
    $respuesta = $menu->registrarMenu($datosGuardar);
    echo json_encode($respuesta);

  }
}
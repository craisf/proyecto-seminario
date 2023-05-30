<?php
require_once '../models/Menu.model.php';


if(isset($_POST['operacion'])){
  
  $menu = new Menu();


  if($_POST["operacion"] == 'MostrarMesas'){
    echo json_encode($menu->mostrarMesas());
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
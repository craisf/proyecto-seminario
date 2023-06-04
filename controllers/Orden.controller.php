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

  if($_POST['operacion'] == 'registrarOrden'){
    $datos =[
      "idmesa"  => $_POST["idmesa"],
      "idempleado" => $_POST["idempleado"]
    ];
    $resultado = $orden->registrarOrden($datos);
    echo json_encode($resultado);

  }

  if($_POST['operacion'] == 'buscarOrden'){
    $datos = $orden->buscar($_POST['idorden']);
    echo json_encode($datos);
  }

  if($_POST['operacion'] == 'VentaxMesa'){
    $datos = $orden->ventaxmesa($_POST['idmesa']);
    echo json_encode($datos);
  }
  
  if($_POST['operacion'] == 'DetalleOrden'){
    $datos =[
      "idorden"  => $_POST["idorden"],
      "idmesa"  => $_POST["idmesa"],
    ];
    $resultado = $orden->detalle_orden($datos);
    echo json_encode($resultado);
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

  if($_POST['operacion'] == 'registrardetalleorden'){
    $datos=[
      "idproducto" => $_POST["idproducto"],
      "cantidad" => $_POST["cantidad"]
    ];
    $resultado = $orden->RegistrarDetalleOrden($datos);
    echo json_encode($resultado);
  }
  
}
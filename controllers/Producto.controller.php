<?php
require_once '../models/Producto.model.php';

if (isset($_POST['operacion'])){
  

    $producto = new Producto();

    //PROCESO PRINCIPAL
    if($_POST['operacion']== 'listarProductos'){
        $datos = $producto->listarProductos();
        echo json_encode($datos);
    }

    //CRUD
    if($_POST['operacion'] == 'listar'){
        $datos = $producto->listar();
        echo json_encode($datos);
    }

    if($_POST['operacion'] == 'Registrar'){
        $datos=[
          "nombreproducto" => $_POST["nombreproducto"],
          "descripcion" => $_POST["descripcion"],
          "precio" =>$_POST["precio"],
          "categoria"=> $_POST["categoria"]        
        ];
        $resultado = $producto->registrar($datos);
        echo json_encode($resultado);
    }

    if ($_POST['operacion'] == 'eliminar') {
      $respuesta = $producto->eliminar($_POST['idproducto']);
      echo json_encode($respuesta);
    }

    if ($_POST['operacion'] == 'obtener'){
      $respuesta = $producto->obtener($_POST['idproducto']);
      echo json_encode($respuesta);
    }

    if($_POST['operacion'] == 'actualizar'){
      $datos=[
        "idproducto"        => $_POST['idproducto'],
        "nombreproducto"    => $_POST['nombreproducto'],
        "descripcion"       => $_POST['descripcion'],
        "precio"            => $_POST['precio'],
        "categoria"         => $_POST['categoria']        
      ];
      $respuesta = $producto->actualizar($datos);
      echo json_encode($respuesta);
    }
    
}
?>
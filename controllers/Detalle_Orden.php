<?php
require_once '../controllers/Detalle_Orden.php';

if(isset($_POST['operacion'])){
    $detalleorden = new DetalleOrden();

    if($_POST['operacion'] == 'registrar'){
        $datos=[
            "idorden"   => $_POST["idorden"],
            "idproducto" => $_POST["idproducto"],
            "cantidad"  => $_POST["cantidad"]
        ];
        $resultado =  $detalleorden->registrar($datos);
        echo json_encode($resultado);
    }
}
?>
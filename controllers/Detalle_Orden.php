<?php
require_once '../models/Detalle_Orden.php';

if(isset($_POST['operacion'])){
    $detalleorden = new DetalleOrden();

    if($_POST['operacion'] == 'registrar'){
        $datos=[
            "idmesa"   => $_POST["idmesa"],
            "idproducto" => $_POST["idproducto"],
            "cantidad"  => $_POST["cantidad"],
            "precio" => $_POST["precio"]
        ];
        $resultado =  $detalleorden->registrar($datos);
        echo json_encode($resultado);
    }
}
?>
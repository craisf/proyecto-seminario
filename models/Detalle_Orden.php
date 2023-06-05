<?php
require_once 'conexion.php';

class DetalleOrden extends Conexion{
    private $conexion;

    public function __CONSTRUCT(){
        $this->conexion = parent::getConexion();

    }

    public function registrar($datos=[]){
        $respuesta =[
            "status" => false,
            "message" => ""
        ];
        try{
            $consulta = $this->conexion->prepare("CALL spu_detalle_orden_registrar (?,?,?)");
            $respuesta["status"] = $consulta->execute(array(
                $datos["idorden"],
                $datos["idproducto"],
                $datos["cantidad"]
            ));
            $respuesta["message"] = ($respuesta["status"])  ?"Registrado correctamente"  : "Error";
            return $respuesta;
        }catch(Exception $e){
            die($e->getMessage());

        }
    }
}
?>
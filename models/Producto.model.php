<?php
require_once 'conexion.php';

class Producto extends Conexion{
    private $conexion;

    public function __CONSTRUCT(){
        $this->conexion = parent::getConexion();
    }

    public function listarProductos(){
        try{
            $consulta = $this->conexion->prepare("CALL spu_listar_productos()");
            $consulta->execute();
            return $consulta->fetchAll(PDO::FETCH_ASSOC);
        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    public function listar(){
        try{
            $consulta = $this->conexion->prepare("CALL spu_producto_listar()");
            $consulta->execute();
            return $consulta->fetchAll(PDO::FETCH_ASSOC);            
        }catch(Exception $e){
            die($e->getMessage());

        }
    }

    public function registrar($datos=[]) {
        $respuesta = [
            "status" => false,
            "message" => ""
        ];
    
        try {        
            $consulta = $this->conexion->prepare("CALL spu_producto_registrar(?,?,?,?)");
            $respuesta["status"] = $consulta->execute(array(
                $datos["nombreproducto"],
                $datos["descripcion"],
                $datos["precio"],
                $datos["categoria"]
            ));
    
            $respuesta["message"] = ($respuesta["status"]) ? "Producto Registrado" : "Error";
    
            return $respuesta;
        } catch (Exception $e) {
            die($e->getMessage());
        }    
    }

    public function eliminar($idproducto = 0){
        $respuesta=[
            "status" => false,
            "message" => ""
        ];
        try{
            $consulta= $this->conexion->prepare("CALL spu_producto_eliminar(?)");
            $respuesta["status"]= $consulta->execute(array($idproducto));
            $respuesta["message"] = ($respuesta["status"]) ? "Producto Eliminado" : "Error al Eliminar";
            return $respuesta;
        }catch(Exception $e){
            die($e->getMessage());

        }
    }

    public function obtener($idproducto = 0){
        try{
            $consulta = $this->conexion->prepare("CALL spu_producto_obt(?)");
            $consulta->execute(array($idproducto));
            return $consulta->fetch(PDO::FETCH_ASSOC);
        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    public function actualizar($datos=[]){
        $respuesta =[
            "status" => false,
            "message" => ""
        ];
        try{
            $consulta = $this->conexion->prepare("CALL spu_producto_actualizar(?,?,?,?,?)");
            $respuesta["status"]= $consulta->execute(array(
                $datos["idproducto"],
                $datos["nombreproducto"],
                $datos["descripcion"],
                $datos["precio"],
                $datos["categoria"]
            ));      

            $respuesta["message"] = ($respuesta["status"]) ? "Producto Actualizado" : "Error";
    
            return $respuesta;      
        }catch(Exception $e){
            die($e->getMessage());
        }
    }
    
}

?>
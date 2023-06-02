<?php
require_once 'conexion.php';

class Producto extends Conexion{
    private $conexion;

    public function __CONSTRUCT(){
        $this->conexion= parent::getConexion();
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
}

?>
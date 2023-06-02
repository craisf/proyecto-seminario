<?php
require_once 'conexion.php';

class Mesa extends Conexion{
    private $conexion;
    public function __CONSTRUCT(){
        $this->conexion = parent::getConexion();    
    }

    public function listar(){
        try{
            $consulta= $this->conexion->prepare("CALL spu_listar_mesas()");
            $consulta->execute();
            return $consulta->fetchAll(PDO::FETCH_ASSOC);
        }catch(Exception $e){
            die($e->getMessage());
        }
    }

}
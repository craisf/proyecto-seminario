<?php
require_once 'conexion.php';

class Grafico extends Conexion{
    private $conexion;

    public function __CONSTRUCT(){
      $this->conexion  = parent::getConexion();
    }


    public function graficof() {
        try {
          $consulta = $this->conexion->prepare("CALL spu_grafico()");
          $consulta->execute();
          return $consulta->fetchAll(PDO::FETCH_ASSOC);
        } catch(Exception $e) {
          die($e->getMessage());
        }
    }

    public function graficose() {
        try {
          $consulta = $this->conexion->prepare("CALL spu_graficose()");
          $consulta->execute();
          return $consulta->fetchAll(PDO::FETCH_ASSOC);
        } catch(Exception $e) {
          die($e->getMessage());
        }
    }
}


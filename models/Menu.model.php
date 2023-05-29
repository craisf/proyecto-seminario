<?php
require_once 'conexion.php';

class Menu extends Conexion{
  private $conexion;

  public function __CONSTRUCT(){
    $this->conexion  = parent::getConexion();
  }


  public function ListarMenu(){
    try{
      $consulta = $this->conexion->prepare("CALL spu_listar_ordenes()");
      $consulta->execute();
      return $consulta->fetchAll(PDO::FETCH_ASSOC);
    }
    catch(Exception $e){
      die($e->getMessage());
    }
  }


  public function registrarMenu($datos = []){
    $respuesta = [
      "status" => false,
      "message" => ""
    ];
    try{
      $consulta = $this->conexion->prepare("CALL spu_registrar(?,?,?)");
      $respuesta["false"] = $consulta->execute(
        array(
        $datos["idmesa"],
        $datos["idempleado"],      
        $datos["idestadoorden"]      
        )
      );      
    }
    catch(Exception $e){
      die($e->getMessage());
    }
    return $respuesta;
  }
}
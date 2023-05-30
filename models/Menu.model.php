<?php
require_once 'conexion.php';

class Menu extends Conexion{
  private $conexion;

  public function __CONSTRUCT(){
    $this->conexion  = parent::getConexion();
  }


  public function mostrarMesas(){
    try{
      $consulta = $this->conexion->prepare("CALL spu_listar_mesas()");
      $consulta->execute();
      return $consulta->fetchAll(PDO::FETCH_ASSOC);
    }
    catch(Exception $e){
      die($e->getMessage());
    }
  }


  public function RegistrarMenu($datos =[]){
    $respuesta = [
      "status" => false,
      "message" => ""
    ];
    try{
      $consulta = $this->conexion->prepare("CALL spu_registrar(?,?,?)");
      $respuesta ["status"]=$consulta->execute(
        array(
        $datos["idmesa"],
        $datos["idempleado"]
        )
      ); 
          
    }     
    catch(Exception $e){
      die($e->getMessage());
    }  
    return $respuesta;    
  }

  public function listarMesas(){
    try{
      $consulta = $this->conexion->prepare("SELECT * FROM mesas");
      $consulta->execute();
      return $consulta->fetchAll(PDO::FETCH_ASSOC);
    }
    catch(Exceptio $e){
      die($e->getMessage());
    }
  }

  public function listarCarta(){
    try{
      $consulta = $this->conexion->prepare("SELECT * FROM productos");
      $consulta->execute();
      return $consulta->fetchAll(PDO::FETCH_ASSOC);
    }
    catch(Exceptio $e){
      die($e->getMessage());
    }
  }

}
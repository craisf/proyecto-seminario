<?php
require_once 'conexion.php';

class Orden extends Conexion{
  private $conexion;

  public function __CONSTRUCT(){
    $this->conexion  = parent::getConexion();
  }


  public function listar(){
    try{
      $consulta = $this->conexion->prepare("CALL spu_listar_ordenes()");
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


}
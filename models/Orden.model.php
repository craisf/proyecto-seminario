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

  public function buscar($idorden=0){
    try{
      $consulta = $this->conexion->prepare("CALL spu_ordenes_buscar(?)");
      $consulta->execute(array($idorden));
      return $consulta->fetch(PDO::FETCH_ASSOC);
    }
    catch(Exception $e){
      die($e->getMessage());
    }
  }

  public function ventaxmesa($idmesa=0){
    try{
      $consulta = $this->conexion->prepare("CALL spu_ventaxmesa(?)");
      $consulta->execute(array($idmesa));
      return $consulta->fetch(PDO::FETCH_NUM);
    }catch(Exception $e){
      die($e->getMessage());
    }
  }

  public function detalle_orden($datos){
    try{
      $consulta = $this->conexion->prepare("CALL spu_detalle_orden(?,?)");
      $consulta->execute(array(
        $datos["idorden"],
        $datos["idmesa"]
      ));
      return $consulta->fetchAll(PDO::FETCH_ASSOC);
    }catch(Exception $e){
      die($e->getMessage());
    }
  }

  public function registrarOrden($datos =[]){
    $respuesta = [
      "status" => false,
      "message" => ""
    ];
    try{
      $consulta = $this->conexion->prepare("CALL spu_registrar_orden?,?)");
      $respuesta ["status"]=$consulta->execute(
        array(
        $datos["idmesa"],
        $datos["idempleado"]
        )
      ); 
      $respuesta["message"] = ($respuesta["status"]) ? "Registrado" : "Error";
      return $respuesta;          
    }     
    catch(Exception $e){
      die($e->getMessage());
    }  
    
  }

  public function RegistrarDetalleOrden($datos=[]){
    $respuesta = [
      "status" => false,
      "message" => ""
    ];
    try{
      $consulta = $this->conexion->prepare("CALL spu_registar_detalle_orden(?,?,?)");
      $respuesta["status"]= $consulta->execute(array(
        $datos["idproducto"],
        $datos["cantidad"]
      ));
      $respuesta["message"] = ($respuesta["message"]) ? "Registrado" : "Error";
      return $respuesta;
    }catch(Exception $e){
      die($e->getMessage());
    }
  }


}
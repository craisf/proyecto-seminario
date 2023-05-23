<?php
require_once 'conexion.php';

class User extends Conexion{
    private $conectar;
    public function __CONSTRUCT(){
        $conexion = new Conexion();
        $this->conectar = $conexion->getConexion();
    }
    
    public function Login($nombreusuario=""){
        try{
            $consulta = $this->conectar->prepare("CALL spu_user_login(?)");
            $consulta->execute(array($nombreusuario));
            return $consulta->fetch(PDO::FETCH_ASSOC);            
        }
        catch(Exception $e){
            die($e->getmessage());
        }
    }
}
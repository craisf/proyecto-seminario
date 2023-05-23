<?php
require_once './conexion.php';

class Login extends Conexion{
    private $conexion;
    public function __CONSTRUCT(){
        $this->conexion = parent::getConexion();
    }
    
    public function Login($nombreusuario=""){
        try{
            $consulta = $this->conexion->prepare("CALL (?)");
            $consulta->execute(array($nombreusuario));
            return $consulta->fetchAll(PDO::FETCH_ASSOC);            
        }
        catch(Exception $e){
            die($e->getMessage());
        }
    }
}
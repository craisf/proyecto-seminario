<?php

session_start();

include_once '../models/Login.model.php';

if (isset($_POST['operacion'])) {

  $user = new User();

  if($_POST['operacion'] == 'iniciarSesion'){
    $access = [
      "login" => false,
      "apellido" => "",
      "nombre" => "",
      "idusuario" => "",
      "nombrerol" => "",    
      "correo" => ""
    ];
    
    $data = $user->Login($_POST['nombreusuario']);
    $claveingresada = $_POST['password'];      
    if($data){      
      if(password_verify($claveingresada, $data['claveacceso'])){
        $access["login"] = true;
        $access["apellido"] = $data["apellido"];
        $access["nombre"] = $data["nombre"];
        $access["correo"] = $data["correo"];
        $access["idusuario"] = $data["idusuario"];
        $access["nombrerol"] = $data["nombrerol"];
      }else{
        $access["mensaje"] = "Password error please check";
      }
    }else{
      $access["mensaje"] = "User Name and Password not found";
    }
    $_SESSION["seguridad"] = $access;

     echo json_encode ($access);  
  }


}
if (isset($_GET['operacion'])) {
  if($_GET['operacion']== 'cerrarSesion'){
    session_destroy();
    session_unset();
    header('Location:..\index.php');
  }
}
<?php
//include("../seguridad.php");
require_once("conexion.php");

class Sucursal{

  
function ListaxUsuario($usuario_id)
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("SELECT * FROM sucursal INNER JOIN usuarioxsucursal ON sucursal.sucursal_id = usuarioxsucursal.sucursal_id WHERE usuario_id = ? ORDER BY sucursal_descripcion, sucursal_direccion");
    $consulta->execute(array($usuario_id));
    return $consulta;
    }    


function SelectxKey($key)
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("SELECT * FROM sucursal WHERE sucursal_key = ?");
    $consulta->execute(array($key));
    return $consulta->fetch();    
    }
    
   
   
}

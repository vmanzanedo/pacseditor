<?php
require_once("conexion.php");

class Modalidad{

  
function Lista()
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("SELECT * FROM modalidad ORDER BY modalidad_codigo, modalidad_descripcion");
    $consulta->execute();
    return $consulta;
    }

function SelectId($id)
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("SELECT * FROM modalidad WHERE modalidad_id = ?");
    $consulta->execute(array($id));
    return $consulta->fetch();    
    }
    
function SelectCodigoGroup($id)
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("SELECT GROUP_CONCAT(modalidad_codigo) AS codmodalidades FROM modalidad WHERE modalidad_id IN ($id)");
    $consulta->execute();
    return $consulta->fetch();    
    }
    

function Agregar($modalidad_codigo, $modalidad_descripcion)
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("INSERT INTO modalidad (modalidad_codigo, modalidad_descripcion) VALUES(?,?)");
    $consulta->execute(array($modalidad_codigo, $modalidad_descripcion));
    $consulta = $cnn->prepare("SELECT MAX(modalidad_id) AS nuevo FROM modalidad");
    $consulta->execute();
    $reg = $consulta->fetch();
    return $reg['nuevo'];
    }

function Modificar($modalidad_id, $modalidad_codigo, $modalidad_descripcion)    
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("UPDATE modalidad SET modalidad_codigo = ?, modalidad_descripcion = ? WHERE modalidad_id = ?");
    $consulta->execute(array($modalidad_codigo, $modalidad_descripcion, $modalidad_id));         
    }

function VerificarDependencias($modalidad_id)
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("SELECT COUNT(modalidad_id) AS cantidad FROM ecografia WHERE modalidad_id = ?");
    $consulta->execute(array($modalidad_id));         
    $reg = $consulta->fetch();
    return $reg['cantidad'];
    }

function Eliminar($modalidad_id)
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("DELETE FROM modalidad WHERE modalidad_id = ?");
    $consulta->execute(array($modalidad_id));    
    }
   
   
}

?>
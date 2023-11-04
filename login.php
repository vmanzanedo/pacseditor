<?php 
session_name("pacseditor");
session_start();

//require_once ("../aplicacion/modelo/usuario.php");    
require_once ("./modelo/usuario.php");    
$usuario = new Usuario;

$usuario->Autenticar($_POST['txtuser'],$_POST['txtclave']);

if($_SESSION['autenticado']==1 && $_SESSION['usuario_adminpacs']==1)
    header ("Location: visor.php");
else
   header ("Location: index.php?e=1");

?>
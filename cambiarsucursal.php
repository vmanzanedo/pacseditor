<?php 
include("seguridad.php");

require_once "./modelo/sucursal.php";
$sucursal = new Sucursal();

$regsuc = $sucursal->SelectxKey($_REQUEST['sucursal_key']);

$_SESSION['sucursal_id']=$regsuc['sucursal_id'];
$_SESSION['sucursal_descripcion']=$regsuc['sucursal_descripcion'];
$_SESSION['sucursal_key']=$regsuc['sucursal_key'];
$_SESSION['sucursal_campotelefono']=$regsuc['sucursal_campotelefono'];
$_SESSION['sucursal_formatoimpresion'] =$regsuc['sucursal_formatoimpresion'];
$_SESSION['sucursal_accesopacs']=$regsuc['sucursal_accesopacs'];
$_SESSION['sucursal_accesomiportal']=$regsuc['sucursal_accesomiportal'];



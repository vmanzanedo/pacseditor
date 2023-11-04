<?php
include("seguridad.php");
require_once("./modelo/pacs.php");

$pacs = new Pacs();

$pk = (isset($_REQUEST['pk']))?$_REQUEST['pk']:0;

$cantidad = $pacs->cuentaEstudiosxPatient($pk);
echo $cantidad

?>
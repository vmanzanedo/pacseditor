<?php
include("seguridad.php");
require_once("./modelo/pacs.php");

$pacs = new Pacs();

$paciente_dni = (isset($_REQUEST['paciente_dni']))?$_REQUEST['paciente_dni']:0;

$cantidad = $pacs->cuentaEstudiosxPatient($paciente_dni );
echo $cantidad

?>
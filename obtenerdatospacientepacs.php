<?php
include("seguridad.php");
require_once '../aplicacion/modelo/pacs.php';

$pacs = new Pacs();

$reg = $pacs->SelectxDNI($_REQUEST['paciente_dni']);

$result = array();
$result['paciente_nombre']=$reg['pat_name'];

$arrayan = array_values(explode(" ",$reg['accession_no']));

$result['paciente_an']=$arrayan[0];


echo json_encode($result);
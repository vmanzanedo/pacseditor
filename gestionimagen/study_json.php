<?php
include("../seguridad.php");
require_once("../modelo/pacs.php");
$pacs = new Pacs();

$result = array();
$lista = $pacs->ListaFiltro($_SESSION['sucursal_key'], $_SESSION['estudio_dni'],  strtoupper($_SESSION['estudio_paciente']), $_SESSION['estudio_fechadesde'], $_SESSION['estudio_fechahasta'], $_SESSION['estudio_an'],$_SESSION['estudio_modalidad'],'');

while ($reg=$lista->fetch()){
  $node=array();
  $node['pk']=$reg['pk'];
  $node['study_datos']=utf8_encode($reg['study_datetime']." ".$reg['pat_name']." ".$reg['accession_no']." ".$reg['study_desc']);
  array_push($result, $node);
}

echo json_encode($result);


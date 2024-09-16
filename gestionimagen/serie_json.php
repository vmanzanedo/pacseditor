<?php
include("../seguridad.php");
require_once("../modelo/pacs.php");
$pacs = new Pacs();

$study_pk = $_REQUEST['study_pk'];

$result = array();
$lista = $pacs->ListaSeriexStudy($study_pk);

while ($reg=$lista->fetch()){
  $node=array();
  $node['pk']=$reg['pk'];
  $node['serie_datos']=utf8_encode($reg['series_desc']." ".$reg['modality']." ".$reg['body_part']);
  array_push($result, $node);
}

echo json_encode($result);


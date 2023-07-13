<?php
require_once '../modelo/pacs.php';

$pacs = new Pacs();

if($_REQUEST['op']==0){
    $reg = $pacs->OcultarSerie($series_iuid = $_REQUEST['series_iuid']);
}else{
   //echo "paso";
    $pacs->MostrarSerie($series_iuid = $_REQUEST['series_iuid']);
}

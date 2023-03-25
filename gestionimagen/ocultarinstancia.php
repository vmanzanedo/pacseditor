<?php
require_once '../modelo/pacs.php';

$pacs = new Pacs();

if($_REQUEST['op']==0){
    $reg = $pacs->OcultarInstancia($sop_iuid = $_REQUEST['sop_iuid']);
} else {
    $reg = $pacs->MostrarInstancia($sop_iuid = $_REQUEST['sop_iuid']);
}
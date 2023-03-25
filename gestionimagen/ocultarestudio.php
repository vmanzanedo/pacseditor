<?php
require_once '../modelo/pacs.php';

$pacs = new Pacs();

$reg = $pacs->OcultarEstudio($study_iuid = $_REQUEST['study_iuid']);

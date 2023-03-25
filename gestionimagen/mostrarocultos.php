<?php
require_once '../modelo/pacs.php';

$pacs = new Pacs();

$pacs->MostrarEstudio($study_iuid = $_REQUEST['study_iuid']);

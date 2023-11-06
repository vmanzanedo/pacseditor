<?php
include("seguridad.php");
$_SESSION['estudio_dni'] = $_REQUEST['estudio_dni'];
$_SESSION['estudio_paciente'] = $_REQUEST['estudio_paciente'];
$_SESSION['estudio_fechadesde'] = $_REQUEST['estudio_fechadesde'];
$_SESSION['estudio_fechahasta'] = $_REQUEST['estudio_fechahasta'];
$_SESSION['estudio_modalidad'] = $_REQUEST['estudio_modalidad'];
$_SESSION['estudio_an'] = $_REQUEST['estudio_an'];

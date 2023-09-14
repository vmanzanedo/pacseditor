<?php
include("../seguridad.php");
include("../modelo/conexionpacs.php");
$cnnpacs = new ConexionPacs();

$study_pk = $_REQUEST['study_pk'];

foreach($_SESSION['seriesmover'] as $series_pk) {

  $query = $cnnpacs->prepare("UPDATE series SET study_fk = ? WHERE pk = ?");
  $query->execute(array($study_pk, $series_pk));
  print_r($query->errorInfo());

}


?>
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


// Se actualiza info de objetos DICOM , para poner los del destino

// Datos estudio destino
$query = $cnnpacs->prepare("SELECT pat_id, replace(pat_name,'^',' ') as pat_name, pat_birthdate, pat_sex FROM patient INNER JOIN study ON patient.pk = study.patient_fk WHERE study.pk = ?");
$query->execute(array($study_pk));
$row = $query->fetch();


$query1 = $cnnpacs->prepare("SELECT filepath FROM study 
                                INNER JOIN series ON study.pk = series.study_fk
                                INNER JOIN instance ON series.pk = instance.series_fk
                                INNER JOIN files ON instance.pk = files.instance_fk
                              WHERE study.pk = ?");
$query1->execute(array($study_pk));

while($row1 = $query1->fetch()) {

  exec('../root_shell "'.$row1['filepath'].'" "'.$row['pat_name'].'" "'.$row['pat_id'].'" "'.$row['pat_birthdate'].'" "'.$row['pat_sex'].'" ');    

}


////////////

?>
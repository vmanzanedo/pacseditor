<?php

//Se recorre filepath llamando al script en C que ejecuta el comando dcmodify
// Orden de parametros:
//  1 - filepath
//  2 - pat_name
//  3 - pat_id
//  4 - pat_birthdate
//  5 - pat_sex



include("./modelo/conexionpacs.php");
$cnnpacs = new ConexionPacs();

$cambiarHistorial = ($_REQUEST['historial']==1)?true:false;

if ($cambiarHistorial) {

  $query = $cnnpacs->prepare("SELECT filepath FROM study 
                                INNER JOIN patient ON study.patient_fk = patient.pk 
                                INNER JOIN series ON study.pk = series.study_fk
                                INNER JOIN instance ON series.pk = instance.series_fk
                                INNER JOIN files ON instance.pk = files.instance_fk
                              WHERE pat_id = ?");
  $query->execute(array($_REQUEST['pat_id']));


} else  {

  $query = $cnnpacs->prepare("SELECT filepath FROM study 
                                INNER JOIN series ON study.pk = series.study_fk
                                INNER JOIN instance ON series.pk = instance.series_fk
                                INNER JOIN files ON instance.pk = files.instance_fk
                              WHERE study_iuid = ?");
  $query->execute(array($_REQUEST['study_iuid']));


}

while($row = $query->fetch()) {

  exec('./root_shell "'.$row['filepath'].'" "'.$_REQUEST['pat_name'].'" "'.$_REQUEST['pat_id'].'" "'.$_REQUEST['pat_birthdate'].'" "'.$_REQUEST['pat_sex'].'" ');    

}


//exec('./root_shell "9719342B" "LIONEL ANDRES MESSI" "32928415" "19830420" "M" ');

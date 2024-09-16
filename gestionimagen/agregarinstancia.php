<?php
include("../seguridad.php");

if ($_REQUEST['agregar']=='true')
  array_push($_SESSION['instanciamover'],$_REQUEST['instancia_pk']);
else
  if (($key = array_search($_REQUEST['instancia_pk'], $_SESSION['instanciamover'])) !== false) {
    unset($_SESSION['instanciamover'][$key]);
  }
  
print_r($_SESSION['instanciamover']);  
?>
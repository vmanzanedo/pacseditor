<?php
include("../seguridad.php");

if ($_REQUEST['agregar']=='true')
  array_push($_SESSION['seriesmover'],$_REQUEST['series_pk']);
else
  if (($key = array_search($_REQUEST['series_pk'], $_SESSION['seriesmover'])) !== false) {
    unset($_SESSION['seriesmover'][$key]);
  }
  
print_r($_SESSION['seriesmover']);  
?>
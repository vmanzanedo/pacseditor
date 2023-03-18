<?php 
session_name("pacseditor");
session_start();
session_destroy(); 
header ("Location: index.php");
?>




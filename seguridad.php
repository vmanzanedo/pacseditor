<?php 
session_name("pacseditor");
if(!isset($_SESSION)) session_start();
if ($_SESSION['autenticado'] != 1){
    header("Location: index.php");
}

    

    

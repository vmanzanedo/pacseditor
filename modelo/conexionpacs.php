<?php
//include("../seguridad.php");
class ConexionPacs extends PDO
    {
    private $motor;
    private $host;
    private $database;
    private $user;
    private $pass; 
    private $result;    
 
   // public function __construct()
     public function ConexionPacs()
        {
        $this->motor = 'mysql';
        $this->host = 'localhost';
        $this->database = 'pacsdb';
        $this->user = 'root';
        $this->pass = '100714';

        $dns = $this->motor.':dbname='.$this->database.";host=".$this->host;
        parent::__construct( $dns, $this->user, $this->pass );
    }   
 
    public function Resultado()
        {
         return $this->result;
         }

function ConectarGral()
  {
  try
        {
        $cnn = new PDO('mysql:host=localhost;dbname=pacsdb','root','100714');
        return $cnn;
        }
    catch (Exception $e)
        {
        die('Error: ' .$e->getMessage());
        }  

  }   

}    
?>

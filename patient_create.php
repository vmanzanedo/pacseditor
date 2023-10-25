<?php
error_reporting(E_ALL);
ini_set('display_errors', '1');

require 'HL7-master/src/Exceptions/HL7ConnectionException.php';
require 'HL7-master/src/HL7/Connection.php';
require 'HL7-master/src/HL7/MessageHelpersTrait.php';
require 'HL7-master/src/HL7/Message.php';
require 'HL7-master/src/HL7/Segment.php';
require 'HL7-master/src/HL7/Segments/MSH.php';

include("./modelo/conexionpacs.php");
include("./modelo/pacs.php");


$cnnpacs = new ConexionPacs();
$pacs = new Pacs();


$pat_id = $_REQUEST['pat_id'];
$pat_name = $_REQUEST['pat_name'];
$pat_birthdate = $_REQUEST['pat_birthdate'];
$pat_sex = $_REQUEST['pat_sex'];
$study_iuid = $_REQUEST['study_iuid'];
$pat_id_issuer = $_REQUEST['pat_id_issuer'];

$updated_time = date("Y-m-d H:i:s");
$created_time = date("Y-m-d H:i:s");

$query = $cnnpacs->prepare("INSERT INTO patient(pat_id, pat_id_issuer, pat_name, pat_birthdate, pat_sex, updated_time, created_time) VALUES (?,?,?,?,?,?,?)");
$query->execute(array($pat_id, $pat_id_issuer, $pat_name, $pat_birthdate, $pat_sex, $updated_time, $created_time));

$query = $cnnpacs->prepare("SELECT max(pk) as maxpk FROM patient");
$query->execute();
$row = $query->fetch();
$pk = $row['maxpk'];

$query = $cnnpacs->prepare("UPDATE study SET patient_fk = ? WHERE study_iuid = ?");
$query->execute(array($pk, $study_iuid));



//////////////// Envio de mensaje HL7 /////////////////////

$fechaDeEvento = Date('Ymd'); 
//Almaceno el issuer original
$reg = $pacs->SelectPatientxPk($pk);
$issuer_orig = $reg['pat_id_issuer'];

//Altero issuer para poder hacer la modificacion, usando un numero random
$issuer = rand(1,100);
$pacs->ActualizarIssuer($pk,$issuer);

$message = "
MSH|^~\&|SendingApp|SendingFacility|HL7API|PKB|$fechaDeEvento||ADT^A08|ABC0000000003|P|2.4
PID|||$pat_id^0^0^$issuer||$pat_name||$pat_birthdate|$pat_sex|||||||||||||||||||||||
";

// Lo creo como Message para LOCAL
$msg = new \Aranyasen\HL7\Message($message); // Either \n or \r can be used as segment endings

// Envio el mensaje generado al servidor 
$ip = '127.0.0.1'; //IP LOCAL
$port = 2575;

if (availableUrl($ip, $port, $timeout=5)) {
  $ack = (new Aranyasen\HL7\Connection($ip, $port))->send($msg); // Send a HL7 to remote listener
  $returnString = $ack->toString(true);
  if (strpos($returnString, 'MSH') === false) {
      echo "Failed to send HL7 to 'IP' => $ip, 'Port' => $port";
  } else {
    $msa = $ack->getSegmentsByName('MSA')[0];
    //print_r($msa);
    $error = $msa->getField(3);
    print_r($error);

    //Actualizo issuer con valor original  
    $pacs->ActualizarIssuer($pk, $issuer_orig);

  }
}
else
  echo "Error al conectarse";

  
function availableUrl($host, $port, $timeout) { 
  $fp = fSockOpen($host, $port, $errno, $errstr, $timeout); 
  return $fp!=false;
}





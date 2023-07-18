<?php

error_reporting(E_ALL);
ini_set('display_errors', '1');

include("seguridad.php");
require_once("./modelo/pacs.php");
$pacs = new Pacs();
 
$operacion = (isset($_REQUEST['op']))?$_REQUEST['op']:0;
$pk = (isset($_REQUEST['pk']))?$_REQUEST['pk']:0;
$paciente_nombre = (isset($_REQUEST['paciente_nombre']))?$_REQUEST['paciente_nombre']:"";
$paciente_dni = (isset($_REQUEST['paciente_dni']))?$_REQUEST['paciente_dni']:"";
$paciente_fechanac = (isset($_REQUEST['paciente_fechanac']))?$_REQUEST['paciente_fechanac']:"";
$paciente_sexo = (isset($_REQUEST['paciente_sexo']))?$_REQUEST['paciente_sexo']:""; $paciente_sexo = strtoupper($paciente_sexo);

$paciente_dni_old = (isset($_REQUEST['paciente_dni_old']))?$_REQUEST['paciente_dni_old']:"";
$fechaDeEvento = Date('Ymd'); 

//Actualizacion para corregir ambiguedad de registros que tengan como pat_id el $paciente_dni
//Se actualiza issuer a los DNI que ya existen en la BD, poniendoles un cero
// if ($operacion==2) { //Edicion de DNI
//   $reg = $pacs->SelectPatient($paciente_dni);
//   if (isset($reg['pk'])) {
//     $pacs->ActualizarIssuerxDNI($paciente_dni,0);
//   }

//   //obtengo el issuer mas alto 
//   $reg = $pacs->ObtenerMaxIssuer($paciente_dni_old);
//   $issuer = $reg['maximo']+1; 
//   //actualizo el arreglo con el nuevo $issuer
//   $pacs->ActualizarIssuer($pk,$issuer);

  
// }

//Almaceno el issuer original
$reg = $pacs->SelectPatientxPk($pk);
$issuer_orig = $reg['pat_id_issuer'];

//Altero issuer para poder hacer la modificacion, usando un numero random
$issuer = rand(1,100);
$pacs->ActualizarIssuer($pk,$issuer);


require 'HL7-master/src/Exceptions/HL7ConnectionException.php';
require 'HL7-master/src/HL7/Connection.php';
require 'HL7-master/src/HL7/MessageHelpersTrait.php';
require 'HL7-master/src/HL7/Message.php';
require 'HL7-master/src/HL7/Segment.php';
require 'HL7-master/src/HL7/Segments/MSH.php';

if($operacion == 1){
$message = "
MSH|^~\&|SendingApp|SendingFacility|HL7API|PKB|$fechaDeEvento||ADT^A08|ABC0000000003|P|2.4
PID|||$paciente_dni^0^0^$issuer||$paciente_nombre||$paciente_fechanac|$paciente_sexo|||||||||||||||||||||||
";
}else{
$message = "
MSH|^~\&|SendingApp|SendingFacility|HL7API|PKB|$fechaDeEvento||ADT^A47|ABC0000000003|P|2.4
PID|||$paciente_dni^0^0^$issuer||$paciente_nombre||$paciente_fechanac|$paciente_sexo|||||||||||||||||||||||
MRG|$paciente_dni_old^0^0^$issuer|";
}

echo "Mensaje: ". $message;
/////// Envio de mensaje HL7
/// La posicion 3 del arreglo retornado devuelve el mensaje de error

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
    print_r($msa);
    $error =$msa->getField(3); 

    //Actualizo issuer con valor original  
    $pacs->ActualizarIssuer($pk, $issuer_orig);

    //En nuevo paciente mergeado (si es que hay), actualizo el issuer con valor original
    $reg = $pacs->SelectPatientxPk($pk);
    if (isset($reg['merge_fk'])) {
      $pacs->ActualizarIssuer($reg['merge_fk'], $issuer_orig);
    }
    


  }
}
else
  echo "Error al conectarse";



  
function availableUrl($host, $port, $timeout) { 
  $fp = fSockOpen($host, $port, $errno, $errstr, $timeout); 
  return $fp!=false;
}

?> 

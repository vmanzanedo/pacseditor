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

$issuer = 0;
$fechaDeEvento = Date('Ymd'); 

require 'HL7-master/src/Exceptions/HL7ConnectionException.php';
require 'HL7-master/src/HL7/Connection.php';
require 'HL7-master/src/HL7/MessageHelpersTrait.php';
require 'HL7-master/src/HL7/Message.php';
require 'HL7-master/src/HL7/Segment.php';
require 'HL7-master/src/HL7/Segments/MSH.php';


////// Cambiar informacion del paciente
// Mensaje ADT A08
// A PID Existente se debe mandarle datos nuevos
// En el caso de que arroje mensaje de error por ambiguedad, se deberá previamente cargar un valor en el campo "pat_issuer_id" de la tabla patient, para luego
// referenciar a este valor en el mensaje haciendo uso del campo "$issuer"

// $message = "
// MSH|^~\&|SendingApp|SendingFacility|HL7API|PKB|$fechaDeEvento||ADT^A08|ABC0000000003|P|2.4
// PID|||$paciente_dni^0^0^$issuer||$paciente_nombre||$paciente_fechanac|$paciente_sexo|||||||||||||||||||||||
// ";
/////// Hacer merge a PID (Patient Id)
// Mensaje ADT A47
// A PID Origen (usado en el segmento MRG) proponer PID nuevo (en segmento PID)
// En el caso de que arroje mensaje de error por ambiguedad, se deberá previamente cargar un valor en el campo "pat_issuer_id" de la tabla patient, para luego
// referenciar a este valor en el mensaje haciendo uso del campo "$issuer"

// $message = "
// MSH|^~\&|SendingApp|SendingFacility|HL7API|PKB|$fechaDeEvento||ADT^A47|ABC0000000003|P|2.4
// PID|||$dniNuevo^0^0^$issuer||$apellido^$nombre||$fechaNacimiento|$sexo|||||||||||||||||||||||
// MRG|$dni^0^0^$issuer|
// ";

//Almaceno el issuer original
$reg = $pacs->SelectPatientxPk($pk);
$issuer_orig = $reg['pat_id_issuer'];


if($operacion == 1){
$message = "
MSH|^~\&|SendingApp|SendingFacility|HL7API|PKB|$fechaDeEvento||ADT^A08|ABC0000000003|P|2.4
PID|||$paciente_dni^0^0^||$paciente_nombre||$paciente_fechanac|$paciente_sexo|||||||||||||||||||||||
";
}else{
$message = "
MSH|^~\&|SendingApp|SendingFacility|HL7API|PKB|$fechaDeEvento||ADT^A47|ABC0000000003|P|2.4
PID|||$paciente_dni^0^0^||$paciente_nombre||$paciente_fechanac|$paciente_sexo|||||||||||||||||||||||
MRG|$paciente_dni_old^0^0^|";
}

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
    //print_r($msa);
    $error = $msa->getField(3);
    print_r($error);

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

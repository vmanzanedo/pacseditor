<?php
 include("seguridad.php");
 require_once("./modelo/pacs.php");
 $pacs = new Pacs();
 
$operacion = (isset($_REQUEST['op']))?$_REQUEST['op']:0;
$pk = (isset($_REQUEST['pk']))?$_REQUEST['pk']:0;
$paciente_nombre = (isset($_REQUEST['paciente_nombre']))?$_REQUEST['paciente_nombre']:"";
$paciente_dni = (isset($_REQUEST['paciente_dni']))?$_REQUEST['paciente_dni']:"";
$paciente_dni_original = (isset($_REQUEST['paciente_dni_original']))?$_REQUEST['paciente_dni_original']:"";
$paciente_fechanac = (isset($_REQUEST['paciente_fechanac']))?$_REQUEST['paciente_fechanac']:"";
$paciente_sexo = (isset($_REQUEST['paciente_sexo']))?$_REQUEST['paciente_sexo']:""; $paciente_sexo = strtoupper($paciente_sexo);
$fechaDeEvento = Date('Ymd'); 

//obtengo el issuer mas alto 
$reg = $pacs->ObtenerMaxIssuer($paciente_dni);
$issuer = $reg['maximo']+1; 
//actualizo el arreglo con el nuevo $issuer
$pacs->ActualizarIssuer($pk,$issuer); echo "issuer: $issuer"; 


require '/var/www/html/ecos/aplicacion/pacs/HL7-master/src/Exceptions/HL7ConnectionException.php';
require '/var/www/html/ecos/aplicacion/pacs/HL7-master/src/HL7/Connection.php';
require '/var/www/html/ecos/aplicacion/pacs/HL7-master/src/HL7/MessageHelpersTrait.php';
require '/var/www/html/ecos/aplicacion/pacs/HL7-master/src/HL7/Message.php';
require '/var/www/html/ecos/aplicacion/pacs/HL7-master/src/HL7/Segment.php';
require '/var/www/html/ecos/aplicacion/pacs/HL7-master/src/HL7/Segments/MSH.php';

if($operacion == 1){
  $message = "
  MSH|^~\&|SendingApp|SendingFacility|HL7API|PKB|$fechaDeEvento||ADT^A08|ABC0000000003|P|2.4
  PID|||$paciente_dni^0^0^$issuer||$paciente_nombre||$paciente_fechanac|$paciente_sexo|||||||||||||||||||||||
  ";
}else{
  $message = "
  MSH|^~\&|SendingApp|SendingFacility|HL7API|PKB|$fechaDeEvento||ADT^A47|ABC0000000003|P|2.4
  PID|||$paciente_dni^0^0^$issuer||$paciente_nombre||$paciente_fechanac|$paciente_sexo|||||||||||||||||||||||
  MRG|$paciente_dni_original^0^0^$issuer|";
}

/////// Envio de mensaje HL7
/// La posicion 3 del arreglo retornado devuelve el mensaje de error

// Lo creo como Message
$msg = new \Aranyasen\HL7\Message($message); // Either \n or \r can be used as segment endings

// Envio el mensaje generado al servidor de la worklist
$ip = '10.7.6.211'; //IP Produccion
//$ip = '10.7.6.100'; //IP Testing
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
    // print_r($error);
  }
}
else
  echo "Error al conectarse";

  
function availableUrl($host, $port, $timeout) { 
  $fp = fSockOpen($host, $port, $errno, $errstr, $timeout); 
  return $fp!=false;
}

?> 

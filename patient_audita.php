<?php 
include("seguridad.php");
require_once("./modelo/pacs.php");
$pacs = new Pacs();

$op = (isset($_REQUEST['op']))?$_REQUEST['op']:0;
$pk = (isset($_REQUEST['pk']))?$_REQUEST['pk']:0;
$fechaoparacion = Date('Y-m-d H:i:s');

$paciente_dni_old = (isset($_REQUEST['paciente_dni_old']))?$_REQUEST['paciente_dni_old']:"";
$paciente_nombre_old = (isset($_REQUEST['paciente_nombre_old']))?$_REQUEST['paciente_nombre_old']:"";
$paciente_fechanac_old = (isset($_REQUEST['paciente_fechanac_old']))?$_REQUEST['paciente_fechanac_old']:"";
$paciente_sexo_old = (isset($_REQUEST['paciente_sexo_old']))?$_REQUEST['paciente_sexo_old']:"";

$reg = $pacs->SelectId($pk);

if($op==1) $patient_operacion ='UPDATE'; else $patient_operacion = 'INSERT';
                         //  pk,     merge_fk,          pat_id,        pat_id_issuer,        pat_name,             pat_fn_sx,        pat_gn_sx,         pat_i_name,        pat_p_name,     pat_birthdate,          pat_sex,              pat_custom1,        pat_custom2,        pat_custom3,        updated_time,       created_time,         pat_attrs, auditapatient_fechaoperacion,auditapatient_usuario,auditapatient_operacion
$pacs->patient_AFTER_UPDATE($pk, $reg['merge_fk'],$reg['pat_id'], $reg['pat_id_issuer'],$paciente_nombre_old, $reg['pat_fn_sx'],$reg['pat_gn_sx'],$reg['pat_i_name'],$reg['pat_p_name'],$paciente_fechanac_old, $paciente_sexo_old,$reg['pat_custom1'],$reg['pat_custom2'],$reg['pat_custom3'],$reg['updated_time'],$reg['created_time'],$reg['pat_attrs'],$fechaoparacion,$_SESSION['usuario'],$patient_operacion);

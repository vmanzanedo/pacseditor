<?php
include("seguridad.php");
require_once './modelo/pacs.php';

$pacs = new Pacs();

$practica_an_old = (isset($_REQUEST['practica_an_old']))?$_REQUEST['practica_an_old']:0;
$practica_an = (isset($_REQUEST['practica_an']))?$_REQUEST['practica_an']:0;
$accno_issuer_fk_old = (isset($_REQUEST['accno_issuer_fk_old']))?$_REQUEST['accno_issuer_fk_old']:0;
$accno_issuer_fk = (isset($_REQUEST['accno_issuer_fk']))?$_REQUEST['accno_issuer_fk']:0;
$study_iuid = (isset($_REQUEST['study_iuid']))?$_REQUEST['study_iuid']:"";

$usuario = $_SESSION['usuario'];
$fecha = Date('Y-m-d h:i:s'); 

$pacs->ActualizarAN($study_iuid, $practica_an);
$pacs->ActualizarANIssuer($study_iuid, $accno_issuer_fk);

//AUDITORIA DE STUDY
$reg = $pacs->SelectIdStudy($study_iuid);

$pacs->study_AFTER_UPDATE($reg['pk'],$reg['patient_fk'],$accno_issuer_fk_old,$reg['study_iuid'],$reg['study_id'],$reg['study_datetime'],$practica_an_old,$reg['ref_physician'],$reg['ref_phys_fn_sx'],$reg['ref_phys_gn_sx'],$reg['ref_phys_i_name'],$reg['ref_phys_p_name'],$reg['study_desc'],$reg['study_custom1'],$reg['study_custom2'],$reg['study_custom3'],$reg['study_status_id'],$reg['mods_in_study'],$reg['cuids_in_study'],$reg['num_series'],$reg['num_instances'],$reg['ext_retr_aet'],$reg['retrieve_aets'],$reg['fileset_iuid'],$reg['fileset_id'],$reg['availability'],$reg['study_status'],$reg['checked_time'],$reg['updated_time'],$reg['created_time'],$reg['study_attrs'],$usuario,$fecha,'UPDATE');

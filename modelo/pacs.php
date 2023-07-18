<?php
require_once("/var/www/html/ecos/pacseditor/seguridad.php");
require_once("conexionpacs.php");
require_once("conexion.php");

class Pacs{

function SelectId($pk)
  {
    $cnn = new ConexionPacs();
    $consulta = $cnn->prepare("SELECT * FROM patient WHERE pk = ?");
    $consulta->execute(array($pk));
    return $consulta->fetch();
  }

function ObtenerMaxIssuer($paciente_dni)
  {
    $cnn = new ConexionPacs();
    $consulta = $cnn->prepare("SELECT MAX(CAST(pat_id_issuer as SIGNED)) AS maximo FROM patient WHERE pat_id = ?");
    $consulta->execute(array($paciente_dni));
    return $consulta->fetch();
  }

function ActualizarIssuer($pk,$issuer)
  {
    $cnn = new ConexionPacs();
    $consulta = $cnn->prepare("UPDATE patient SET pat_id_issuer = ? WHERE pk = ?");
    $consulta->execute(array($issuer,$pk));       
  }

function ActualizarIssuerxDNI($pat_id,$issuer)
  {
    $cnn = new ConexionPacs();
    $consulta = $cnn->prepare("UPDATE patient SET pat_id_issuer = ? WHERE pat_id LIKE '%$pat_id%'");
    $consulta->execute(array($issuer));       
  }

function SelectPatient($pat_id)
  {
    $cnn = new ConexionPacs();
    $consulta = $cnn->prepare("SELECT * FROM patient WHERE pat_id = ?");
    $consulta->execute(array($pat_id));
    return $consulta->fetch();
  }  

function SelectPatientxPk($pk)
  {
    $cnn = new ConexionPacs();
    $consulta = $cnn->prepare("SELECT * FROM patient WHERE pk = ?");
    $consulta->execute(array($pk));
    return $consulta->fetch();
  }  
  
function ListaFiltro($sucursal_key, $estudio_dni, $estudio_paciente, $estudio_fechadesde, $estudio_fechahasta, $estudio_an)
    {
    $criterios = "true";
    if ($estudio_dni!='') $criterios .= " AND patient.pat_id = $estudio_dni";
    if ($estudio_paciente != "") {
      $arreglo = explode(" ",$estudio_paciente);
      foreach ($arreglo as $cadena){
        $criterios .= " AND (patient.pat_name LIKE '%$cadena%')";
      }
    }
    if ($estudio_an!='') $criterios .= " AND accession_no LIKE '%$estudio_an%'";
    if ($estudio_fechadesde!='') $criterios .= " AND date(study_datetime) >= '$estudio_fechadesde'";
    if ($estudio_fechahasta!='') $criterios .= " AND date(study_datetime) <= '$estudio_fechahasta'";
    
    if ($criterios == "true") $criterios= "false";
    
    $cnn = new ConexionPacs();
    $consulta = $cnn->prepare("
      SELECT patient.pk as patient_pk, accno_issuer_fk, patient.pat_id, replace(pat_name,'^',' ') as pat_name, pat_birthdate, pat_sex, study_datetime, study_desc, accession_no, study.study_iuid, study.pk, mods_in_study, study.updated_time, oculto.oculto_id
        FROM study 
        INNER JOIN patient ON study.patient_fk = patient.pk
        LEFT JOIN oculto ON study.study_iuid = oculto.study_iuid
      WHERE true AND $criterios 
      ORDER BY study.pk DESC LIMIT 1000");
    $consulta->execute(); 
    return $consulta;
    }

  //-----------------AUDITORIA PATIENT-------------------
  function  patient_AFTER_UPDATE($pk, $merge_fk, $pat_id, $pat_id_issuer,$paciente_nombre_old, $pat_fn_sx, $pat_gn_sx, $pat_i_name, $pat_p_name, $paciente_fechanac_old, $paciente_sexo_old, $pat_custom1, $pat_custom2, $pat_custom3, $updated_time, $created_time, $pat_attrs, $fechaoparacion, $usuario, $patient_operacion)
  {
    $cnn = new ConexionPacs();
    $consulta = $cnn->prepare("INSERT INTO auditapatient(		
                                            pk,
                                            merge_fk,
                                            pat_id,
                                            pat_id_issuer,
                                            pat_name,
                                            pat_fn_sx,
                                            pat_gn_sx,
                                            pat_i_name,
                                            pat_p_name,
                                            pat_birthdate,
                                            pat_sex,
                                            pat_custom1,
                                            pat_custom2,
                                            pat_custom3,
                                            updated_time,
                                            created_time,
                                            pat_attrs,
                                            auditapatient_fechaoperacion,
                                            auditapatient_usuario,
                                            auditapatient_operacion
                                          ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);
                              ");
    $consulta->execute(array($pk, $merge_fk, $pat_id, $pat_id_issuer,$paciente_nombre_old, $pat_fn_sx, $pat_gn_sx, $pat_i_name, $pat_p_name, $paciente_fechanac_old, $paciente_sexo_old, $pat_custom1, $pat_custom2, $pat_custom3, $updated_time, $created_time, $pat_attrs, $fechaoparacion, $usuario, $patient_operacion)); 
    return $consulta;
  }

  //--------- MODIFICAR AN EN TABLA STUDY -----------
  
  function ActualizarAN($study_iuid, $practica_an)
  {
    $cnn = new ConexionPacs();
    $consulta = $cnn->prepare("UPDATE study SET accession_no = ? WHERE study_iuid = ?");
    $consulta->execute(array($practica_an,$study_iuid));       print_r($consulta->errorInfo());
  }

  //--------- AN ISSUER EN TABLA STUDY -----------

  function ListaIssuer()
  {
  $cnn = new ConexionPacs();
  $consulta = $cnn->prepare("SELECT * FROM pacsdb.issuer LEFT JOIN ecos.sucursal ON entity_id = sucursal_key");
  $consulta->execute();
  return $consulta;    
  }
  
  function ActualizarANIssuer($study_iuid, $accno_issuer_fk)
  {
    $cnn = new ConexionPacs();
    $consulta = $cnn->prepare("UPDATE study SET accno_issuer_fk = ? WHERE study_iuid = ?");
    $consulta->execute(array($accno_issuer_fk,$study_iuid));       
  }

  //--------- MODIFICAR STUDY_DESC EN TABLA STUDY -----------
  
  function ActualizarStudydesc($study_iuid, $study_desc)
  {
    $cnn = new ConexionPacs();
    $consulta = $cnn->prepare("UPDATE study SET study_desc = ? WHERE study_iuid = ?");
    $consulta->execute(array($study_desc,$study_iuid));      
  }
  //-----------------AUDITORIA study-------------------
  function  study_AFTER_UPDATE($pk, $patient_fk, $accno_issuer_fk, $study_iuid, $study_id, $study_datetime, $accession_no, $ref_physician, $ref_phys_fn_sx, $ref_phys_gn_sx, $ref_phys_i_name, $ref_phys_p_name, $study_desc, $study_custom1, $study_custom2, $study_custom3, $study_status_id, $mods_in_study, $cuids_in_study, $num_series, $num_instances, $ext_retr_aet, $retrieve_aets, $fileset_iuid, $fileset_id, $availability, $study_status, $checked_time, $updated_time, $created_time, $study_attrs, $auditastudy_usuario, $auditastudy_fecha, $auditastudy_operacion)
  {
    $cnn = new ConexionPacs();
    $consulta = $cnn->prepare("INSERT INTO auditastudy(		
                                            pk,
                                            patient_fk,
                                            accno_issuer_fk,
                                            study_iuid,
                                            study_id,
                                            study_datetime,
                                            accession_no,
                                            ref_physician,
                                            ref_phys_fn_sx,
                                            ref_phys_gn_sx,
                                            ref_phys_i_name,
                                            ref_phys_p_name,
                                            study_desc,
                                            study_custom1,
                                            study_custom2,
                                            study_custom3,
                                            study_status_id,
                                            mods_in_study,
                                            cuids_in_study,
                                            num_series,
                                            num_instances,
                                            ext_retr_aet,
                                            retrieve_aets,
                                            fileset_iuid,
                                            fileset_id,
                                            availability_,
                                            study_status,
                                            checked_time,
                                            updated_time,
                                            created_time,
                                            study_attrs,
                                            auditastudy_usuario,
                                            auditastudy_fecha,
                                            auditastudy_operacion
                                          ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);
                              ");
    $consulta->execute(array($pk, $patient_fk, $accno_issuer_fk, $study_iuid, $study_id, $study_datetime, $accession_no, $ref_physician, $ref_phys_fn_sx, $ref_phys_gn_sx, $ref_phys_i_name, $ref_phys_p_name, $study_desc, $study_custom1, $study_custom2, $study_custom3, $study_status_id, $mods_in_study, $cuids_in_study, $num_series, $num_instances, $ext_retr_aet, $retrieve_aets, $fileset_iuid, $fileset_id, $availability, $study_status, $checked_time, $updated_time, $created_time, $study_attrs, $auditastudy_usuario, $auditastudy_fecha, $auditastudy_operacion)); 
    return $consulta;
  }

  function SelectIdStudy($study_iuid)
  {
    $cnn = new ConexionPacs();
    $consulta = $cnn->prepare("SELECT * FROM study WHERE study_iuid = ?");
    $consulta->execute(array($study_iuid));
    return $consulta->fetch();
  }

  //OBTIENE TODAS LAS SERIES DE UN ESTUDIO
  function ListaSeriexStudy($pk)
  {
    $cnn = new ConexionPacs();
    $consulta = $cnn->prepare("SELECT *, series.series_iuid as seriesiuid FROM series
                                 LEFT JOIN ocultoserie ON ocultoserie.series_iuid = series.series_iuid
                                WHERE study_fk = ? 
                               ORDER BY CAST(series_no AS UNSIGNED)");
    $consulta->execute(array($pk)); 
    return $consulta;
  }
  //OBTIENE LAS INSTANCIAS POR SERIE
  function ListaInstancias($series_pk)
    {
    $cnn = new ConexionPacs();
    $consulta = $cnn->prepare("SELECT *, instance.sop_iuid as sopiuid FROM instance 
                                 LEFT JOIN ocultoinstance ON ocultoinstance.sop_iuid = instance.sop_iuid
                                WHERE series_fk = ? 
                               ORDER BY CAST(inst_no AS UNSIGNED)");
    $consulta->execute(array($series_pk));
    return $consulta;    
    }

  function OcultarEstudio($study_iuid)
    {
    $cnn = new ConexionPacs();
    $fecha = Date("Y-m-d H:i:s");
    $consulta = $cnn->prepare("INSERT INTO oculto (study_iuid, oculto_fecha, oculto_usuario) VALUES (?,?,?);");
    $consulta->execute(array($study_iuid, $fecha, $_SESSION['usuario']));
    print_r($consulta->errorInfo());
    }       

 function MostrarEstudio($study_iuid)
    {
    $cnn = new ConexionPacs();
    $consulta = $cnn->prepare("DELETE FROM oculto WHERE study_iuid = ?");
    $consulta->execute(array($study_iuid));    
    }

  function OcultarSerie($series_iuid)
    {
    $cnn = new ConexionPacs();
    $fecha = Date("Y-m-d H:i:s");
    $consulta = $cnn->prepare("INSERT INTO ocultoserie (series_iuid, ocultoserie_fecha, ocultoserie_usuario) VALUES (?,?,?)");
    $consulta->execute(array($series_iuid, $fecha, $_SESSION['usuario']));
    }  
    
  function OcultarInstancia($sop_iuid)
    {
    $cnn = new ConexionPacs();
    $fecha = Date("Y-m-d H:i:s");
    $consulta = $cnn->prepare("INSERT INTO ocultoinstance (sop_iuid, ocultoinstance_fecha, ocultoinstance_usuario) VALUES (?,?,?)");
    $consulta->execute(array($sop_iuid, $fecha, $_SESSION['usuario']));
    }  

  function MostrarSerie($series_iuid)
    {
    $cnn = new ConexionPacs();
    $consulta = $cnn->prepare("DELETE FROM ocultoserie WHERE series_iuid = ?");
    $consulta->execute(array($series_iuid)); 
    } 
    
  function MostrarInstancia($sop_iuid)
    {
    $cnn = new ConexionPacs();
    $consulta = $cnn->prepare("DELETE FROM ocultoinstance WHERE sop_iuid = ?");
    $consulta->execute(array($sop_iuid));
    }   
  

}

?>
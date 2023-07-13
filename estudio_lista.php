<?php 
include("seguridad.php");
require_once('./modelo/usuario.php');
require_once("./modelo/pacs.php");

$usuario = new Usuario;
$pacs = new Pacs();

$lista = $pacs->ListaFiltro($_SESSION['sucursal_key'], $_SESSION['estudio_dni'],  strtoupper($_SESSION['estudio_paciente']), $_SESSION['estudio_fechadesde'], $_SESSION['estudio_fechahasta'], $_SESSION['estudio_an'])

?>

<table id="listaestudio" class="table table-dark table-striped table-hover">
    <thead>
        <tr>
          <th>DNI</th>
          <th>Paciente</th>
          <th>Fecha Nac</th>
          <th>Sexo</th>
          <th>A.N.</th>
          <th>Estudio</th>
          <th>Fecha Estudio</th>
          <th>Telefono</th>
          <th>Modalidad</th>
	  <th>Imágenes</th>
          <th style="text-align:center"><i class="fa fa-edit"></i></th>
          <th>Series</th>
          <th></th>
        </tr>
    </thead>
    <tbody>
    <?php
    while($reg = $lista->fetch())
      {
        $dir= __DIR__."/img/".$_SESSION['sucursal_key']."/".$reg['study_iuid']; 
        $cantinformes = 0;
        if (file_exists($dir) && iterator_count(new FilesystemIterator($dir, FilesystemIterator::SKIP_DOTS))>0) {
          $cantinformes = iterator_count(new FilesystemIterator($dir, FilesystemIterator::SKIP_DOTS));
          $backcolor='#bae29e';
        } else {
          $backcolor='#FFFFFF';
        }
      ?>
      
      <tr>
        <td><?php echo utf8_encode($reg['pat_id']) ?></td>
        <td><?php echo utf8_encode($reg['pat_name']) ?></td>
        <td><?php echo utf8_encode($reg['pat_birthdate']) ?></td>
        <td><?php echo utf8_encode($reg['pat_sex']) ?></td>
        <td><?php echo utf8_encode($reg['accession_no']) ?></td>
        <td><?php echo utf8_encode($reg['study_desc']) ?></td>
        <td><?php echo (new DateTime($reg['study_datetime']))->format("Y-m-d"); ?></td>
        <td><?php echo utf8_encode($reg['telefono']) ?></td>
        <td><?php echo utf8_encode($reg['mods_in_study']) ?></td>
	<td>
          <button type="button" class="btn btn-primary btn-block" onclick="window.open('view.php?studyuid=<?php echo $reg['study_iuid'] ?>')"><i class="fa fa-eye"></i> Ver</button>          
        </td>
        <td>
          <button type="button" class="btn btn-success btn-sm " data-pk="<?php echo $reg['patient_pk'] ?>" data-paciente_nombre="<?php echo $reg['pat_name'] ?>" data-paciente_dni="<?php echo $reg['pat_id'] ?>"  data-fecha_nacimiento="<?php echo $reg['pat_birthdate'] ?>" data-paciente_sexo="<?php echo $reg['pat_sex'] ?>" data-toggle="modal" data-entidad="pacseditor" data-target="#modal" data-op="1" title="Paciente"><i class="fa fa-user" aria-hidden="true"></i></button>          
          <button type="button" class="btn btn-success btn-sm" data-pk="<?php echo $reg['patient_pk'] ?>" data-paciente_nombre="<?php echo $reg['pat_name'] ?>" data-paciente_dni="<?php echo $reg['pat_id'] ?>"  data-fecha_nacimiento="<?php echo $reg['pat_birthdate'] ?>" data-paciente_sexo="<?php echo $reg['pat_sex'] ?>" data-toggle="modal" data-entidad="pacseditor" data-target="#modal" data-op="2" title="DNI"><i class="fa fa-address-card" aria-hidden="true"></i></button>          
          <button type="button" class="btn btn-success btn-sm" data-studyuid="<?php echo $reg['study_iuid'] ?>" data-practica_an="<?php echo $reg['accession_no']?>" data-accno_issuer_fk="<?php echo $reg['accno_issuer_fk']?>" data-toggle="modal" data-entidad="pacseditor_an" data-target="#modal" data-op="1" title="A.N."><i class="fa fa-list-ol" aria-hidden="true"></i></i></button>          
          <button type="button" class="btn btn-success btn-sm" data-studyuid="<?php echo $reg['study_iuid'] ?>" data-study_desc="<?php echo $reg['study_desc']?>" data-toggle="modal" data-entidad="pacseditor_studydesc" data-target="#modal" data-op="1" title="Study_desc"><i class="fa fa-list-alt" aria-hidden="true"></i></button>          
        </td>
        <td>
          <button type="button" class="btn btn-success btn-sm "  data-pk="<?php echo $reg['pk'] ?>" data-studyuid="<?php echo $reg['study_iuid'] ?>" data-toggle="modal" data-entidad="gestorimagen" data-target="#modal" data-op="1" title="Series"><i class="fa fa-folder-open" aria-hidden="true"></i></button>          
        </td>
        <td>
          <?php if($reg['oculto_id']!=null) { ?>
                <button type="button" class="btn btn-primary btn-block" onClick="mostrarEstudio('<?php echo $reg['study_iuid'] ?>')"><i class="fa fa-eye" aria-hidden="true"></i> Mostrar</button>          
          <?php } else { ?>
                <button type="button" class="btn btn-primary btn-block" onClick="ocultarEstudio('<?php echo $reg['study_iuid'] ?>')"><i class="fa fa-eye-slash" aria-hidden="true"></i> Ocultar</button>
          <?php } ?>
        </td>
      </tr>
      <?php }?>
    </tbody>
</table>


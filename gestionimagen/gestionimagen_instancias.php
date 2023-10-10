<?php 
require_once("../modelo/pacs.php");
$pacss = new Pacs();

$study_iuid = $_REQUEST['study_iuid'];
$series_iuid = $_REQUEST['series_iuid']; 

$listainstancias = $pacss->ListaInstancias($_REQUEST['series_pk']);
      while ($reginstancias = $listainstancias->fetch()) {
      
      ?>
         <?php if($reginstancias['ocultoinstance_id']==null){ //No esta oculta ?>
                 <li class="list-group-item"><a  href="#"><?php echo $reginstancias['inst_no'] ?><button class="btn btn-success btn-sm" onclick="verInstancia('<?php echo $study_iuid ?>','<?php echo $series_iuid ?>','<?php echo $reginstancias['sopiuid'] ?>')"><i class="fa fa-file-image" title="Ver Imagen"></i></button></a>&nbsp;&nbsp;<button class="btn btn-success btn-sm" onclick="ocultarInstancia('<?php echo $reginstancias['sopiuid'] ?>')"><i class="fa fa-thumbs-down" title="Ocultar Instancia"></i></button>&nbsp;&nbsp;<?php if($_SESSION['usuario_eliminaestudio']==1){ ?><button class="btn btn-danger btn-sm" onclick="eliminarInstancia('<?php echo $reginstancias['sopiuid'] ?>')"><i class="fa fa-trash" title="Eliminar Instancia"></i></button><?php } ?></li>
         <?php } else {// Se encuentra oculta ?>
                 <li class="list-group-item"><a  href="#"><?php echo $reginstancias['inst_no'] ?><button class="btn btn-success btn-sm" onclick="verInstancia('<?php echo $study_iuid ?>','<?php echo $series_iuid ?>','<?php echo $reginstancias['sopiuid'] ?>')"><i class="fa fa-file-image" title="Ver Imagen"></i></button></a>&nbsp;&nbsp;<button class="btn btn-default btn-sm" onclick="mostrarInstancia('<?php echo $reginstancias['sopiuid'] ?>')"><i class="fa fa-thumbs-up" title="Restablecer Instancia"></i></button>&nbsp;&nbsp;<?php if($_SESSION['usuario_eliminaestudio']==1){ ?><button class="btn btn-danger btn-sm" onclick="eliminarInstancia('<?php echo $reginstancias['sopiuid'] ?>')"><i class="fa fa-trash" title="Eliminar Instancia"></i></button><?php } ?></li>
         <?php } ?>
<?php } ?>
<script>

    function verInstancia(study_iuid,series_iuid,sop_iuid){
        $.ajax ({
          type: "POST",
          url: "gestionimagen/gestionimagen_descarga.php",
          data: "study_iuid="+study_iuid+"&series_iuid="+series_iuid+"&sop_iuid="+sop_iuid,
          success: function(html){
            // location.href="../pacseditor/jpgimages/"+study_iuid+series_iuid+sop_iuid+".jpg";
            window.open("../pacseditor/jpgimages/"+study_iuid+series_iuid+sop_iuid+".jpg", "_blank");
          }    	
        });    
    }
</script>
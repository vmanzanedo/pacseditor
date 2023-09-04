<?php 
include("../seguridad.php");
require_once("../modelo/pacs.php");
 
$pacs = new Pacs();

$study_iuid = $_REQUEST['study_iuid'];
$listaseries = $pacs->ListaSeriexStudy($_REQUEST['pk']);

?>
<table id="listaserie" class="table table-dark table-striped table-hover">
    <thead>
        <tr>
          <th>Body_Part</th>
          <th>Serie_Desc</th>
          <th></th>
          <th style="text-align:right"></th>
          <th style="text-align:right"></th>
        </tr>
    </thead>
    <tbody>
    <?php
    while($regseries = $listaseries->fetch()){ ?>
      <tr <?php if($regseries['ocultoserie_id']!=null){ echo "style=background-color:#8598aa"; }?>>
        <td><?php echo utf8_encode($regseries['body_part']) ?></td>
        <td><?php echo utf8_encode($regseries['series_desc']) ?></td>
        <td>
          <?php if($regseries['ocultoserie_id']==null){?> 
            <div class="btn-group dropright">
                <a class="btn btn-secondary btn-sm dropdown-toggle" onclick="verInstancias('<?php echo $regseries['pk'] ?>','<?php echo $regseries['seriesiuid'] ?>','<?php echo $study_iuid ?>')" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <!-- <a class="btn btn-secondary btn-sm dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> -->
                    Instancias
                </a>
                 
                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink" >
                  <ul class="list-group list-group-flush" id="div_listainstancias-<?php echo $regseries['pk'] ?>" style="overflow: scroll;height: 20em;">
                  </ul>
                </div>
            </div>
          <?php } ?>
        </td>
        <td style="text-align:right">
        <?php if($regseries['ocultoserie_id']!=null){ //si esta oculta ?>
            <button class="btn btn-default btn-sm" onclick="mostrarSerie('<?php echo $regseries['seriesiuid'] ?>')"> Mostrar Serie</button>          
        <?php }else{  ?>
            <button class="btn btn-success btn-sm" onclick="ocultarSerie('<?php echo $regseries['seriesiuid'] ?>')"> Ocultar Serie</button>          
            <?php } ?>
        </td>
        <td style="text-align:right">
            <button class="btn btn-danger btn-sm" onclick="eliminarSerie('<?php echo $regseries['seriesiuid'] ?>')"> Eliminar Serie</button>
        </td>
      </tr>
      <?php } ?>
    </tbody>
</table>
<script>
  function verInstancias(series_pk,series_iuid,study_iuid){
    $.ajax ({
          type: "POST",
          url: "gestionimagen/gestionimagen_instancias.php",
          data: "series_pk="+series_pk+"&series_iuid="+series_iuid+"&study_iuid="+study_iuid, 
          success: function(html){
            $("#div_listainstancias-"+series_pk).html(html);
          }
    });

  }
</script>

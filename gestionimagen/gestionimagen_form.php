<?php 
include("../seguridad.php");
require_once("../modelo/pacs.php");
 
$_SESSION['seriesmover'] = array();
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
          <th style="text-align:right">Mover</th>
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
        <td style="text-align:right">
            <input type="checkbox" id="serie<?php echo $regseries['series_pk'] ?>" onclick="agregarSerie(<?php echo $regseries['pk'] ?>, $(this).prop('checked'));">
        </td>  

      </tr>
      <?php } ?>
    </tbody>
</table>

<button class="btn btn-success pull-right" style="float:right" onclick="if ($('#div_estudios').is(':visible')) $('#div_estudios').hide(); else  $('#div_estudios').show();">Mover Series</button>
<br>
<br>

<div id="div_estudios" style="display:none">
  <label class="col-sm-2 control-label">Estudio Destino</label>
  <input type="text"  class="form-control input-sm" id="study_pk" placeholder="Escribir el estudio a Buscar"/>
  <br>
  <button class="btn btn-success" onclick="moverSeries($('#study_pk').val())">Confirmar</button>        
</div>


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


  function agregarSerie(series_pk, agregar){
    $.ajax ({
      type: "POST",
      url: "gestionimagen/agregarserie.php",
      data: "series_pk="+series_pk+"&agregar="+agregar, 
      success: function(html){ 
      }    	
    });
  
  }  


  $('#study_pk').flexdatalist({
    minLength: 1,
    valueProperty: 'pk',
    searchIn: 'study_datos',
    data: 'gestionimagen/study_json.php',
    searchByWord: true,
    cache: false,
    noResultsText: 'No se encontraron resultados para "{keyword}"'
  });

  $('#study_ok').on('select:flexdatalist', function(event, set, options) {
      
  });   

  function moverSeries(study_pk){
    Swal.fire({
      title: 'Está seguro que desea Mover las Series?',
      text: "La acción no podrá deshacerse.",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor:'#3085d6',
      cancelButtonColor:  '#3085d6',
      confirmButtonText: 'Si, Moverlas!'
    }).then((result) => {
      if (result.isConfirmed) {
        $.ajax ({
          type: "POST",
          url: "./gestionimagen/moverseries.php",
          data: "study_pk="+study_pk,
          success: function(html){
            $('#modal').modal('hide');
            cargarTablaEstudio();
          }    	
        });    
        Swal.fire(
          'Series movidas!',
          'Las series se movieron al nuevo estudio.',
          'success'
        )
      }
    })

    
  
  }    

</script>

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
            <button class="btn btn-success btn-sm" id="btn_ocultarserie<?php echo $regseries['pk'] ?>" onclick="ocultarSerie('<?php echo $regseries['seriesiuid'] ?>','<?php echo $regseries['pk'] ?>')"> Ocultar Serie</button>          
            <?php } ?>
        </td>
        <td style="text-align:right">
            <?php if($_SESSION['usuario_eliminaestudio']==1) { ?>
              <button class="btn btn-danger btn-sm" id="btn_eliminarserie<?php echo $regseries['pk'] ?>" onclick="eliminarSerie('<?php echo $regseries['seriesiuid'] ?>','<?php echo $regseries['pk'] ?>')"> Eliminar Serie</button>
            <?php } ?>
        </td>
        <td style="text-align:right">
            <input type="checkbox" id="serie<?php echo $regseries['series_pk'] ?>" onclick="agregarSerie(<?php echo $regseries['pk'] ?>, $(this).prop('checked'));">
        </td>  

      </tr>
      <?php } ?>
    </tbody>
</table>

<button class="btn btn-success pull-right" style="float:right" onclick="if ($('#div_estudios').is(':visible')) $('#div_estudios').hide(); else  $('#div_estudios').show();">Mover Series</button>
<button class="btn btn-success pull-right" style="float:right; margin-right: 5px" onclick="if ($('#div_estudios_combo').is(':visible')) {$('#div_estudios_combo').hide();$('#div_instancias_seleccionadas').hide();} else { $('#div_estudios_combo').show();$('#div_instancias_seleccionadas').show();}">Mover Instancias</button>&nbsp;&nbsp;
<br>
<br>

<div id="div_estudios" style="display:none">
  <label class="col-sm-2 control-label">Estudio Destino</label>
  <input type="text"  class="form-control input-sm" id="study_pk" placeholder="Escribir el estudio a Buscar"/>
  <br>
  <button class="btn btn-success" onclick="moverSeries($('#study_pk').val())">Confirmar</button>
</div>

<div id="div_instancias_seleccionadas" style="display:none">
  <label class="col-sm-3 control-label">Instancias a Mover</label>
  <select name="instancias_mover" id="instancias_mover" >  
  <?php $lista = $pacs->ListaTodasInstancias(); 
        while ($reg = $lista->fetch()) { 
          if ((in_array($reg['pk'], $_SESSION['instanciamover']))){?>
          <option disabled value="<?php echo $reg['pk'] ?>"><?php if ((in_array($reg['pk'], $_SESSION['instanciamover']))) echo "Serie: ".$reg['series_fk']."- Nro: ".$reg['inst_no'] ?></option>
          
  <?php } }?>          
  </select>
</div>

<div id="div_estudios_combo" style="display:none">
  <label class="col-sm-2 control-label">Estudios </label>
  <input type="text"  class="form-control input-sm" id="study2_pk" placeholder="Escribir el estudio a Buscar" />
  <br>
</div>

<div id="div_series_combo" style="dsiplay:none">
</div>

<script>


  function verSeries(study_pk){
    $.ajax ({
          type: "POST",
          url: "gestionimagen/seriesxstudy_combo.php",
          data: "study_pk="+study_pk, 
          success: function(html){
            $("#div_series_combo").html(html);
          }
    });
  }

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


  function agregarSerie(series_pk, agregar){ //agrega la serie que sera movida a un arreglo
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

  $('#study2_pk').flexdatalist({
    minLength: 1,
    valueProperty: 'pk',
    searchIn: 'study_datos',
    data: 'gestionimagen/study_json.php',
    searchByWord: true,
    cache: false,
    noResultsText: 'No se encontraron resultados para "{keyword}"'
  });

  $('#study2_pk').on('select:flexdatalist', function(event, set, options) {
    verSeries($('#study2_pk').val());
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

  function moverInstancias(study_pk, serie_fk){
    Swal.fire({
      title: 'Está seguro que desea Mover las Instancias?',
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
          url: "./gestionimagen/moverinstancias.php",
          data: "study_pk="+study_pk+"&serie_fk="+serie_fk,
          success: function(html){
            // $('#modal').modal('hide');
            // cargarTablaEstudio();
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

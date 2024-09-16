<?php 
require_once("../modelo/pacs.php");
$pacs = new Pacs();

$study_pk = (isset($_REQUEST['study_pk']))?$_REQUEST['study_pk']:0;

$listaseries = $pacs->ListaSeriexStudy($study_pk);
?>
<label class="col-sm-2 control-label">Series </label>
<input type="text"  class="form-control input-sm" id="serie_fk" placeholder="Escribir la serie a Buscar"/>

<script>
  $('#serie_fk').flexdatalist({
       minLength: 1,
       valueProperty: 'pk',
       searchIn: 'serie_datos',
       data: "gestionimagen/serie_json.php?study_pk=<?php echo $study_pk ?>",
       cache: false,
       noResultsText: 'No se encontraron resultados para "{keyword}"',
       searchByWord: true
  });
  
  $('#serie_fk').on('select:flexdatalist', function(event, set, options) {
      moverInstancias(<?php echo $study_pk ?>, $('#serie_fk').val());
  });  

</script>
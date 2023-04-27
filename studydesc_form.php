<?php
$study_iuid = (isset($_REQUEST['study_iuid']))?$_REQUEST['study_iuid']:0;
$study_desc = (isset($_REQUEST['study_desc']))?$_REQUEST['study_desc']:0;

?>
<form id="form_pacs_studydesc">
    <input type="hidden" id="practica_studydesc_old" value="<?php echo $study_desc ?>">
    
    <div id="div_pacs_study_desc" class="form-group">
      <label for="text" >Study_desc </label>
      <input type="text" name="study_desc" id="study_desc" value="<?php if(isset($study_desc)) echo $study_desc ?>" placeholder="Ingrese descripcion del estudio"  class="form-control" required>
    </div>

    <div id="div_pacs_mensaje" class="form-group has-error">
        <span id="error_pacs_mensaje" class="help-block"></span>
    </div>

    <div class="form-group box-footer">
        <label for="confirmar" class="control-label"> &nbsp;</label><br>
        <button type="button"  class="btn btn-default pull-left" data-dismiss="modal">Cerrar</button>
        <button id='confirmar' type='button' class='btn btn-primary pull-right' data-dismiss="modal" onclick="modificarStudydesc('<?php echo $study_iuid ?>')">Confirmar</button>      
    </div>
</form>   
<script>
    function modificarStudydesc(study_iuid) 
    {
        $("#confirmar").prop('disabled', true);
        $.ajax({
            type: "POST",
            url: "../pacseditor/studydesc_abm.php",
            data: "practica_studydesc_old=" + $("#practica_studydesc_old").val() + "&study_desc=" + $("#study_desc").val() + "&study_iuid=" + study_iuid,
            success: function (html) {
                Swal.fire({
                        icon: 'success',
                        title: 'La descripción del estudio se modificó correctamente.',
                        showConfirmButton: false,
                        timer: 1500
                        });
                $('#modal').modal('hide');
                cargarTablaEstudio();
            }
        });
    }
</script>
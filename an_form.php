<?php
include("./modelo/pacs.php");
$pacs = new Pacs();

$study_iuid = (isset($_REQUEST['study_iuid']))?$_REQUEST['study_iuid']:0;
$practica_an = (isset($_REQUEST['practica_an']))?$_REQUEST['practica_an']:0;
$accno_issuer_fk = (isset($_REQUEST['accno_issuer_fk']))?$_REQUEST['accno_issuer_fk']:0;

?>
<form id="form_pacs_an">
    <input type="hidden" id="practica_an_old" value="<?php echo $practica_an ?>">
    <input type="hidden" id="accno_issuer_fk_old" value="<?php echo $accno_issuer_fk ?>">
    
    <div id="div_pacs_an" class="form-group">
      <label for="number" id="practica-an">A. N. </label>
      <input type="number" name="number" id="practica_accession" min="1" pattern="^[1-9]+" value="<?php if(isset($practica_an)) echo $practica_an ?>" placeholder="Ingrese A.N."  class="form-control" required>
    </div>

    <div id="div_accno_issuer_fk" class="form-group">
      <label for="number" id="practica-an">A. N. Issuer </label>
      <select class="form-control" id="accno_issuer_fk">
        <?php 
        $listaissuer = $pacs->ListaIssuer(); 
        while ($regissuer = $listaissuer->fetch()) { ?>
            <option value="<?php echo $regissuer['pk'] ?>" <?php if ($accno_issuer_fk==$regissuer['pk']) echo " selected"; ?>><?php echo $regissuer['sucursal_descripcion'] ?></option>
        <?php }?>
      </select>
    </div>

    <div id="div_pacs_mensaje" class="form-group has-error">
        <span id="error_pacs_mensaje" class="help-block"></span>
    </div>

    <div class="form-group box-footer">
        <label for="confirmar" class="control-label"> &nbsp;</label><br>
        <button type="button"  class="btn btn-default pull-left" data-dismiss="modal">Cerrar</button>
        <button id='confirmar' type='button' class='btn btn-primary pull-right' data-dismiss="modal" onclick="modificarAN('<?php echo $study_iuid ?>')">Confirmar</button>      
    </div>
</form>   
<script>
    function modificarAN(study_iuid) 
    {
        $("#confirmar").prop('disabled', true);
        $.ajax({
            type: "POST",
            url: "../pacseditor/an_abm.php",
            data: "practica_an_old=" + $("#practica_an_old").val() + "&practica_an=" + $("#practica_accession").val() + "&accno_issuer_fk_old=" + $("#accno_issuer_fk_old").val() + "&accno_issuer_fk=" + $('#accno_issuer_fk').val() + "&study_iuid=" + study_iuid,
            success: function (html) {
                Swal.fire({
                        icon: 'success',
                        title: 'Accession_no se modificó correctamente.',
                        showConfirmButton: false,
                        timer: 1500
                        });
                cargarTablaEstudio();
                $('#modal').modal('hide');
            }
        });
    }
</script>
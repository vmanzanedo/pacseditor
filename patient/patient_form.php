<?php
$paciente_nombre = (isset($_REQUEST['paciente_nombre']))?$_REQUEST['paciente_nombre']:0;
$paciente_dni = (isset($_REQUEST['paciente_dni']))?$_REQUEST['paciente_dni']:0;
$fecha_nacimiento = (isset($_REQUEST['fecha_nacimiento']))?$_REQUEST['fecha_nacimiento']:0;
$paciente_sexo = (isset($_REQUEST['paciente_sexo']))?$_REQUEST['paciente_sexo']:0;
$pk = (isset($_REQUEST['pk']))?$_REQUEST['pk']:0;
$op = (isset($_REQUEST['op']))?$_REQUEST['op']:0;

$disabled = ($op==2)?"disabled":"";
?>
<form id="form_pacs">
    <input type="hidden" id="operacion" value="<?php echo $op ?>" />
    <input type="hidden" id="paciente_dni_original" value="<?php echo $paciente_dni ?>">
    <input type="hidden" id="pk" value="<?php echo $pk ?>">

    <div id="div_pacs_nombre" class="form-group">
        <label for="pacs_nombre" class="control-label">Apellido Nombre </label>
        <input type="text" class=form_control" id="paciente_nombre" value="<?php echo $paciente_nombre ?>" required>
    </div>

    <div id="div_pacs_dni" class="form-group">
        <label for="pacs_dni" class="control-label">DNI </label>
        <input type="text" class=form_control" id="paciente_dni" maxlength="8" pattern="[0-9]*" value="<?php echo $paciente_dni ?>" required <?php if ($op==1) echo "disabled";?>>
    </div>
    
    <div id="div_pacs_fechanac" class="form-group">
        <label for="pacs_fechanac" class="control-label">Fecha Nacimiento </label>
        <input type="text" class=form_control" id="paciente_fechanac" maxlength="8" pattern="[0-9]*" value="<?php echo $fecha_nacimiento ?>" required>
    </div>

    <div id="div_pacs_sexo" class="form-group">
        <label for="pacs_sexo" class="control-label">Sexo </label>
        <input type="text" class=form_control" id="paciente_sexo" maxlength="1" pattern="[F|M]" value="<?php echo $paciente_sexo ?>" required>
    </div>

    <div id="div_pacs_mensaje" class="form-group has-error">
        <span id="error_pacs_mensaje" class="help-block"></span>
    </div>

    <div class="form-group box-footer">
        <label for="confirmar" class="control-label"> &nbsp;</label><br>
        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Cerrar</button>
        <button id='confirmar' type='button' class='btn btn-primary pull-right' data-dismiss="modal" onclick="modificarPatient()">Confirmar</button>
    </div>
</form>

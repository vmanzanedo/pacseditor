<?php
$paciente_nombre = (isset($_REQUEST['paciente_nombre']))?$_REQUEST['paciente_nombre']:0;
$paciente_dni = (isset($_REQUEST['paciente_dni']))?$_REQUEST['paciente_dni']:0;
$fecha_nacimiento = (isset($_REQUEST['fecha_nacimiento']))?$_REQUEST['fecha_nacimiento']:0;
$paciente_sexo = (isset($_REQUEST['paciente_sexo']))?$_REQUEST['paciente_sexo']:0;
$pk = (isset($_REQUEST['pk']))?$_REQUEST['pk']:0;
$op = (isset($_REQUEST['op']))?$_REQUEST['op']:0;

echo "Patient PK: ".$pk;
?>
<form id="form_pacs">
    <input type="hidden" id="operacion" value="<?php echo $op ?>" />
    <input type="hidden" id="paciente_dni_old" value="<?php echo $paciente_dni ?>">
    <input type="hidden" id="paciente_nombre_old" value="<?php echo $paciente_nombre ?>">
    <input type="hidden" id="paciente_fechanac_old" value="<?php echo $paciente_fechanac ?>">
    <input type="hidden" id="paciente_sexo_old" value="<?php echo $paciente_sexo ?>">
    <input type="hidden" id="pk" value="<?php echo $pk ?>">
    
    <div id="div_pacs_nombre" class="form-group">
      <label for="pacs_nombre">Apellido Nombre </label>
      <input type="text" id="paciente_nombre" name="paciente_nombre" value="<?php if(isset($paciente_nombre)) echo $paciente_nombre ?>" placeholder="Ingrese Apellido y Nombre" <?php if($op==2) echo 'class="form-control-plaintext" style="color:#BDBEC0" readonly';else echo 'class="form-control"'; ?> required>
    </div>

    <div id="div_pacs_dni" class="form-group">
      <label for="pacs_dni">DNI</label>
      <input type="text"  id="paciente_dni" name="paciente_dni"  maxlength="8" pattern="[0-9]*" value="<?php if(isset($paciente_dni)) echo $paciente_dni;  ?>" placeholder="Ingrese Dni" <?php if($op==1) echo 'class="form-control-plaintext" style="color:#BDBEC0" readonly';else echo 'class="form-control"'; ?> required>
    </div>

    <div id="div_pacs_fechanac" class="form-group">
      <label for="pacs_fechanac">Fecha Nacimiento</label>
      <input type="text" id="paciente_fechanac" name="paciente_fechanac"  maxlength="8" pattern="[0-9]*" value="<?php if(isset($fecha_nacimiento)) echo $fecha_nacimiento;  ?>" <?php if($op==1) echo "placeholder=Ingrese fecha nacimiento. Formato aaaammdd"; ?> <?php if($op==2) echo 'class="form-control-plaintext" style="color:#BDBEC0" readonly';else echo 'class="form-control"'; ?>>
    </div>

    <div id="div_pacs_sexo" class="form-group">
      <label for="pacs_sexo">Sexo</label>
      <input type="text" id="paciente_sexo" name="paciente_sexo" maxlength="1" pattern="[F|M]" value="<?php if(isset($paciente_sexo)) echo $paciente_sexo ?>" placeholder="Ingrese Sexo" <?php if($op==2) echo 'class="form-control-plaintext" style="color:#BDBEC0" readonly';else echo 'class="form-control"'; ?>>
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


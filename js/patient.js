
function controlHistorial()
  {
    $.ajax ({
      type: "POST",
      url: "../pacseditor/controlhistorial.php",
      data: "paciente_dni="+$("#paciente_dni_old").val(), 
      success: function(html){
          if(html>1){
            Swal.fire({
              title: 'El paciente posee historial de estudios. \n ¿Desea modificar los datos para el estudio Actual, o para todo el Historial?',
              showDenyButton: true,
              showCancelButton: true,
              confirmButtonText: 'Modificar Historial',
              denyButtonText: `Modificar Actual`,
            }).then((result) => {
              if (result.isConfirmed) {
                modificarPatient();
                Swal.fire('El Historial fue Modificado!', '', 'success')
              } else if (result.isDenied) {
                crearPatient();
                Swal.fire('El Estudio Actual fue Modificado', '', 'success')
              }
            })
          }else{
            modificarPatient();
          }
        }
      });
  }

function modificarPatient()
    {
        $.ajax ({
            type: "POST",
            url: "../pacseditor/patient_abm.php",
            data: "op="+$("#operacion").val()+"&pk="+$("#pk").val()+"&paciente_nombre="+$("#paciente_nombre").val()+"&paciente_dni="+$("#paciente_dni").val()+"&paciente_dni_old="+$("#paciente_dni_old").val()+"&paciente_fechanac="+$("#paciente_fechanac").val()+"&paciente_sexo="+$("#paciente_sexo").val(), 
            success: function(html){
              if (html.includes('ambiguous')||html.includes('exists')||html.includes('merged')) { 
                  $.ajax ({
                      type: "POST",
                      url: "../pacseditor/patient_abm_new_issuer.php",
                      data: "op="+$("#operacion").val()+"&pk="+$("#pk").val()+"&paciente_nombre="+$("#paciente_nombre").val()+"&paciente_dni="+$("#paciente_dni").val()+"&paciente_dni_old="+$("#paciente_dni_old").val()+"&paciente_fechanac="+$("#paciente_fechanac").val()+"&paciente_sexo="+$("#paciente_sexo").val(), 
                      success: function(html1){
                      }
                  });
              } else {
                if (html.trim()!='') alert(html);
              }
              $.ajax ({
                    type: "POST",
                    url: "../pacseditor/patient_audita.php",
                    data: "op="+$("#operacion").val()+"&pk="+$("#pk").val()+"&paciente_dni_old="+$("#paciente_dni_old").val()+"&paciente_nombre_old="+$("#paciente_nombre_old").val()+"&paciente_sexo_old="+$("#paciente_sexo_old").val()+"&paciente_fechanac_old="+$("#paciente_fechanac_old").val(), 
                    success: function(html){
                    }
                });
              cargarTablaEstudio();
            }
        });
    }
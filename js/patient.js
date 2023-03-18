function cargaTablaEstudio()
    {
    $("#div_tabla_estudio").html("<div class='overlay'><i class='fa fa-refresh fa-spin'></i></div>");

    $.ajax({
            type: "POST",
	           url: "estudio_lista.php",
            success: function(html){
                $('#div_tabla_estudio').html(html);
                $(function () {
                   $('#listaestudio').DataTable({
                    "initComplete": function (settings, json) {  
                      $("#listaestudio").wrap("<div style='overflow:auto; width:100%;position:relative;'></div>");            
                       },
                      "dom": '<"top">rt<"bottom"filp><"clear">',
                      "paging": true,
                      "pageLength": 10,
                      "lengthChange": true,
                      "searching": false,
                      "order": [],
                      "ordering": true,
                      "info": true,
                      "autoWidth": false,
                      "scrollCollapse": true,
                      "fixedColumns": false,
                      "aoColumns": [null,null,null,null,null,null,null,null,null,null,{ "bSortable": false }],
                      "language": {"url": "./plugins/datatables/Spanish.json"}            
                    });

            });

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
              if (html.includes('ambiguous')||html.includes('exists')) { 
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
              cargaTablaEstudio();
            }
        });
    }
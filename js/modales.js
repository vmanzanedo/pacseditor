function modales()
    {
    $('#modal').on('show.bs.modal', function (event) {    
       var button = $(event.relatedTarget) ;
       var op = button.data('op');
       var modulo = button.data('modulo');
       switch(button.data('entidad'))
            { 
            case "gestorimagen":
                switch(op)
                    {
                    case 1: titulo = "Gestion de Imagenes"; break;
                    }
                ruta = "../pacseditor/gestionimagen/gestionimagen_form.php",
                datos = "pk="+button.data('pk')+"&study_iuid="+button.data('studyuid')+"&op="+op;	    
                break;   
            case "pacseditor":
                switch(op)
                    {
                    case 1: titulo = "Modificar Datos Paciente"; break;
                    case 2: titulo = "Modificar Dni"; break;
                    }
                ruta = "../pacseditor/patient_form.php",
                datos = "paciente_nombre="+button.data('paciente_nombre')+"&pk="+button.data('pk')+"&paciente_dni="+button.data('paciente_dni')+"&fecha_nacimiento="+button.data('fecha_nacimiento')+"&paciente_sexo="+button.data('paciente_sexo')+"&study_iuid="+button.data('study_iuid')+"&op="+op;	    
                break;    
            case "pacseditor_an":
                    switch(op)
                    {
                    case 1: titulo = "Modificar A.N."; break;
                    }
                ruta = "../pacseditor/an_form.php",
                datos = "study_iuid="+button.data('studyuid')+"&practica_an="+button.data('practica_an')+"&accno_issuer_fk="+button.data('accno_issuer_fk');	    
                break;        
            case "pacseditor_studydesc":
                    switch(op)
                    {
                    case 1: titulo = "Modificar Study_desc"; break;
                    }
                ruta = "../pacseditor/studydesc_form.php",
                datos = "study_iuid="+button.data('studyuid')+"&study_desc="+button.data('study_desc');	    
                break;       
            }            
        var modal = $(this);
        modal.find('.modal-title').text(titulo);
        $.ajax
            ({
            type: "POST",
            url: ruta,
            data: datos,	    
            success: function(html){
                modal.find('.modal-body').html(html);
                }    	
            });  
    });    

}


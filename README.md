Versiones

2022-09-14 Se agrega modificacion de AN

2023-02-22 Se agrega modificacion de Study Desc

2023-07-13 Se agrega modificacion de AN Issuer

2023-08-04 Almacena correctamente caracteres especiales en nombre de paciente y descripcion de estudio

2023-08-18 Se corrige edicion de nombre de paiente para conservar pat_id_issuer

2023-09-04 Se agrega eliminacion (envio a papelera) de estudios, series o instancias

2023-09-08 Se añade funcion "Agregar paciente y migrar estudio", y "Mover Series"

2023-10-03 Filtro por sucursal

2023-10-11 Se deja boton "Crear paciente y migrar estudio" solo en edicion de datos demograficos


Version 1.3

1.3.0
-Se controla eliminacion de estudios, series e imagenes de acuerdo al permiso del usuario
-Al crear y migrar estudio, se incluye la copia del pat_id_issuer
-Filtro por modalidad
-Control de Historial de Estudios al modificar Datos o DNI


1.3.1
-Ante una modificacion de DNI, y el nuevo DNI ya existe, se ultiman los intentos de modificacion via HL7 y si no es exitoso se llama a la funcion crearPatient (crear y migrar estudio)

1.3.2
-Se filtra el listado por modalidad, si es que el usuario tienen modalidades asignadas


Version 1.4

1.4.0
-Se añade script en "C" (root_shell) para poder ejecutar "dcmodify" con permisos root. Se lo convoca desde "./actualzardicom.php" y en "./gestionimagen/moverseries.php"
    El script es "root_shell.c". Se lo debe compilar con:
        gcc root_shell.c -o root_shell
    Luego añadir los siguientes permisos:
        sudo chown root:root root_shell
        sudo chmod u=rwx,go=xr,+s root_shell

-Ocultar y eliminar series no cierra form modal        


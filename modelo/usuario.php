<?php
require_once("conexion.php");
require_once("pacs.php");
class Usuario{

function Autenticar($usuario,$clave)
    {
    $con = new Conexion();
    $cnn = $con->ConectarGral();
    $consulta = $cnn->prepare("SELECT usuario_id,usuario_user,usuario_nombre, usuario_adminpacs FROM usuario WHERE usuario_user = ? AND usuario_clave = ?");
    $consulta->execute(array($usuario,$clave));
    $reg = $consulta->fetch();
    if(isset($reg['usuario_id']))
        {
        session_name("pacseditor");
        session_start();
        $_SESSION['autenticado'] = 1;
        $_SESSION['usuario_id'] = $reg['usuario_id'];
        $_SESSION['usuario'] = $reg['usuario_user'];
        $_SESSION['nombre'] = $reg['usuario_nombre'];
        $_SESSION['usuario_adminpacs'] = $reg['usuario_adminpacs'];
        $_SESSION['trabajarconworklist'] = 1;
        
        
        $consulta=$cnn->prepare("SELECT sucursal.sucursal_id, sucursal_descripcion, sucursal_key, sucursal_campotelefono FROM usuarioxsucursal INNER JOIN sucursal ON usuarioxsucursal.sucursal_id = sucursal.sucursal_id WHERE usuario_id = ?");        
        $consulta->execute(array($reg['usuario_id']));
        $regsuc = $consulta->fetch();
        $_SESSION['sucursal_id']=$regsuc['sucursal_id'];
        $_SESSION['sucursal_descripcion']=$regsuc['sucursal_descripcion'];
        $_SESSION['sucursal_key']=$regsuc['sucursal_key'];
        $_SESSION['sucursal_campotelefono']=$regsuc['sucursal_campotelefono'];
        
        
        $consulta = $cnn->prepare("INSERT INTO login (usuario_id, login_fecha, login_accion) VALUES (?,?,?)");
        $consulta->execute(array($reg['usuario_id'], date("Y-m-d H:i:s"),1));
        
        //$pacs = new Pacs();
        //$regtiempopromedio = $pacs->ObtenerTiempoPromedio();
        //$_SESSION['tiempopromedio']=$regtiempopromedio['tiempopromedio_promedio'];

        $_SESSION['estudio_dni'] = '';
        $_SESSION['estudio_paciente'] = '';
        $_SESSION['estudio_an'] = '';
        $_SESSION['estudio_fechadesde'] = date("Y-m-d"); 
        $_SESSION['estudio_fechahasta'] = date("Y-m-d"); 
        $_SESSION['estudio_modalidad'] = '';
        
        }else{
            $_SESSION['autenticado'] = 0;
        }
    }

function VerificaPermiso($usuario_id, $modulo)
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("SELECT count(modulo_ruta) AS conpermiso FROM vista_usuario WHERE usuario_id = ? AND modulo_ruta = ?");
    $consulta->execute(array($usuario_id,$modulo));
    return $consulta->fetch();
    }    

function ListaMenus($usuario_id)
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("SELECT DISTINCT menu_id, menu_descripcion, menu_class FROM vista_usuario WHERE usuario_id = ? AND menu_id <> 1 ORDER BY menu_orden");
    $consulta->execute(array($usuario_id));
    return $consulta;
    }    
    
function ListaModulos($usuario_id, $menu_id)
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("SELECT DISTINCT modulo_id, modulo_descripcion, modulo_ruta, modulo_accdir, modulo_descaccdir, modulo_classdashboard, modulo_classmenu, modulo_bgcolor FROM vista_usuario WHERE usuario_id = ? AND menu_id = ? ORDER BY modulo_orden ASC");
    $consulta->execute(array($usuario_id, $menu_id));
    return $consulta;
    }       
    
function obtenerNivel($usuario_id, $perfil_id)
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("SELECT DISTINCT modulo_id, modulo_descripcion, modulo_ruta FROM vista_usuario WHERE usuario_id = ? AND menu_id = ? ORDER BY modulo_id");
    $consulta->execute(array($usuario_id, $menu_id));
    return $consulta;
    }       
    
function Lista()
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("SELECT usuario_id, usuario_user, usuario_nombre, usuario_clave, usuario_mail, usuario_firma, usuario_matricula, usuario_especialidad, usuario_color, usuario_numerosdiarios FROM usuario ORDER BY usuario_nombre");
    $consulta->execute();
    return $consulta;
    }

function ListaPerfil()
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("SELECT perfil_id, perfil_descripcion FROM perfil ORDER BY perfil_descripcion");
    $consulta->execute();
    return $consulta;
    }

//function ListaMenusPacsxPerfil()
//    {
//    $cnn = new Conexion;
//    $consulta = $cnn->prepare("SELECT perfil_id, perfil_descripcion FROM perfil ORDER BY perfil_descripcion");
//    $consulta->execute();
//    return $consulta;
//    }    
    
function ListadoMenuPacs()
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("SELECT * FROM menupacs ORDER BY menupacs_descripcion");
    $consulta->execute();    
    return $consulta;
    }   
    
function ListadoMenuPacsSinGestion()
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("SELECT * FROM menupacs WHERE menupacs_id <> 5 ORDER BY menupacs_descripcion");
    $consulta->execute();    
    return $consulta;
    }       
    
function ListaMenusPacsCargados($perfil_id)
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("SELECT DISTINCT perfilxmenupacs.menupacs_id, menupacs_descripcion FROM perfilxmenupacs INNER JOIN menupacs ON perfilxmenupacs.menupacs_id = menupacs.menupacs_id WHERE perfilxmenupacs.perfil_id = ? ORDER BY menupacs_descripcion");
    $consulta->execute($perfil_id);
    return $consulta;
    }        
    
function SelectIdPerfil($id)
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("SELECT * FROM perfil WHERE perfil_id = ?");
    $consulta->execute(array($id));
    return $consulta->fetch();    
    }

function ListaModulo()
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("SELECT modulo_id, modulo_descripcion, modulo_ruta, menu_descripcion FROM modulo INNER JOIN menu ON modulo.menu_id = menu.menu_id ORDER BY modulo_descripcion");
    $consulta->execute();
    return $consulta;
    }

function ListaMenu()
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("SELECT menu_id, menu_descripcion FROM menu ORDER BY menu_descripcion");
    $consulta->execute();
    return $consulta;
    }

function ListaMenuPacs()
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("SELECT menupacs_id, menupacs_descripcion FROM menupacs ORDER BY menupacs_descripcion");
    $consulta->execute();
    return $consulta;
    }

    
function SelectIdModulo($id)
    {
    $cnn = new Conexion;
    $consulta = $cnn->prepare("SELECT modulo_id, modulo_descripcion, modulo_ruta, menu_id FROM modulo WHERE modulo_id = ?");
    $consulta->execute(array($id));
    return $consulta->fetch();    
    }
    
}


?>
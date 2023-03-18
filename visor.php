<?php 
include("seguridad.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <title>Pentalogic | PACS Editor</title>
  <link rel="icon" type="image/png" href="plugins/login17/images/icons/favicon_penta.png"/>
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <!-- DataTables -->
  <link rel="stylesheet" href="plugins/DataTables-1.10.25/css/dataTables.bootstrap4.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/adminlte.min.css">
  
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/css/bootstrap-select.min.css">
  <link href="plugins/sweetalert/sweetalert2.min.css" rel="stylesheet">
  <!-- <link rel="stylesheet" href="plugins/select2/select2.min.css"> -->
  
  <!-- <link rel="stylesheet" href="plugins/toastr/build/toastr.css"> -->

</head>
<style>
thead input {
        width: 100%;
    }
</style>
<body class="hold-transition dark-mode sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed">
<div class="wrapper">
  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-dark">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button" id="btnCollapse"><i class="fas fa-bars"></i></a>
      </li>
    </ul>

    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">

      <!-- Diseño de Ventanas -->
      <div class="btn-group">
        <button type="button" class="btn dropdown-toggle dropdown-icon nav-link" data-toggle="dropdown">
          <i class="fas fa-user" title="<?php echo $_SESSION['usuario'] ?>"></i>
        </button>
        <div class="dropdown-menu ">
          <a href="logout.php" class="dropdown-item" id="btn1x2">
            <i class="fa fa-sign-out-alt"></i>  Cerrar Sesión
            <span class="float-right text-muted text-sm"></span>
          </a>
          <div class="dropdown-divider"></div>
        </div>  
      </div>
      
      <!-- Fullscreen-->
      <li class="nav-item">
        <a class="nav-link" data-widget="fullscreen" href="#" role="button">
          <i class="fas fa-expand-arrows-alt" title="Pantalla completa"></i>
        </a>
      </li>

    </ul>
  </nav>
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="#" class="brand-link">
      <img src="dist/img/isotipopentalogic.jpg" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light">PACS <b>Editor</b></span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
<!--        <div class="image">
          <img src="dist/img/avatar.png" class="img-circle elevation-2" alt="User Image">
        </div>-->
        <div class="info">
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-item menu-open">
            <span class="nav-link active">
              <i class="nav-icon fas fa-filter"></i>
              <p>
                Filtros
              </p>
            </span>
          </li>  

          <li class="nav-item">
            <a href="#" class="nav-link" id="menuDni">
              <i class="nav-icon far fa-user"></i>
              <p>
                DNI
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <div class="nav-link">
                  <input type="number" class="form-control" id="estudio_dni" <?php echo $_SESSION['estudio_dni']; ?>>
                </div>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link"  id="menuPaciente">
              <i class="nav-icon far fa-user"></i>
              <p>
                Paciente
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <div class="nav-link">
                  <input type="text" class="form-control" id="estudio_paciente" value="<?php echo $_SESSION['estudio_paciente']; ?>">
                </div>
              </li>
            </ul>
          </li>

          <li class="nav-item">
            <a href="#" class="nav-link"  id="menuAN">
              <i class="nav-icon fa fa-hashtag"></i>
              <p>
                Accession Number
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <div class="nav-link">
                  <input type="text" class="form-control" id="estudio_an" <?php echo $_SESSION['estudio_an']; ?>>
                </div>
              </li>
            </ul>
          </li>

          <li class="nav-item">
            <a href="#" class="nav-link" id="menuFecha">
              <i class="nav-icon fa fa-calendar-alt"></i>
              <p>
                Período
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="#" class="nav-link">Desde
                  <input type="date" class="form-control" id="estudio_fechadesde" value="<?php if (isset($_SESSION['estudio_fechadesde'])) echo $_SESSION['estudio_fechadesde']; else echo date("Y-m-d"); ?>">
                </a>
              </li>
            </ul>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="#" class="nav-link">Hasta
                  <input type="date" class="form-control" id="estudio_fechahasta" value="<?php if (isset($_SESSION['estudio_fechahasta'])) echo $_SESSION['estudio_fechahasta']; else echo date("Y-m-d"); ?>">
                </a>
              </li>
            </ul>
          </li>
          
          <li class="nav-item ">
            <button class="btn btn-primary nav-link " onclick="cargarVariablesFiltro();cargarTablaEstudio();">
              <i class="nav-icon fa fa-search"></i>
              <p>
                  Buscar
              </p>    
            </button>  
          </li>    
          <li class="nav-item ">
            <button class="btn btn-primary nav-link " onclick="limpiarVariablesFiltro();setTimeout(function(){location.href = './visor.php'},100);">
              <i class="nav-icon fa fa-eraser"></i>
              <p>
                  Limpiar
              </p>    
            </button>  
          </li>    
          
          
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <h1>Lista de Estudios - <?php echo $_SESSION['sucursal_descripcion'] ?></h1>
      </div> <!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">

        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
                  
              </div>
              <div class="card-body">
              <!-- <input id="min" type="text" placeholder="Date from.." />
              <input id="max" type="text" placeholder="Date to.." /> -->
                <div id="div_tabla_estudio" style="margin: 0px;">

                </div>
              </div>
              <div class="card-footer">
              
              </div>
              <!-- /.card-footer -->
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->

      </div><!--/. container-fluid -->
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->

  <!-- Main Footer -->
  <footer class="main-footer">
    <strong>Copyright &copy; 2022 <a href="https://pentalogic.tech">Pentalogic S.A.</a>.</strong>
    Todos los derechos reservados.
    <div class="float-right d-none d-sm-inline-block">
      <b>PACS Editor </b> 20230222
    </div>
  </footer>
</div>
    
<?php include "modal.php" ?> 
    
<!-- ./wrapper -->

<!-- REQUIRED SCRIPTS -->
<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- DataTables -->
<script src="plugins/DataTables-1.10.25/js/jquery.dataTables.js"></script>
<script src="plugins/DataTables-1.10.25/js/dataTables.bootstrap4.min.js"></script>

<!-- AdminLTE App -->
<script src="dist/js/adminlte.js"></script>
<script src="./plugins/sweetalert/sweetalert2.all.min.js"></script>
<script src="./js/modales.js?v=1.20230222"></script>
<script src="./js/patient.js?v=1.20230222"></script>

</body>

<script>

modales();

setTimeout(function(){
  $('#menuDni').click();
},100)
setTimeout(function(){
  $('#menuPaciente').click();
},200)
setTimeout(function(){
  $('#menuAN').click();
},300)
setTimeout(function(){
  $('#menuModalidad').click();
},400)
setTimeout(function(){
  $('#menuFecha').click();
},500)

setTimeout(function(){
  cargarTablaEstudio();
},600)



function cargarVariablesFiltro(){
  $.ajax ({
      type: "POST",
      url: "cargarvariablesfiltro.php",
      async:false,
      data: "estudio_dni="+$("#estudio_dni").val()+"&estudio_paciente="+$("#estudio_paciente").val()+"&estudio_fechadesde="+$("#estudio_fechadesde").val()+"&estudio_fechahasta="+$("#estudio_fechahasta").val()+"&estudio_an="+$("#estudio_an").val(), 
      success: function(html){
        //$('#btnCollapse').click();
      }    	
  });    
}

function limpiarVariablesFiltro(){
  $.ajax ({
      type: "POST",
      url: "limpiarvariablesfiltro.php",
      success: function(html){
      }    	
  });    
}

function cargarTablaEstudio()
    {
      $("#div_tabla_estudio").html("<div class='overlay'><i class='fa fa-refresh fa-spin'></i></div>");
      $.ajax
            ({
            type: "POST",
	           url: "estudio_lista.php",
            success: function(html){
                $('#div_tabla_estudio').html(html);
                $(function () {
                    var table = $('#listaestudio').DataTable({
                        "dom": 'B<"lrtip"><"float-left"i>t<"float-left"l><"float-right"p><"clearfix">',
                        "responsive": false,
                        "orderCellsTop": true,
                        "bInfo": false,
                        "paging": true,
                        "bStateSave": true,
                        "pageLength": 10,
                        "lengthChange": true,
                        "searching": false,
                        "ordering": true,
                        "info": true,
                        "autoWidth": false,
                        "scrollCollapse": true,
                        "fixedColumns": false,
                        "aoColumns": [null,null,null,null,null,null,null,null,null,null,{ "bSortable": false }],
                        "language": {"url": "./plugins/datatables/Spanish.json"} ,        
                    });
                }); //fun
            } //function
           }); //ajax
     }  //if
    
     
</script>  
</html>

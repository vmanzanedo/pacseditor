<!DOCTYPE html>
<html lang="en">
<head>
	<title>Pentalogic | PACS Editor</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
        <link rel="icon" type="image/png" href="./plugins/login17/images/icons/favicon_penta.png"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="./plugins/login17/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="./plugins/login17/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="./plugins/login17/css/util.css">
	<link rel="stylesheet" type="text/css" href="./plugins/login17/css/main.css">
<!--===============================================================================================-->
  
</head>
<body>
	
	<div class="limiter">
            <div class="container-login100">
                <div class="wrap-login100">
                    <form id="form_login" action="login.php" method="POST" class="login100-form validate-form">
                        <span class="login100-form-title p-b-34">
                            <img src="./plugins/login17/images/isotipopentalogic.jpg" style="border-radius: 0%" height="250" width="250"><br><br>
                                PACS Editor
                        </span>

                        <div class="wrap-input100 rs1-wrap-input100 validate-input m-b-20" data-validate="Ingrese Usuario">
                                <input id="first-name" class="input100" type="text" name="txtuser" id="txtuser" placeholder="Usuario">
                                <span class="focus-input100"></span>
                        </div>
                        <div class="wrap-input100 rs2-wrap-input100 validate-input m-b-20" data-validate="Ingrese Contraseña">
                                <input class="input100" type="password" name="txtclave" id="txtclave" placeholder="Contraseña">
                                <span class="focus-input100"></span>
                        </div>

                        <div class="container-login100-form-btn">
                                <button class="login100-form-btn">
                                        Ingresar
                                </button>
                        </div>
<!--                                        <div class="container-login100-form-btn" id="div_ingresar">
                                    <button class="login100-form-btn g-recaptcha" 
                                            data-sitekey="6LdY3XIeAAAAAEU5QbyiZaJGUI6eJ1IFBqYGcf5X" 
                                            data-callback='onSubmit' 
                                            data-action='submit'>Ingresar</button>
                            </div>-->

                        <div class="w-full text-center p-t-27 p-b-239">
                        <?php 
                        if(isset($_GET['e']))
                            if($_GET['e'])
                                echo "<p class='callout callout-danger'>Datos de acceso incorrectos o usuario no posee permisos!</p>";
                        ?>


                        </div>

                        <div class="w-full text-center">
                            <a href="https://pentalogic.tech" target="_blank"><img src="dist/img/logopentalogic.png" height="40" width="120"></a><br><br>
                        </div>
                    </form>

                    <div class="login100-more" style="background-image: url('./plugins/login17/images/bg-01orig.jpg');"></div>
                </div>
            </div>
	</div>
	
	

	<div id="dropDownSelect1"></div>
	
<!--===============================================================================================-->
	<script src="./plugins/login17/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="./plugins/login17/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="./plugins/login17/vendor/bootstrap/js/popper.js"></script>
	<script src="./plugins/login17/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->

        <script src="https://www.google.com/recaptcha/api.js"></script>

        <script>
          function onSubmit(token) {
            $("#div_ingresar").html("<div class='overlay'><i class='fa fa-refresh fa-spin'></i></div>");
//            var captchaResponse = token;
//            $.ajax ({
//              type: "POST",
//              url: "getcaptcharesult.php",
//              data: "response="+captchaResponse,
//              dataType: 'json',
//              success: function(html){
//                if (html['score']>=0.5)
                  $('#form_login').submit();
//                else
//                  alert("Acceso no permitido");
//              }    	
//            });
          }
	</script>
        

</body>
</html>

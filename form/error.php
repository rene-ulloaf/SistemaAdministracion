<?php
    function my_error_handler($errno){
        $errno = $errno;
        die(error_reporting($errno)." <---");
        if(!defined('E_STRICT')) define('E_STRICT', 2048);
        if(!defined('E_RECOVERABLE_ERROR')) define('E_RECOVERABLE_ERROR', 4096);

        switch($errno){
            case E_ERROR:$error = "Error";break;
            case E_WARNING:$error = "Advertencia";break;
            case E_PARSE:$error = "Error de análisis";break;
            case E_NOTICE:$error = "Aviso";break;
            case E_CORE_ERROR:$error = "Error de núcleo";break;
            case E_CORE_WARNING:$error = "Núcleo de Alerta";break;
            case E_COMPILE_ERROR:$error = "Error de compilación";break;
            case E_COMPILE_WARNING:$error = "Advertencia de compilación";break;
            case E_USER_ERROR:$error = "Error de Usuario";break;
            case E_USER_WARNING:$error = "Advertencia de Usuario";break;
            case E_USER_NOTICE:$error = "Aviso de Usuario";break;
            case E_STRICT:$error = "Aviso estricto";break;
            case E_RECOVERABLE_ERROR:$error = "Error recuperable";break;
            default:$error = "Error desconocido.";break;
        }
    }

    my_error_handler($_GET["cod"]);
?>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::Error::</title>
    </head>
    
    <body>
        <br /><br />

        <div style="text-align:center;"><?=$error;?></div>

        <br /><br />
        
        <div style="text-align:center;">
            <a href="login/login.php">Volver</a>
        </div>
    </body>
</html>

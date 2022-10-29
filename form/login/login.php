<?php
    //while(!file_exists($POSICION."conexion.php"))$POSICION.="../";
    
    include_once("../conf.ini");
    include_once("../../lib/BD.php");
    include_once("../../lib/Sesion.php");
    include_once("../../lib/Error.php");
    include_once("../../lib/Mail.php");
    include_once("clsLogin.php");
    
    if($_GET["msg"] != ""){
        $msg = $_GET["msg"];
        die($ultPagVista);
        $ultPagVista = $_GET["ultPagVista"];
    }

    if($_POST["hdnAccion"] == 1){
        $log = new Login($GLOBALS["idSistema"]);
        $msg = $log->Login($_POST["txtNomUsuario"], $_POST["txtPass"], "../" . $GLOBALS["index"], $ultPagVista);
    }
?>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>

    <body>
        <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
        
        <form id="frmLogin" name="frmLogin" method="post" action="#">
            <input type="hidden" id="hdnAccion" name="hdnAccion" value="1" />
            <input type="hidden" id="hdnPag" name="hdnPag" value="<?=$pag;?>" />
            
            <table align="center" border="1">
                <tr>
                    <td colspan="2" align="center">Inicio Sesi&oacute;n</td>
                </tr>

                <tr>
                    <td>Nombre Usuario:</td>
                    <td>
                        <input type="text" id="txtNomUsuario" name="txtNomUsuario" size="25" maxlength="25" />
                    </td>
                </tr>

                <tr>
                    <td>Password:</td>
                    <td>
                        <input type="password" id="txtPass" name="txtPass" size="25" maxlength="25" />
                    </td>
                </tr>
                <!--
                <tr>
                    <td>Recordar</td>
                    <td>
                        <input type="checkbox" id="chkRecordar" name="chkRecordar" />
                    </td>
                </tr>
                -->
                <tr>
                    <td colspan="2" align="center">
                        <button type="submit" id="btnIngresar" name="btnIngresar">Ingresar</button>
                        <button type="button" id="btnCancelar" name="btnCancelar">Cancelar</button>
                    </td>
                </tr>
            </table>
        </form>

        <br />

        <div style="text-align:center;"><?=$msg;?></div>

        <br />

        <!--
        <div>
            <a href="">Obtener Contraseña</a>
        </div>
        -->
    </body>
</html>
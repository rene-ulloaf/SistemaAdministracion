<?php
    session_start();
    
    include_once("../conf.ini");
    include_once("../../lib/BD.php");
    include_once("../../lib/sesion.php");

    $ses = new sesion($_SESSION["idSistema"]);
    
    if(isset($_POST["txt_perfil"])){
        /*if(isset($_POST["txt_perfil"])){
            $perfil = $_POST["txt_perfil"];
        }*/

        $ses->InicioSesionPerfil($_SESSION["idSistema"], $_SESSION["idUsuario"], $_POST["txt_perfil"]);
    }else{
        $arr_perfiles = $ses->ObtenerPerfiles($_SESSION["idSistema"], $_SESSION["idUsuario"]);
        $cant = count($arr_perfiles);
    }
?>

<html>
    <head>
        <title>Elecci&oacute;n de perfil</title>
    </head>

    <body>
        <div align="center">Seleccione el Perfil.</div>

        <br /><br /><br /><br />

        <form id="frmPerfiles" name="frmPerfiles" action="perfiles.php" method="post">
            <input type="hidden" id="txt_perfil" name="txt_perfil" value="<?=$cant;?>" />

            <table border="1" align="center">
                <tr>
                    <td align="center">Nombre</td>
                    <td align="center">Descripci&oacute;n</td>
                </tr>

                <?php
                    for($i=0;$i<$cant;$i++){
                ?>
                        <tr>
                            <td align="center">
                                <input type="hidden" id="txt_<?=$i;?>" name="txt_<?=$i;?>" value="<?=$arr_perfiles[$i]["id"];?>" />
                                <button type="button" id="btn_<?=$i;?>" name="btn_<?=$i;?>" onclick="javascript:seleccion(<?=$i;?>);">
                                    <?=$arr_perfiles[$i]["nombre"];?>
                                </button>
                            </td>
                            <td align="center"><?=($arr_perfiles[$i]["descripcion"]==""?"--":$arr_perfiles[$i]["descripcion"]);?></td>
                        </tr>
                <?php
                    }
                ?>
            </table>
        </form>

        <script type="text/javascript">
            function seleccion(sel){
                document.getElementById("txt_perfil").value = sel;
                frmPerfiles.submit();
            }
        </script>
    </body>
</html>
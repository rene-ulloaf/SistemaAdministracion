<?php
    session_start();

    if($_SESSION["activa"] == ""){
       header("Location: login/login.php?msg=Ha terminado la sesion.<br />Ingrese nuevamente&pag=" . $_SERVER["REQUEST_URI"]);
    }

    echo "- activa:[" . $_SESSION["activa"] . "]<br />";
    echo "- id_Usuario:[" . $_SESSION["idUsuario"] . "]<br />";
    echo "- id_Sistema:[" . $_SESSION["idSistema"] . "]<br />";
    echo "- id_Sesion:[" . $_SESSION["idSesion"] . "]<br />";
    echo "- id_Perfil:[" . $_SESSION["idPerfil"] . "]<br />";
    echo "- E-Mail:[" . $_SESSION["email"] . "]";
?>

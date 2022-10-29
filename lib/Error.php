<?php
    /**
     * Description of Util
     *
     * @author chechex
     */

    namespace Util;

    class ErrorHandler{
        private $ruta, $archError;

        public function __construct($ruta, $archError){
            $this->ruta = $ruta;
            $this->archError = $archError;
        }

        public function GuardarError($error, $codigoError, $pagina, $linea, $opcional = ""){
            if(!is_dir($this->ruta)){
                mkdir($this->ruta, 0777);
                chmod($this->ruta, 0777);
            }

            $ddf = fopen($this->ruta . $this->archError,"a");

            fwrite($ddf,$this->CreaArchivo($error, $codigoError, $pagina, $linea, $opcional));
            chmod($this->ruta . $this->archError, 0777);

            fclose($ddf);
        }

        public function errorMail($sistema, $error, $codigoError, $pagina, $linea, $opcional = ""){
            $mail = "<table border='1' font face='arial' size='12'>";
            $mail .= "<tr>";
            $mail .= "<td colspan='2' align='center'><b><h3>Error en " . $sistema . "</h3></b></td>";
            $mail .= "</tr>";
            $mail .= "<tr>";
            $mail .= "<td><b>C&oacute;digo</b></td>";
            $mail .= "<td>" . $codigoError . "</td>";
            $mail .= "</tr>";
            $mail .= "<tr>";
            $mail .= "<td><b>Descripci&oacute;n Error</b></td>";
            $mail .= "<td>" . $error . "</td>";
            $mail .= "</tr>";
            $mail .= "<tr>";
            $mail .= "<td><b>P&aacute;gina</b></td>";
            $mail .= "<td>" . $pagina . "</td>";
            $mail .= "</tr>";
            $mail .= "<tr>";
            $mail .= "<td><b>L&iacute;nea</b></td>";
            $mail .= "<td>" . $linea . "</td>";
            $mail .= "</tr>";
            $mail .= "<tr>";
            $mail .= "<td><b>Otro</b></td>";
            $mail .= "<td>" . $opcional . "</td>";
            $mail .= "</tr>";
            $mail .= "</table>";
            
            return $mail;
        }

        private function CreaArchivo($error, $codigoError, $pagina, $linea, $opcional){
            $arch = "fecha: " . date("d-m-Y H:i:s") . "\r\n";
            $arch .= "codigo: " . $codigoError . "\r\n";
            $arch .= "error: " . $error . "\r\n";
            $arch .= "pagina: " . $pagina . "\r\n";
            $arch .= "linea: " . $linea . "\r\n";
            $arch .= "otro: " . $opcional . "\r\n";
            $arch .= "----------------------\r\n\r\n";

            return $arch;
        }
    }
?>
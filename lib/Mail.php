<?php
    /*
     * Description of Mail
     *
     * @author chechex
    */

    namespace Util;
    
    class Mail{
        public function  __construct(){
            include_once("Mail/class.phpmailer.php");
            include_once("Mail/class.smtp.php");
        }
        public function EnviaGmail($nombreUsuario, $pass, $from, $fromName, $asunto, $altBody, $msg, $adjuntos, $destinatario, $nomDestinatario, $html){
            $mail = new \PHPMailer();
            
            $mail->IsSMTP();
            $mail->SMTPAuth = true;
            $mail->SMTPSecure = "ssl";
            $mail->Host = "smtp.gmail.com";
            $mail->Port = 465;

            $mail->Username = $nombreUsuario;
            $mail->Password = $pass;

            $mail->From = $from;
            $mail->FromName = $fromName;
            $mail->Subject = $asunto;
            $mail->AltBody = $altBody;
            $mail->MsgHTML($msg);
            
            foreach($adjuntos as $adjunto){
                $mail->AddAttachment($adjunto);
            }
            
            $mail->AddAddress($destinatario, $nomDestinatario);
            $mail->IsHTML($html);
            
            if(!$mail->Send()) {
                return $mail->ErrorInfo;
            }else{
                return "";
            }
        }
    }
?>

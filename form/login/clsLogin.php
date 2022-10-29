<?php
    /*
        Description of login
        
        @author chechex
    */

    class Login{
        private $idSistema;
        private $idUsuario;
        private $ses;

        public function __construct($idSistema){
            $this->ses = new sesion($idSistema);
            $this->idSistema = $idSistema;
        }

        public function Login($nomUsuario, $pass, $pagIndex, $pagRedireccion){
            $error = $this->Valida($nomUsuario, $pass);

            if($error == ""){
                $this->ses->DatosUsuarioValSes($nomUsuario, $pass);
                
                if($this->ses->Bloqueado()){
                    $error = "Usuario Bloqueado.";
                }else{
                    $this->idUsuario = $this->ses->getIdUsuario();
                    
                    switch($this->ses->CantPerfiles()){
                        case 0:
                            $error = "Usuario no tiene algun perfil asociado.";
                        break;
                        case 1:
                            $this->ses->InicioSesion($pagIndex, $pagRedireccion);
                        break;
                        default:
                            $this->ses->SesionPerfiles();
                            header("Location: perfiles.php");
                        break;
                    }
                }
            }

            return $error;
        }

        private function Valida($nomUsuario, $pass){
            if(trim($nomUsuario) == ""){
                return "Debe Ingresar el nombre de usuario.";
            }

            if(strlen($nomUsuario) > 25){
                return "Nombre de usuario muy largo.";
            }

            if(trim($pass) == ""){
                return "Debe Ingresar el password.";
            }

            if(strlen($nomUsuario) > 25){
                return "Password muy largo.";
            }

            if(!$this->ses->UsuarioValido($nomUsuario, $pass)){
               return "Nombre de usuario y/o pass invalidos.";
            }

            return "";
        }
    }
?>

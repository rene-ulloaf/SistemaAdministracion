<?php
    /*
     * To change this template, choose Tools | Templates
     * and open the template in the editor.
     */

    /**
     * Description of login
     *
     * @author chechex
     */

    class sesion{
        private $idUsuario = 0;
        private $idSistema;
        private $bloqueado = true;
        private $conn;
        private $errorHandler;
        private $enviaMail;

        public function __construct($sistema){
            $this->idSistema = $sistema;
            
            $this->errorHandler = new \Util\ErrorHandler("../../bitacora/", "error.log");
            $this->enviaMail = new \Util\Mail();

            try{
                $this->conn = new clsDBManager();
                
                $this->conn->Conectar($GLOBALS["Server"], $GLOBALS["User"], $GLOBALS["Pass"]);
                $this->conn->SeleccionarDB($GLOBALS["BD"]);
            }catch(Exception $exc){
                $this->errorHandler->GuardarError($exc->getCode(), $exc->getMessage(), $exc->getFile(), $exc->getLine(), "server:[" . $GLOBALS["Server"] . "] - user:[" . $GLOBALS["User"] . "] - pass:[". $GLOBALS["Pass"] ."]");
                $this->enviaMail->EnviaGmail($GLOBALS["userMail"], $GLOBALS["passMail"], $GLOBALS["userMail"],  $GLOBALS["nombreSistema"], "Error en: " . $GLOBALS["nombreSistema"], "Error en: " . $GLOBALS["nombreSistema"], $this->errorHandler->errorMail($GLOBALS["nombreSistema"], $exc->getMessage(), $exc->getCode(), $exc->getFile(), $exc->getLine(), "server:[" . $GLOBALS["Server"] . "] - user:[" . $GLOBALS["User"] . "] - pass:[". $GLOBALS["Pass"] ."]"), NULL, $GLOBALS["mailAdmin"], $GLOBALS["nombreAdmin"], TRUE);

                header("Location: ../error.php?cod=" . $exc->getCode());
            }
        }

        public function getIdUsuario() {
            return $this->idUsuario;
        }

        public function Bloqueado(){
            return $this->bloqueado;
        }

        public function UsuarioValido($nomUsuario, $pass){
            $query = "
                Select count(su.idSesionUsuario)
                From SesionUsuario su 
                Join Usuario u On su.idUsuario = u.idUsuario
                Where u.nombreUsuario = '" . $nomUsuario . "'
                And u.clave = '" . $pass . "'
                And su.idSistema = " . $this->idSistema . " 
                And su.vigente = 1
                And u.vigente = 1;
            ";
            
            try{
                if($this->conn->ExecuteScalar($query) == 0){
                    return false;
                }else{
                    return true;
                }
            }catch(Exception $exc){
                $this->errorHandler->GuardarError($exc->getCode(), $exc->getMessage(), $exc->getFile(), $exc->getLine(), $query);
                $this->enviaMail->EnviaGmail($GLOBALS["userMail"], $GLOBALS["passMail"], $GLOBALS["userMail"],  $GLOBALS["nombreSistema"], "Error en: " . $GLOBALS["nombreSistema"], "Error en: " . $GLOBALS["nombreSistema"], $query, NULL, $GLOBALS["mailAdmin"], $GLOBALS["nombreAdmin"], TRUE);

                header("Location: ../error.php?cod=" . $exc->getCode());
            }
        }

        public function ObtDatosUsuarioPerfil($idUsuario, $idSistema, $idPerfil){
            $query = "
                Select
                      u.idUsuario
                     ,su.idSesionUsuario
                     ,su.idPerfil
                     ,p.nombres + ' ' + p.primerApellido as nombre
                     ,e.email
                From SesionUsuario su
                Join Usuario u On su.idUsuario = u.idUsuario
                Join Personas_Email pe On u.idUsuario = pe.idUsuario
                Join EMail e On pe.idEmail = e.idEmail
                Join Personas p On pe.idPersona = p.idPersona
                Where su.idUsuario = " . $idUsuario . "
                And su.idSistema = " . $idSistema . "
                And su.idPerfil = " . $idPerfil . "
                And e.vigente = 1
                And p.vigente = 1;
            ";

            try{
                $res = $this->conn->GetObject($query);

                return $res;
            }catch(Exception $exc){
                $this->errorHandler->GuardarError($exc->getCode(), $exc->getMessage(), $exc->getFile(), $exc->getLine(), $query);
                $this->enviaMail->EnviaGmail($GLOBALS["userMail"], $GLOBALS["passMail"], $GLOBALS["userMail"],  $GLOBALS["nombreSistema"], "Error en: " . $GLOBALS["nombreSistema"], "Error en: " . $GLOBALS["nombreSistema"], $query, NULL, $GLOBALS["mailAdmin"], $GLOBALS["nombreAdmin"], TRUE);

                header("Location: ../error.php?cod=" . $exc->getCode());
            }
        }

        public function DatosUsuarioValSes($nomUsuario, $pass){
            $query = "
                Select u.idUsuario, u.bloqueo
                From SesionUsuario su
                Join Usuario u On su.idUsuario = u.idUsuario
                Where u.nombreUsuario = '" . $nomUsuario . "' 
                And u.clave = '" . $pass . "'
                And su.idSistema = " . $this->idSistema . "
                And su.vigente = 1 
                And u.vigente = 1;
            ";
            
            try{
                $result = $this->conn->ExecuteQuery($query);
                $cantRegs = $this->conn->GetNumRows($result);
                
                if($cantRegs < 1){
                    throw new Exception("Usuario " . $nomUsuario . " no tiene sesion para el sistema" . $this->idSistema, 999999998);
                }else{
                    while($row = $this->conn->GetObject($result)){
                        $this->bloqueado = $row->bloqueo;
                        $this->idUsuario = $row->idUsuario;
                    }
                }
            }catch(Exception $exc){
                $this->errorHandler->GuardarError($exc->getCode(), $exc->getMessage(), $exc->getFile(), $exc->getLine(), $query);
                $this->enviaMail->EnviaGmail($GLOBALS["userMail"], $GLOBALS["passMail"], $GLOBALS["userMail"],  $GLOBALS["nombreSistema"], "Error en: " . $GLOBALS["nombreSistema"], "Error en: " . $GLOBALS["nombreSistema"], $query, NULL, $GLOBALS["mailAdmin"], $GLOBALS["nombreAdmin"], TRUE);

                header("Location: ../error.php?cod=" . $exc->getCode());
            }
        }

        public function CantPerfiles(){
            $query = "
                Select count(su.idSesionUsuario)
                From SesionUsuario su
                Join Usuario u On su.idUsuario = u.idUsuario
                Where su.idUsuario = " . $this->idUsuario . "
                And su.idSistema = " . $this->idSistema . "
                And su.vigente = 1 
                And u.vigente = 1;
            ";
            
            try{
                return $this->conn->ExecuteScalar($query);
            }catch(Exception $exc){
                $this->errorHandler->GuardarError($exc->getCode(), $exc->getMessage(), $exc->getFile(), $exc->getLine(), $query);
                $this->enviaMail->EnviaGmail($GLOBALS["userMail"], $GLOBALS["passMail"], $GLOBALS["userMail"],  $GLOBALS["nombreSistema"], "Error en: " . $GLOBALS["nombreSistema"], "Error en: " . $GLOBALS["nombreSistema"], $query, NULL, $GLOBALS["mailAdmin"], $GLOBALS["nombreAdmin"], TRUE);

                header("Location: ../error.php?cod=" . $exc->getCode());
            }
        }

        public function ObtenerPerfiles($idSistema, $idUsuario){
            $i = 0;

            $query = "
                Select p.IdPerfil, p.nombrePerfil, p.descripcion
                From Perfil p
                Join SesionUsuario su On p.idPerfil = su.idPerfil
                Where su.idUsuario = " . $idUsuario . "
                And su.idSistema = " . $idSistema . "
                And su.vigente = 1
                And p.vigente = 1
                Order by p.IdPerfil;
            ";

            try{
                $result = $this->conn->ExecuteQuery($query);

                while($row = $this->conn->GetObject($result)){
                    $cont = array(
                        "id" => $row->IdPerfil,
                        "nombre" => $row->nombrePerfil,
                        "descripcion" => $row->descripcion
                    );

                    $arr_perfiles[$i] = $cont;
                    $i++;
                }
            }catch(Exception $exc){
                $this->errorHandler->GuardarError($exc->getCode(), $exc->getMessage(), $exc->getFile(), $exc->getLine(), $query);
                $this->enviaMail->EnviaGmail($GLOBALS["userMail"], $GLOBALS["passMail"], $GLOBALS["userMail"],  $GLOBALS["nombreSistema"], "Error en: " . $GLOBALS["nombreSistema"], "Error en: " . $GLOBALS["nombreSistema"], $query, NULL, $GLOBALS["mailAdmin"], $GLOBALS["nombreAdmin"], TRUE);

                header("Location: ../error.php?cod=" . $exc->getCode());
            }

            return $arr_perfiles;
        }

        public function SesionPerfiles(){
            session_start();

            $_SESSION["activa"] = TRUE;
            $_SESSION["idUsuario"] = $this->idUsuario;
            $_SESSION["idSistema"] = $this->idSistema;
        }

        public function InicioSesion($index, $pagRedireccion){
            $query = "
                Select
                      su.idSesionUsuario
                     ,su.idPerfil
                     ,p.nombres + ' ' + p.primerApellido as nombre
                     ,e.email
                     ,pf.paginaInicio
                From SesionUsuario su
                Join Usuario u On su.idUsuario = u.idUsuario
                Join Persona_Email pe On u.idUsuario = pe.idUsuario
                Join EMail e On pe.idEmail = e.idEmail
                Join Personas p On pe.idPersona = p.idPersona
                Join Perfil pf On su.idPerfil = pf.idPerfil
                Where su.idUsuario = " . $this->idUsuario . "
                And su.idSistema = " . $this->idSistema . "
                And su.vigente = 1
                And e.vigente = 1
                And p.vigente = 1;
            ";

            try{
                $result = $this->conn->ExecuteQuery($query);
                $cantRegs = $this->conn->GetNumRows($result);
                $cantRegs = ($cantRegs == "" ? 0 : $cantRegs);

                if($cantRegs > 1){
                    throw new Exception("Usuario " . $nomUsuario . " tiene muchas sesiones para el sistema " . $this->idSistema, 999999999);
                }elseif ($cantRegs < 1){
                    throw new Exception("Usuario " . $nomUsuario . " no tiene sesion para el sistema" . $this->idSistema);
                }else{
                    while($row = $this->conn->GetObject($result)){
                        $idSesionUsuario = $row->idSesionUsuario;
                        $idPerfil = $row->idPerfil;
                        $nombre = $row->nombre;
                        $email = $row->email;
                        $pagInicio = $row->paginaInicio;
                    }

                    session_start();

                    $_SESSION["activa"] = TRUE;
                    $_SESSION["idUsuario"] = $this->idUsuario;
                    $_SESSION["idSistema"] = $this->idSistema;
                    $_SESSION["idSesion"] = $idSesionUsuario;
                    $_SESSION["idPerfil"] = $idPerfil;
                    $_SESSION["nombre"] = $nombre;
                    $_SESSION["email"] = $email;

                    if($pagRedireccion != ""){
                        header("Location: " . $pagRedireccion);
                    }else{
                        if($pagInicio == ""){
                            header("Location: " . $index);
                        }else{
                            header("Location: " . $pagInicio);
                        }
                    }
                }
            }catch(Exception $exc){
                $this->errorHandler->GuardarError($exc->getCode(), $exc->getMessage(), $exc->getFile(), $exc->getLine(), $query);
                $this->enviaMail->EnviaGmail($GLOBALS["userMail"], $GLOBALS["passMail"], $GLOBALS["userMail"],  $GLOBALS["nombreSistema"], "Error en: " . $GLOBALS["nombreSistema"], "Error en: " . $GLOBALS["nombreSistema"], $query, NULL, $GLOBALS["mailAdmin"], $GLOBALS["nombreAdmin"], TRUE);

                header("Location: ../error.php?cod=" . $exc->getCode());
            }
        }

        public function InicioSesionPerfil($idSistema, $idUsuario, $idPerfil){
            $query = "
                Select
                      su.idSesionUsuario
                     ,p.nombres + ' ' + p.primerApellido as nombre
                     ,e.email
                     ,pf.paginaInicio
                From SesionUsuario su
                Join Usuario u On su.idUsuario = u.idUsuario
                Join Persona_Email pe On u.idUsuario = pe.idUsuario
                Join EMail e On pe.idEmail = e.idEmail
                Join Personas p On pe.idPersona = p.idPersona
                Join Perfil pf On su.idPerfil = pf.idPerfil
                Where su.idUsuario = " . $idUsuario . "
                And su.idSistema = " . $idSistema . "
                And pf.IdPerfil = " . $idPerfil . "
                And e.vigente = 1
                And p.vigente = 1;
            ";

            try{
                $result = $this->conn->ExecuteQuery($query);
                $cantRegs = $this->conn->GetNumRows($result);
                $cantRegs = ($cantRegs == "" ? 0 : $cantRegs);

                if($cantRegs > 1){
                    throw new Exception("Usuario " . $nomUsuario . " tiene muchas sesiones para el sistema " . $this->idSistema, 999999999);
                }elseif ($cantRegs < 1){
                    throw new Exception("Usuario " . $nomUsuario . " no tiene sesion para el sistema" . $this->idSistema);
                }else{
                    while($row = $this->conn->GetObject($result)){
                        $idSesionUsuario = $row->idSesionUsuario;
                        $nombre = $row->nombre;
                        $email = $row->email;
                        $pagInicio = $row->paginaInicio;
                    }

                    session_start();

                    $_SESSION["activa"] = TRUE;
                    $_SESSION["idUsuario"] = $idUsuario;
                    $_SESSION["idSistema"] = $idSistema;
                    $_SESSION["idSesion"] = $idSesionUsuario;
                    $_SESSION["idPerfil"] = $idPerfil;
                    $_SESSION["nombre"] = $nombre;
                    $_SESSION["email"] = $email;

                    if($pagInicio == ""){
                        header("Location: ../index.php");
                    }else{
                        header("Location: " . $pagInicio);
                    }
                }
            }catch(Exception $exc){
                $this->errorHandler->GuardarError($exc->getCode(), $exc->getMessage(), $exc->getFile(), $exc->getLine(), $query);
                $this->enviaMail->EnviaGmail($GLOBALS["userMail"], $GLOBALS["passMail"], $GLOBALS["userMail"],  $GLOBALS["nombreSistema"], "Error en: " . $GLOBALS["nombreSistema"], "Error en: " . $GLOBALS["nombreSistema"], $query, NULL, $GLOBALS["mailAdmin"], $GLOBALS["nombreAdmin"], TRUE);

                header("Location: ../error.php?cod=" . $exc->getCode());
            }
        }

        private function __destruct(){
            $this->conn->Desconectar();
        }
    }
?>
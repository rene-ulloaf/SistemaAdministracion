<?php
    class clsBD{
        protected $coneccion;

        public function __construct(){}

        public function Conectar($host,$user,$pass){
            $this->coneccion = mysql_connect($host,$user,$pass) Or $_error = true;

            if($_error){
                throw new Exception(clsDBManager::Error(),clsDBManager::NroError());
            }else{
                return $this->coneccion;
            }
        }

        public function SeleccionarDB($db){
            mysql_select_db($db,$this->coneccion) Or $_error = true;

            if($_error){
                throw new Exception(clsDBManager::Error(),clsDBManager::NroError());
            }
        }

        public function Desconectar(){
            die($this->coneccion);
            mysql_close($this->coneccion);
        }

        public function __destruct(){}
    }

    class clsDBManager extends clsBD{
        public function ExecuteQuery($query){
            $result = mysql_query($query) or $_error = TRUE;

            if($_error){
                throw new Exception($this->Error(), $this->NroError());
            }else{
                return $result;
            }
        }

        /*public function ExecuteUnbufferedQuery($query, $link = null){
            $result = mysql_unbuffered_query($query, $link) or $_error = TRUE;

            if($_error){
                throw new Exception($this->Error(), $this->NroError());
            }else{
                return $result;
            }
        }*/

        public function ExecuteNonQuery($query){
            $result = $this->ExecuteQuery($query);

            return $this->GetAffectedRows();
        }

        public function ExecuteScalar($query){
            $result = $this->ExecuteQuery($query);
            $row = mysql_fetch_row($result);

            return $row[0];
        }

        public function GetArray($query){
            $result = mysql_fetch_array($query) Or $_error = true;

            if($_error){
                throw new Exception($this->Error(), $this->NroError());
            }else{
                return $result;
            }
        }

        public function GetObject($result){
            return mysql_fetch_object($result);
        }
        
        /*Devuelve el numero de filas de un resultado*/
        public function GetNumRows($result){
            return mysql_num_rows($result);
        }

        /*devuelve el numero de campos de un identificador de resultado.*/
        public function GetNumFields($result){
            $result = mysql_num_fields($result) Or $_error = true;

            if($_error){
                throw new Exception($this->Error(), $this->NroError());
            }else{
                return $result;
            }
        }

        /*Devuelve el numero de filas afectadas.*/
        public function GetAffectedRows(){
            $result = mysql_affected_rows() Or $_error = true;

            if($_error){
                die("err: ".mysql_error());
                throw new Exception($this->Error(), $this->NroError());
            }else{
                return $result;
            }
        }

        public function InformacionCampo($result, $indice){
            $result = mysql_fetch_field($result, $indice) Or $_error = true;

            if($_error){
                throw new Exception($this->Error(), $this->NroError());
            }else{
                return $result;
            }
        }

        public function State(){
            return mysql_info();
        }

        function Dispose($result){
            mysql_free_result($result) Or $_error = true;

            if($_error){
                throw new Exception($this->Error(), $this->NroError());
            }
        }

        public function Error(){
            return mysql_error();
        }

        public function NroError(){
            return mysql_errno();
        }

        //public function __destruct(){}
    }
?>

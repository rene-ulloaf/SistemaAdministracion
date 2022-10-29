<?php
	class clsCargaExcel{
			const ruta = "../temp";
			public $nombreArchivo = "";
			public $tipoArchivo = "";
			public $tamanoArchivo = "";
			public $archivo_temp = "";
			public $msg_error = "";
			
		public function __construct(){
			$this->nombreArchivo = explode(".",$_FILES["archivo"]["name"]);
			$this->tipoArchivo = $_FILES["archivo"]["type"];
			$this->tamanoArchivo = $_FILES["archivo"]["size"];
			$this->archivo_temp = $_FILES["archivo"]["tmp_name"];
			
			$this->SubirExcel();
		}
		
		protected function DatosOK(){
			$respuesta = true;
			
			if($this->nombreArchivo == ""){
				$this->msg_error = "Debe Elegir alg&uacute;n Archivo.<br />";
				$respuesta = false;
			}
			
			if($this->tipoArchivo != "application/vnd.ms-excel"){
				$this->msg_error .= "Tipo Archivo Inv&aacute;lido";
				$respuesta = false;
			}
			
			if($this->tamanoArchivo > 15120000){
				$this->msg_error .= "El tamaño del archivo no es Permitido.<br />";
				$respuesta = false;
			}
			
			return $respuesta;
		}
		
		protected function SubirExcel(){
			if($this->DatosOK()){
				try{
					if(!is_dir(self::ruta)){
						mkdir(self::ruta, 0777); 
					}
					
					if(is_uploaded_file($this->archivo_temp)) { 
						if (!copy($this->archivo_temp,self::ruta . $this->nombreArchivo[0] . ".xls")){
							throw new Exception("No se pudo copiar el archivo", "1");
						}else{
							$this->ManejoDatosExcel();
						}
					}else{
						die("Error al Subir el Archivo");
					}
					/*if(move_uploaded_file($archivo_temp,"temp/" . $nombreArchivo . "." . strtolower($tipoArchivo[1]))){
					}*/
				}catch(Exception $e){
					echo $e->getMessage().",".$e->getCode();
				}	
			}
		}
		
		protected function ManejoDatosExcel(){
			$mySQLconn = new clsDBManager();
			$datos = new Spreadsheet_Excel_Reader();
			
			$mySQLconn->Conectar($GLOBALS["Server"],$GLOBALS["User"],$GLOBALS["Pass"]);
			$mySQLconn->SeleccionarDB($GLOBALS["BD"]);
			
			$datos->setOutputEncoding("iso 8859-1");
			$datos->read(self::ruta . $this->nombreArchivo[0] . ".xls");
			error_reporting(E_ALL ^ E_NOTICE);
			
			for($i = 2; $i <= $datos->sheets[0]['numRows']; $i++){
				for($j = 1; $j <= $datos->sheets[0]['numCols']; $j++){
					try{
						$query = "
							call pa_InsertaPersonasADO(
								 '" . $datos->sheets[0]['cells'][$i][$j] . "'
								,'" . $datos->sheets[0]['cells'][$i][$j] . "'
								,'" . $datos->sheets[0]['cells'][$i][$j] . "'
								,'" . $datos->sheets[0]['cells'][$i][$j] . "'
								,'" . $datos->sheets[0]['cells'][$i][$j] . "'
								,'" . $datos->sheets[0]['cells'][$i][$j] . "'
								,'" . $datos->sheets[0]['cells'][$i][$j] . "'
								,'" . $datos->sheets[0]['cells'][$i][$j] . "'
								,'" . $datos->sheets[0]['cells'][$i][$j] . "'
								,'" . $datos->sheets[0]['cells'][$i][$j] . "'
								,'" . $datos->sheets[0]['cells'][$i][$j] . "'
								,'" . $datos->sheets[0]['cells'][$i][$j] . "'
								,'" . $datos->sheets[0]['cells'][$i][$j] . "'
								,'" . $datos->sheets[0]['cells'][$i][$j] . "'
								,'" . $datos->sheets[0]['cells'][$i][$j] . "'
								,'" . $datos->sheets[0]['cells'][$i][$j] . "'
								,'" . $datos->sheets[0]['cells'][$i][$j] . "'
								," . 1 . "
							);
						";
						
						$mySQLconn->ExecuteNonQuery($query);
					}catch (Exception $e){
						echo "numero:" . $e->getCode() . "- Error:" . $e->getMessage();
					}
				}
			}
			
			try{
				echo $mySQLconn->ExecuteNonQuery("call pa_pasoaPersonas();");
				$mySQLconn->Desconectar();
			}catch (Exception $e){
				echo "numero2:" . $e->getCode() . "- Error2:" . $e->getMessage();
			}
		}
		
		public function __destruct(){}
	}
?>
<html lang="es-ES">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<title>...</title>
		
		<?PHP
			include_once("../configuracion.php");
			include_once("../clases/BD.php");
			include_once("clscargaExcel.php");
			require_once("../clases/Excel/reader.php");
			
			$subir = ($_POST["subir"] == 1 ? true : false);
			$nombreArchivo = $_POST["archivo"];
			
			if($subir){
				$cargaExcel = new clsCargaExcel();
				$cargaExcel->__destruct();
			}
		?>
	</head>
	
	<body>
		<form name="frmSubeExcel" action="<?=$_SERVER['PHP_SELF'];?>" method="post" enctype="multipart/form-data"> 
			<table>
				<tr>
					<td>
						<input type="file" name="archivo" id="archivo" value="<?=$nombreArchivo;?>" />
						<input type="hidden" name="subir" id="suir" value="1" />
					</td>
				</tr>
				
				<tr>
					<td>
						<input type="submit" name="btnSubirXLS" id="btnSubirXLS" value="Subir Archivo" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
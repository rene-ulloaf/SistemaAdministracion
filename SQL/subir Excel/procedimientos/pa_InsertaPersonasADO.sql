DROP PROCEDURE pa_InsertaPersonasADO;
CREATE DEFINER = 'root'@'localhost' PROCEDURE pa_InsertaPersonasADO(In p_rut  VARCHAR(15),In p_DV CHAR(1),In p_nombres VARCHAR(100),In p_apellido1 VARCHAR(50),In p_apellido2 VARCHAR(50),In p_nacionalidad SMALLINT,In p_region SMALLINT,In p_ciudad SMALLINT,In p_comuna SMALLINT,In p_direccion VARCHAR(100),In p_numero SMALLINT,In p_email VARCHAR(300),In p_fonoCasa VARCHAR(15),In p_fonoCel VARCHAR(15),In p_fonoTrabajo VARCHAR(15),In p_otroFono VARCHAR(15),In p_sexo SMALLINT,In p_sistemaIngreso SMALLINT) NOT DETERMINISTIC CONTAINS SQL SQL SECURITY DEFINER COMMENT ''
BEGIN    
    Insert Into personasado(
    	 rut
        ,dv
        ,nombres
        ,primerApellido
        ,segundoApellido
        ,nacionalidad
  		,region
		,ciudad
		,comuna
		,direccion
		,numero
		,email
		,fonoCasa
		,fonoCel
		,fonoTrabajo
		,otroFono
		,sexo
		,sistemaIngreso
    )Values(
    	 p_rut
        ,Upper(p_DV)
        ,Upper(p_nombres)
        ,Upper(p_apellido1)
        ,Upper(p_apellido2)
        ,Upper(IFNULL((SELECT idPais FROM paises WHERE nombre Like CONCAT('%',p_nacionalidad,"%")),p_nacionalidad))
        ,Upper(IFNULL((SELECT idRegion FROM regiones WHERE glosaRegion Like CONCAT('%',p_region,"%")),p_region))
        ,Upper(IFNULL((SELECT idCiudad FROM ciudades WHERE glosaCiudad Like CONCAT('%',p_ciudad,'%')),p_ciudad))
		,Upper(IFNULL((SELECT idComuna FROM comunas WHERE glosaComuna Like CONCAT('%',p_comuna,'%')),p_comuna))
        ,Upper(p_direccion)
        ,p_numero
        ,Lower(p_email)
        ,p_fonoCasa
        ,p_fonoCel
        ,p_fonoTrabajo
        ,p_otroFono
        ,Upper(IFNULL((SELECT idSexo FROM sexo WHERE glosaSexo Like CONCAT('%',p_sexo,'%')),p_sexo))
        ,p_sistemaIngreso
    );
END;
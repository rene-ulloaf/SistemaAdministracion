DROP PROCEDURE IF EXISTS pa_pasoaPersonas;
CREATE DEFINER = CURRENT_USER PROCEDURE pa_pasoaPersonas() NOT DETERMINISTIC CONTAINS SQL SQL SECURITY DEFINER COMMENT '' BEGIN
    DECLARE v_idPersonaADO INT;
	DECLARE v_rut VARCHAR(15);
   	DECLARE v_DV CHAR(1);
    DECLARE v_nombres VARCHAR(100);
    DECLARE v_apellido1 VARCHAR(50);
    DECLARE v_apellido2 VARCHAR(50);
    DECLARE v_nacionalidad SMALLINT;
    DECLARE v_region SMALLINT;
    DECLARE v_ciudad SMALLINT;
    DECLARE v_comuna SMALLINT;
    DECLARE v_direccion VARCHAR(100);
    DECLARE v_numero SMALLINT;
    DECLARE v_email VARCHAR(300);
    DECLARE v_fonoCasa VARCHAR(15);
    DECLARE v_fonoCel VARCHAR(15);
    DECLARE v_fonoTrabajo VARCHAR(15);
    DECLARE v_otroFono VARCHAR(15);
    DECLARE v_sexo SMALLINT;
    DECLARE v_sistemaIngreso SMALLINT;
    
  	DECLARE v_idPersona INT;
    DECLARE v_error BIT;
    DECLARE v_errorMSG VARCHAR(500);
    DECLARE v_DVAUX CHAR(1);
    DECLARE v_EmailAUX BOOLEAN;
    DECLARE v_idEmail SMALLINT;
    DECLARE v_idFono SMALLINT;
    
    DECLARE v_done BIT DEFAULT FALSE;
    DECLARE v_puntero CURSOR FOR
    SELECT
    	 idPersonaado
    	,rut
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
        ,sexo
        ,sistemaIngreso
    FROM personasado
    Where pasadoOriginal = 0;
    
	/*DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_idPersona = 0;*/
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET v_done = TRUE;
	
	OPEN v_puntero;
    IF (Select FOUND_ROWS() > 0) THEN
	    miloop: LOOP
        
			FETCH v_puntero INTO v_idPersonaADO, v_rut, v_DV, v_nombres, v_apellido1, v_apellido2, v_nacionalidad, v_region, v_ciudad, v_comuna, v_direccion, v_numero, v_email, v_fonoCasa, v_fonoCel, v_fonoTrabajo, v_otroFono, v_sexo, v_sistemaIngreso;
			
            SET v_error = FALSE;
            SET v_errorMSG := '';
            
        	SELECT sesion.fn_ObtenerDV(v_rut) into v_DVAUX;
            IF STRCMP(v_DVAUX, v_DV) THEN
               	SET v_errorMSG := 'RUT INVALIDO';
            END IF;
            
            IF v_nombres = '' OR v_nombres IS NULL THEN
               	SET v_errorMSG := ' - NO EXISTE NOMBRE';
                SET v_error = TRUE;
            END IF;
            
            IF v_apellido1 = '' OR v_apellido1 IS NULL THEN
               	SET v_errorMSG := ' - NO EXISTE APELLIDO 1';
            END IF;
            
            IF v_apellido2 = '' OR v_apellido2 IS NULL THEN
               	SET v_errorMSG := ' - NO EXISTE APELLIDO 2';
            END IF;
            
            SELECT fn_ValidaEmail(v_email) INTO v_EmailAUX;
            IF NOT v_EmailAUX THEN
               	SET v_errorMSG := ' - E_MAIL INVALIDO';
                SET v_error = TRUE;
            END IF;
            
            IF NOT v_error THEN
               	SELECT IFNULL((SELECT idPersona FROM personas Where rut = v_rut),0) INTO v_idPersona;
                
              	IF v_idPersona = 0 THEN
                	SELECT IFNULL(MAX(idPersona) + 1, 1) INTO v_idPersona FROM personas;
                    
                   	INSERT INTO personas(
                    	 idPersona
                   		,rut
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
						,sexo
						,sistemaIngreso
						,fechaIngreso
                   	)VALUES(
                    	 v_idPersona
                   		,v_rut
						,v_DV
                        ,v_nombres
                        ,v_apellido1
                        ,v_apellido2
                        ,IFNULL((SELECT idPais FROM paises WHERE nombre = v_nacionalidad),0)
                        ,IFNULL((SELECT idRegion FROM regiones WHERE glosaRegion = v_region),0)
                        ,IFNULL((SELECT idCiudad FROM ciudades WHERE glosaCiudad = v_ciudad),0)
                        ,IFNULL((SELECT idComuna FROM comunas WHERE glosaComuna = v_comuna),0)
                        ,v_direccion
                        ,v_numero
                        ,IFNULL((SELECT idSexo FROM sexo WHERE glosaSexo = v_sexo),0)
                        ,v_sistemaIngreso
                        ,CURRENT_TIMESTAMP()
                  	);
                ELSE
                  	UPDATE personas SET
                       	 nombres = v_nombres
  						,primerApellido = v_apellido1
						,segundoApellido = v_apellido2
  						,nacionalidad = IFNULL((SELECT idPais FROM paises WHERE nombre = v_nacionalidad),0)
						,region = IFNULL((SELECT idRegion FROM regiones WHERE glosaRegion = v_region),0)
  						,ciudad = IFNULL((SELECT idCiudad FROM ciudades WHERE glosaCiudad = v_ciudad),0)
  						,comuna = IFNULL((SELECT idComuna FROM comunas WHERE glosaComuna = v_comuna),0)
  						,direccion = v_direccion
						,numero = v_numero
						,sexo = IFNULL((SELECT idSexo FROM sexo WHERE glosaSexo = v_sexo),0)
                        ,fechamodificacion = CURDATE()
                    WHERE idPersona = v_idPersona;
                END IF;
                
                SELECT count(e.idEmail) INTO v_idEmail
                FROM email e
                JOIN persona_email pe ON e.idEmail = pe.idEmail
                WHERE pe.idPersona = v_idPersona AND e.email = v_email;
                IF v_idEmail = 0 THEN
                   	INSERT INTO email(
                       	 email
                        ,vigente
                    )VALUES(
                       	 v_email
                        ,TRUE
                    );
                    
                   	SET v_idEmail = LAST_INSERT_ID();
                    
                  	INSERT INTO persona_email(
                       	 idPersona
                        ,idUsuario
                        ,idEmail
                    )VALUES(
                       	 v_idPersona
						,0
                        ,v_idEmail
                    );
                END IF;
                
                SELECT count(idTelefonos) INTO v_idFono
                FROM telefonos 
                Where idPersona = v_idPersona AND idTipoTelefono = 1 AND telefono = v_fonoCasa;
                IF v_idFono = 0 THEN
                   	INSERT INTO telefonos(
                       	 idPersona
                        ,idTipoTelefono
                        ,telefono
                    )VALUES(
                       	 v_idPersona
                        ,1
                        ,v_fonoCasa
                    );
                END IF;
                
                UPDATE personasado SET
					 comentario = v_errorMSG
                    ,pasadoOriginal = TRUE
                WHERE idPersonaADO = v_idPersonaADO;
            ELSE
               	UPDATE personasado SET
                	 comentario = v_errorMSG
					,pasadoOriginal = FALSE
                WHERE idPersonaADO = v_idPersonaADO;
            END IF;
        IF v_done THEN
			LEAVE miloop;
		END IF;
        
        END LOOP;
    END IF;
	
	CLOSE v_puntero;
END;
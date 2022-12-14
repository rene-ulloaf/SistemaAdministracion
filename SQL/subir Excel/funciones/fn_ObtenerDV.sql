DROP FUNCTION IF EXISTS fn_ObtenerDV;
CREATE DEFINER = CURRENT_USER FUNCTION sesion.fn_ObtenerDV(p_rut VARCHAR(15)) RETURNS varCHAR(15) NOT DETERMINISTIC CONTAINS SQL SQL SECURITY DEFINER COMMENT '' BEGIN
    DECLARE v_contador SMALLINT(6) DEFAULT 1;
    DECLARE v_contadorRUT SMALLINT(6) DEFAULT 2;
    DECLARE v_suma SMALLINT(6) DEFAULT 0;
    DECLARE v_dv varCHAR(15);
    DECLARE v_lengRUT SMALLINT(6) DEFAULT LENGTH(p_rut);
    
	WHILE v_contador <= v_lengRUT DO
    	SET v_suma = (SUBSTRING(p_rut, (v_lengRUT - (v_contador - 1)), 1) * v_contadorRUT) + v_suma;
        SET v_contador = (v_contador + 1);
        
        IF v_contadorRUT = 7 Then
        	SET v_contadorRUT = 2;
        ELSE
			SET v_contadorRUT = (v_contadorRUT + 1);
        END IF;
    END WHILE;
    
    CASE (11 - MOD(v_suma, 11))
		WHEN 10 THEN SET v_DV = 'K';
		WHEN 11 THEN SET v_DV = 0;
		ELSE SET v_DV = (11 - MOD(v_suma, 11));
	END CASE;
    
	RETURN v_DV;
END;
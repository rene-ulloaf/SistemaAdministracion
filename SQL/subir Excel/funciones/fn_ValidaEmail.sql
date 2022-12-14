DROP FUNCTION IF EXISTS fn_ValidaEmail;
CREATE DEFINER = CURRENT_USER FUNCTION fn_ValidaEmail(p_email VARCHAR(50)) RETURNS BOOLEAN NOT DETERMINISTIC CONTAINS SQL SQL SECURITY DEFINER COMMENT '' BEGIN
	DECLARE v_respuesta BOOLEAN;
    
    	SELECT p_email REGEXP '^[_a-z0-9-]+(\.[_a-z0-9-]+[.])*@([a-z0-9]+[\.-])*[a-z0-9]+\.[a-z]{2,6}$' INTO v_respuesta;
    
    RETURN v_respuesta;
END;
DELIMITER $$
DROP FUNCTION IF EXISTS initcap; $$
CREATE FUNCTION initcap(p_cadena VARCHAR(100)) RETURNS VARCHAR(100)
COMMENT 'funcion que devuelve la primera letra de cada palabra en mayúsculas.'
BEGIN
	DECLARE v_posicion INT DEFAULT 0;
	DECLARE v_temporal VARCHAR(100)
	DEFAULT '';
	DECLARE v_resultado VARCHAR(100) DEFAULT '';
	
	REPEAT SET v_posicion = LOCATE(' ', p_cadena);
	
	IF v_posicion = 0 THEN
		SET v_posicion = CHAR_LENGTH(p_cadena);
	END IF;
	
	SET v_temporal = LEFT(p_cadena, v_posicion);
	
	IF CHAR_LENGTH(v_temporal) < 4 THEN
		SET v_resultado = CONCAT(v_resultado, v_temporal);
	ELSE
		SET v_resultado = CONCAT(v_resultado, UPPER(LEFT(v_temporal, 1)), SUBSTR(v_temporal, 2));
	END IF;
	
	SET p_cadena = RIGHT(p_cadena, CHAR_LENGTH(p_cadena) - v_posicion);
	
	UNTIL CHAR_LENGTH(p_cadena) = 0 END REPEAT;
	
	RETURN v_resultado;
END;
$$
DELIMITER ;

-- --------------------------------------------

DELIMITER $$
DROP FUNCTION IF EXISTS initcap; $$
CREATE FUNCTION initcap(p_cadena VARCHAR(100)) RETURNS VARCHAR(100)
BEGIN
	DECLARE v_posicion INT DEFAULT 0;
	DECLARE v_temporal VARCHAR(100) DEFAULT '';
	DECLARE v_resultado VARCHAR(100) DEFAULT '';
	
	REPEAT SET v_posicion = LOCATE(' ', p_cadena);
	
	IF v_posicion = 0 THEN
		SET v_posicion = CHAR_LENGTH(p_cadena);
	END IF;
	
	SET v_temporal = LEFT(p_cadena, v_posicion);
	SET v_resultado = CONCAT(v_resultado, UPPER(LEFT(v_temporal, 1)),SUBSTR(v_temporal, 2));
	SET p_cadena = RIGHT(p_cadena, CHAR_LENGTH(p_cadena) - v_posicion);
	
	UNTIL CHAR_LENGTH(p_cadena) = 0 END REPEAT;
	
	RETURN v_resultado;
END;
$$
DELIMITER ;

-- --------------------------------------------

CREATE FUNCTION upperfirst(x VARCHAR(255)) RETURNS VARCHAR(255) CHARSET latin1
RETURN CONCAT(UPPER(SUBSTRING(x, 1, 1)), LOWER(SUBSTRING(x, 2)))

-- --------------------------------------------

DELIMITER $$
DROP FUNCTION IF EXISTS initcap $$
CREATE FUNCTION initcap(p_cadena char(30)) RETURNS CHAR(30) CHARSET utf8
COMMENT 'funcion que devuelve la primera letra de cada palabra en mayúsculas.'
BEGIN
	SET @v_string1 ='';
	SET @v_string2 ='';
	WHILE p_cadena REGEXP ' ' DO
		SELECT SUBSTRING_INDEX(p_cadena, ' ', 1) INTO @v_string2;
		SELECT SUBSTRING(p_cadena, LOCATE(' ', p_cadena) + 1) INTO p_cadena;
		SELECT CONCAT(@v_string1, ' ', CONCAT(UPPER(SUBSTRING(@v_string2, 1, 1)), LOWER(SUBSTRING(@v_string2, 2)))) INTO @v_string1;
	END WHILE;
	RETURN TRIM(CONCAT(@v_string1, ' ', CONCAT(UPPER(SUBSTRING(p_cadena, 1, 1)), LOWER(SUBSTRING(p_cadena, 2)))));
END$$
DELIMITER ;
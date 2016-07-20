DROP DATABASE IF EXISTS pokedex;
CREATE DATABASE pokedex DEFAULT CHARACTER SET latin1 COLLATE latin1_bin;
USE pokedex;

CREATE TABLE pokemon (
	id INTEGER NOT NULL,
	identifier VARCHAR(79) NOT NULL,
	species_id INTEGER,
	height INTEGER NOT NULL,
	weight INTEGER NOT NULL,
	base_experience INTEGER NOT NULL,
	ordered INTEGER NOT NULL,
	is_default BOOLEAN NOT NULL,
	PRIMARY KEY (id),
	CHECK (is_default IN (0, 1))
);

CREATE TABLE regions (
	id INTEGER NOT NULL,
	identifier VARCHAR(79) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE region_names (
	region_id INTEGER NOT NULL,
	local_language_id INTEGER NOT NULL,
	name VARCHAR(79) NOT NULL,
	PRIMARY KEY (region_id, local_language_id),
	FOREIGN KEY(region_id) REFERENCES regions (id)
);

CREATE TABLE generations (
	id INTEGER NOT NULL,
	main_region_id INTEGER NOT NULL,
	identifier VARCHAR(79) NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY(main_region_id) REFERENCES regions (id)
);

CREATE TABLE generation_names (
	generation_id INTEGER NOT NULL,
	local_language_id INTEGER NOT NULL,
	name VARCHAR(79) NOT NULL,
	PRIMARY KEY (generation_id, local_language_id),
	FOREIGN KEY(generation_id) REFERENCES generations (id)
);

CREATE TABLE types (
	id INTEGER NOT NULL,
	identifier VARCHAR(79) NOT NULL,
	generation_id INTEGER NOT NULL,
	damage_class_id INTEGER,
	PRIMARY KEY (id),
	FOREIGN KEY(generation_id) REFERENCES generations (id)
);

CREATE TABLE type_names (
	type_id INTEGER NOT NULL,
	local_language_id INTEGER NOT NULL,
	name VARCHAR(79) NOT NULL,
	PRIMARY KEY (type_id, local_language_id),
	FOREIGN KEY(type_id) REFERENCES types (id)
);

CREATE TABLE pokemon_types (
	pokemon_id INTEGER NOT NULL,
	type_id INTEGER NOT NULL,
	slot INTEGER NOT NULL,
	PRIMARY KEY (pokemon_id, slot),
	FOREIGN KEY(pokemon_id) REFERENCES pokemon (id),
	FOREIGN KEY(type_id) REFERENCES types (id)
);

CREATE INDEX ix_pokemon_order ON pokemon (ordered);

CREATE INDEX ix_pokemon_is_default ON pokemon (is_default);

CREATE INDEX ix_region_names_name ON region_names (name);

CREATE INDEX ix_type_names_name ON type_names (name);

CREATE INDEX ix_generation_names_name ON generation_names (name);

DELIMITER $$
DROP FUNCTION IF EXISTS initcap $$
CREATE FUNCTION initcap(p_cadena CHAR(255)) RETURNS CHAR(255) CHARSET utf8
COMMENT 'Funcion que devuelve la primera letra de cada palabra en mayusculas.'
DETERMINISTIC
READS SQL DATA
BEGIN
	SET @v_string1 = '';
	SET @v_string2 = '';
	WHILE p_cadena REGEXP ' ' DO
		SELECT REPLACE(REPLACE(REPLACE(p_cadena, '    ', ' '), '   ', ' '), '  ', ' ') INTO p_cadena;
		SELECT SUBSTRING_INDEX(p_cadena, ' ', 1) INTO @v_string2;
		SELECT SUBSTRING(p_cadena, LOCATE(' ', p_cadena) + 1) INTO p_cadena;
		SELECT CONCAT(@v_string1, ' ', CONCAT(UPPER(SUBSTRING(@v_string2, 1, 1)), LOWER(SUBSTRING(@v_string2, 2)))) INTO @v_string1;
	END WHILE;
	RETURN TRIM(CONCAT(@v_string1, ' ', CONCAT(UPPER(SUBSTRING(p_cadena, 1, 1)), LOWER(SUBSTRING(p_cadena, 2)))));
END$$
DELIMITER ;

DELIMITER $$
DROP FUNCTION IF EXISTS typesByPokemon $$
CREATE FUNCTION typesByPokemon(p_pokemon_id INT) RETURNS VARCHAR(160)
DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE v_types VARCHAR(160) DEFAULT '';
	DECLARE v_type_name VARCHAR(79) DEFAULT '';
	DECLARE v_counter INT DEFAULT 0;
	DECLARE v_finish INT DEFAULT FALSE;
	
	DECLARE c_types CURSOR FOR
		SELECT tn.name
		FROM pokemon p
		JOIN pokemon_types pt ON p.id = pt.pokemon_id
		JOIN types t ON t.id = pt.type_id
		JOIN type_names tn ON tn.type_id = t.id
		WHERE tn.local_language_id = 9 AND p.id = p_pokemon_id;
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finish = TRUE;
	
	OPEN c_types;
	types_loop: LOOP
		FETCH c_types INTO v_type_name;
		
		IF v_counter < 2 THEN
			IF v_types = '' THEN
				SET v_types = v_type_name;
			ELSE
				IF v_types <> v_type_name THEN
					SET v_types = CONCAT(v_types, '|', v_type_name);
				END IF;
			END IF;
			
			SET v_counter = v_counter + 1;
		END IF;
		
		IF v_finish THEN
			LEAVE types_loop;
		END IF;
		
	END LOOP;
	CLOSE c_types;
	
	
	RETURN v_types;
END$$
DELIMITER ;

DELIMITER $$
DROP VIEW IF EXISTS pokemonList $$
CREATE VIEW pokemonList AS
	SELECT DISTINCT p.id pokemon_id, initcap(p.identifier) pokemon, typesByPokemon(p.id) type
	FROM pokemon p
	JOIN pokemon_types pt ON pt.pokemon_id = p.id
	JOIN types t ON t.id = pt.type_id
	ORDER BY pokemon_id ASC;
$$
DELIMITER ;

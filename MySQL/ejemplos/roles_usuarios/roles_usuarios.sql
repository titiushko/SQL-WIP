DROP DATABASE IF EXISTS roles_usuarios;
CREATE DATABASE IF NOT EXISTS roles_usuarios DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE roles_usuarios;

DROP TABLE IF EXISTS usuarios;
CREATE TABLE IF NOT EXISTS usuarios(
	id INT(5) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'LLave primaria de la tabla',
	nombre VARCHAR(100) NOT NULL COMMENT 'Nombre completo del usuario',
	email VARCHAR(75) NOT NULL COMMENT 'Login del usuario',
	password VARCHAR(45) NOT NULL COMMENT 'Clave del usuario',
	fecha_registro DATETIME NOT NULL COMMENT 'Fecha en la que se registro el usuario'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS perfiles;
CREATE TABLE IF NOT EXISTS perfiles(
	id INT(5) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Llave primaria de la tabla',
	nombre VARCHAR(45) NOT NULL COMMENT 'Descripción del perfil',
	fecha_registro DATETIME NOT NULL COMMENT 'Fecha de registro'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS usuarios_perfiles;
CREATE TABLE IF NOT EXISTS usuarios_perfiles(
	id INT(5) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	usuario_id INT(5) UNSIGNED NOT NULL,
	perfil_id INT(5) UNSIGNED NOT NULL,
	INDEX fk_usuarios_perfiles_usuarios_idx(usuario_id ASC),
	INDEX fk_usuarios_perfiles_perfiles_idx(perfil_id ASC),
	CONSTRAINT fk_usuarios_perfiles_usuarios FOREIGN KEY(usuario_id) REFERENCES usuarios(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_usuarios_perfiles_perfiles FOREIGN KEY(perfil_id) REFERENCES perfiles(id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS noticias;
CREATE TABLE IF NOT EXISTS noticias(
	id INT(5) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Llave primaria de la tabla',
	usuario_id INT(5) UNSIGNED NOT NULL COMMENT 'Usuario que crea la noticia',
	titulo VARCHAR(75) DEFAULT NULL COMMENT 'Titulo de la noticia',
	descripcion MEDIUMTEXT DEFAULT NULL COMMENT 'Cuerpo de la noticia',
	fecha_registro DATETIME DEFAULT NULL COMMENT 'Fecha en la que se registro la noticia',
	fecha_modificacion DATETIME DEFAULT NULL COMMENT 'Fecha de la ultima modificación',
	estado TINYINT(1) DEFAULT NULL COMMENT 'Estado de la noticia',
	INDEX fk_noticias_usuarios_idx(usuario_id ASC),
	CONSTRAINT fk_noticias_usuarios FOREIGN KEY(usuario_id) REFERENCES usuarios(id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS clientes;
CREATE TABLE IF NOT EXISTS clientes(
	id INT(5) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	usuario_id INT(5) UNSIGNED NOT NULL,
	nombre VARCHAR(45) DEFAULT NULL,
	fecha_nacimiento VARCHAR(45) DEFAULT NULL,
	email VARCHAR(45) DEFAULT NULL,
	telefono VARCHAR(45) DEFAULT NULL,
	fecha_registro VARCHAR(45) DEFAULT NULL,
	INDEX fk_clientes_usuarios_idx(usuario_id ASC),
	CONSTRAINT fk_clientes_usuarios FOREIGN KEY(usuario_id) REFERENCES usuarios(id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS recursos;
CREATE TABLE IF NOT EXISTS recursos(
	id INT(5) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100) DEFAULT NULL COMMENT 'Nombre del recurso',
	fecha_registro DATETIME DEFAULT NULL COMMENT 'Fecha en la que se registro el recurso'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS perfiles_recursos;
CREATE TABLE IF NOT EXISTS perfiles_recursos(
	id INT(5) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	consultar TINYINT(1) DEFAULT NULL DEFAULT 0,
	agregar TINYINT(1) DEFAULT NULL DEFAULT 0,
	editar TINYINT(1) DEFAULT NULL DEFAULT 0,
	eliminar TINYINT(1) DEFAULT NULL DEFAULT 0,
	recurso_id INT(5) UNSIGNED NOT NULL,
	perfil_id INT(5) UNSIGNED NOT NULL,
	INDEX fk_perfiles_recursos_recursos_idx(recurso_id ASC),
	INDEX fk_perfiles_recursos_perfiles_idx(perfil_id ASC),
	CONSTRAINT fk_perfiles_recursos_recursos FOREIGN KEY(recurso_id) REFERENCES recursos(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_perfiles_recursos_perfiles FOREIGN KEY(perfil_id) REFERENCES perfiles(id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

-- ============================================================================================================================================================

INSERT INTO perfiles(id, nombre, fecha_registro) VALUES
(1, 'Administrador', NOW()),
(2, 'Vendedor', NOW()),
(3, 'Perriodista', NOW()),
(4, 'Auditor', NOW());

INSERT INTO recursos(id, nombre, fecha_registro) VALUES
(1, 'Gestión Noticias', NOW()),
(2, 'Publicar Noticia', NOW()),
(3, 'Gestión Clientes', NOW()),
(4, 'Gestión Usuarios', NOW());

INSERT INTO perfiles_recursos(id, consultar, agregar, editar, eliminar, recurso_id, perfil_id) VALUES
(1, 1, 1, 1, 1, 1, 1),
(2, 1, 1, 1, 1, 2, 1),
(3, 1, 1, 1, 1, 3, 1),
(4, 1, 1, 1, 1, 4, 1),
(5, 1, 1, 1, 1, 3, 2),
(6, 1, 1, 1, 1, 1, 3),
(7, 1, 1, 1, 1, 1, 4),
(8, 1, 1, 1, 1, 2, 4);

INSERT INTO usuarios(id, nombre, email) VALUES
(1, 'German Garmendia', 'german.garmendia@youtube.ch'),
(2, 'Dross Rotzank', 'drossro.tzank@youtube.ve'),
(3, 'Rubén Doblas', 'ruben.doblas@youtube.es');

INSERT INTO usuarios_perfiles(id, usuario_id, perfil_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 3, 4);

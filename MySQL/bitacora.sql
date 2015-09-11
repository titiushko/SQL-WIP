SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;


DROP TABLE IF EXISTS bitacora;
CREATE TABLE IF NOT EXISTS bitacora (
  id int(11) NOT NULL AUTO_INCREMENT,
  operacion varchar(10) DEFAULT NULL,
  usuario varchar(40) DEFAULT NULL,
  `host` varchar(30) NOT NULL,
  modificado datetime DEFAULT NULL,
  tabla varchar(40) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

DROP TABLE IF EXISTS carrera;
CREATE TABLE IF NOT EXISTS carrera (
  clave_carrera int(11) NOT NULL,
  nom_carrera varchar(20) NOT NULL,
  num_depto int(11) NOT NULL,
  PRIMARY KEY (clave_carrera),
  KEY num_depto (num_depto)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
DROP TRIGGER IF EXISTS `bit_carr_ins`;
DELIMITER //
CREATE TRIGGER `bit_carr_ins` AFTER INSERT ON `carrera`
 FOR EACH ROW INSERT INTO bitacora(host, usuario, operacion, modificado, tabla) VALUES (SUBSTRING(USER(), (INSTR(USER(),'@')+1)), SUBSTRING(USER(),1,(instr(user(),'@')-1)), "INSERTAR", NOW(), "CARRERA")
//
DELIMITER ;
DROP TRIGGER IF EXISTS `bit_carr_upd`;
DELIMITER //
CREATE TRIGGER `bit_carr_upd` AFTER UPDATE ON `carrera`
 FOR EACH ROW INSERT INTO bitacora(host, usuario, operacion, modificado, tabla) VALUES (SUBSTRING(USER(), (INSTR(USER(),'@')+1)), SUBSTRING(USER(),1,(instr(user(),'@')-1)), "ACTUALIZAR", NOW(), "CARRERA")
//
DELIMITER ;
DROP TRIGGER IF EXISTS `bit_carr_del`;
DELIMITER //
CREATE TRIGGER `bit_carr_del` AFTER DELETE ON `carrera`
 FOR EACH ROW INSERT INTO bitacora(host, usuario, operacion, modificado, tabla) VALUES (SUBSTRING(USER(), (INSTR(USER(),'@')+1)), SUBSTRING(USER(),1,(instr(user(),'@')-1)), "ELIMINAR", NOW(), "CARRERA")
//
DELIMITER ;

DROP TABLE IF EXISTS departamento;
CREATE TABLE IF NOT EXISTS departamento (
  num_departamento int(11) NOT NULL,
  nombre_dept varchar(20) NOT NULL,
  jefe_num_tarjet int(11) NOT NULL,
  PRIMARY KEY (num_departamento),
  KEY jefe_num_tarjet (jefe_num_tarjet)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
DROP TRIGGER IF EXISTS `bit_depto_ins`;
DELIMITER //
CREATE TRIGGER `bit_depto_ins` AFTER INSERT ON `departamento`
 FOR EACH ROW INSERT INTO bitacora(host, usuario, operacion, modificado, tabla) VALUES (SUBSTRING(USER(), (INSTR(USER(),'@')+1)), SUBSTRING(USER(),1,(instr(user(),'@')-1)), "INSERTAR", NOW(), "DEPARTAMENTO")
//
DELIMITER ;
DROP TRIGGER IF EXISTS `bit_depto_upd`;
DELIMITER //
CREATE TRIGGER `bit_depto_upd` AFTER UPDATE ON `departamento`
 FOR EACH ROW INSERT INTO bitacora(host, usuario, operacion, modificado, tabla) VALUES (SUBSTRING(USER(), (INSTR(USER(),'@')+1)), SUBSTRING(USER(),1,(instr(user(),'@')-1)), "ACTUALIZAR", NOW(), "DEPARTAMENTO")
//
DELIMITER ;
DROP TRIGGER IF EXISTS `bit_depto_del`;
DELIMITER //
CREATE TRIGGER `bit_depto_del` AFTER DELETE ON `departamento`
 FOR EACH ROW INSERT INTO bitacora(host, usuario, operacion, modificado, tabla) VALUES (SUBSTRING(USER(), (INSTR(USER(),'@')+1)), SUBSTRING(USER(),1,(instr(user(),'@')-1)), "ELIMINAR", NOW(), "DEPARTAMENTO")
//
DELIMITER ;

DROP TABLE IF EXISTS maestros;
CREATE TABLE IF NOT EXISTS maestros (
  num_tarjeta int(11) NOT NULL DEFAULT '0',
  nombre varchar(50) DEFAULT NULL,
  PRIMARY KEY (num_tarjeta)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
DROP TRIGGER IF EXISTS `bit_mae_ins`;
DELIMITER //
CREATE TRIGGER `bit_mae_ins` AFTER INSERT ON `maestros`
 FOR EACH ROW INSERT INTO bitacora(host, usuario, operacion, modificado, tabla) VALUES (SUBSTRING(USER(), (INSTR(USER(),'@')+1)), SUBSTRING(USER(),1,(instr(user(),'@')-1)), "INSERTAR", NOW(), "MAESTROS")
//
DELIMITER ;
DROP TRIGGER IF EXISTS `bit_mae_upd`;
DELIMITER //
CREATE TRIGGER `bit_mae_upd` AFTER UPDATE ON `maestros`
 FOR EACH ROW INSERT INTO bitacora(host, usuario, operacion, modificado, tabla) VALUES (SUBSTRING(USER(), (INSTR(USER(),'@')+1)), SUBSTRING(USER(),1,(instr(user(),'@')-1)), "ACTUALIZAR", NOW(), "MAESTROS")
//
DELIMITER ;
DROP TRIGGER IF EXISTS `bit_mae_del`;
DELIMITER //
CREATE TRIGGER `bit_mae_del` AFTER DELETE ON `maestros`
 FOR EACH ROW INSERT INTO bitacora(host, usuario, operacion, modificado, tabla) VALUES (SUBSTRING(USER(), (INSTR(USER(),'@')+1)), SUBSTRING(USER(),1,(instr(user(),'@')-1)), "ELIMINAR", NOW(), "MAESTROS")
//
DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

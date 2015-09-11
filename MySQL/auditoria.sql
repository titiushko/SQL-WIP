SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;


DELIMITER $$
DROP PROCEDURE IF EXISTS `pr_calculo_comision`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pr_calculo_comision`(importe DECIMAL(9,2))
BEGIN
  SET @var_global_comision := valor / 5;
END$$

DELIMITER ;

DROP TABLE IF EXISTS auditoria_factura;
CREATE TABLE IF NOT EXISTS auditoria_factura (
  codigo int(10) unsigned NOT NULL AUTO_INCREMENT,
  usuario varchar(100) COLLATE latin1_bin NOT NULL,
  fecha datetime NOT NULL,
  numero_old varchar(15) COLLATE latin1_bin DEFAULT NULL,
  importetotal_old float(19,4) DEFAULT NULL,
  baseimponible_old float(19,4) DEFAULT NULL,
  porcentajeiva_old float(19,4) DEFAULT NULL,
  importeiva_old float(19,4) DEFAULT NULL,
  porcentajedescuento_old float(19,4) DEFAULT NULL,
  importedescuento_old float(19,4) DEFAULT NULL,
  codigocliente_old int(10) unsigned DEFAULT NULL,
  fecha_old datetime DEFAULT NULL,
  cobrado_old char(1) COLLATE latin1_bin DEFAULT NULL,
  observacion_old varchar(255) COLLATE latin1_bin DEFAULT NULL,
  importecobrado_old float(19,4) DEFAULT NULL,
  codusuarioa_old int(10) DEFAULT NULL,
  codusuariom_old int(10) DEFAULT NULL,
  fechaa_old datetime DEFAULT NULL,
  fecham_old datetime DEFAULT NULL,
  contabiliza_old char(1) COLLATE latin1_bin DEFAULT NULL,
  imprimida_old char(1) COLLATE latin1_bin DEFAULT NULL,
  enviada_old char(1) COLLATE latin1_bin DEFAULT NULL,
  fechaenvio_old datetime DEFAULT NULL,
  piefactura_old text COLLATE latin1_bin,
  fechavencimiento_old datetime DEFAULT NULL,
  serie_old char(2) COLLATE latin1_bin NOT NULL,
  numero_new varchar(15) COLLATE latin1_bin DEFAULT NULL,
  importetotal_new float(19,4) DEFAULT NULL,
  baseimponible_new float(19,4) DEFAULT NULL,
  porcentajeiva_new float(19,4) DEFAULT NULL,
  importeiva_new float(19,4) DEFAULT NULL,
  porcentajedescuento_new float(19,4) DEFAULT NULL,
  importedescuento_new float(19,4) DEFAULT NULL,
  codigocliente_new int(10) unsigned DEFAULT NULL,
  fecha_new datetime DEFAULT NULL,
  cobrado_new char(1) COLLATE latin1_bin DEFAULT NULL,
  observacion_new varchar(255) COLLATE latin1_bin DEFAULT NULL,
  importecobrado_new float(19,4) DEFAULT NULL,
  codusuarioa_new int(10) unsigned DEFAULT NULL,
  codusuariom_new int(10) unsigned DEFAULT NULL,
  fechaa_new datetime DEFAULT NULL,
  fecham_new datetime DEFAULT NULL,
  contabiliza_new char(1) COLLATE latin1_bin DEFAULT NULL,
  imprimida_new char(1) COLLATE latin1_bin DEFAULT NULL,
  enviada_new char(1) COLLATE latin1_bin DEFAULT NULL,
  fechaenvio_new datetime DEFAULT NULL,
  piefactura_new text COLLATE latin1_bin,
  fechavencimiento_new datetime DEFAULT NULL,
  serie_new char(2) COLLATE latin1_bin DEFAULT NULL,
  PRIMARY KEY (codigo)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS factura;
CREATE TABLE IF NOT EXISTS factura (
  codigo int(10) unsigned NOT NULL AUTO_INCREMENT,
  numero varchar(15) COLLATE latin1_bin DEFAULT NULL,
  importetotal float(19,4) DEFAULT NULL,
  baseimponible float(19,4) DEFAULT NULL,
  porcentajeiva float(19,4) DEFAULT NULL,
  importeiva float(19,4) DEFAULT NULL,
  porcentajedescuento float(19,4) DEFAULT NULL,
  importedescuento float(19,4) DEFAULT NULL,
  codigocliente int(10) unsigned NOT NULL DEFAULT '0',
  fecha datetime DEFAULT '0000-00-00 00:00:00',
  cobrado char(1) COLLATE latin1_bin DEFAULT NULL,
  observacion varchar(255) COLLATE latin1_bin DEFAULT NULL,
  importecobrado float(19,4) DEFAULT NULL,
  codusuarioa int(10) unsigned DEFAULT NULL,
  codusuariom int(10) unsigned DEFAULT NULL,
  fechaa datetime DEFAULT NULL,
  fecham datetime DEFAULT NULL,
  contabiliza char(1) COLLATE latin1_bin DEFAULT NULL,
  imprimida char(1) COLLATE latin1_bin DEFAULT NULL,
  enviada char(1) COLLATE latin1_bin DEFAULT NULL,
  fechaenvio datetime DEFAULT NULL,
  piefactura text COLLATE latin1_bin,
  fechavencimiento datetime DEFAULT NULL,
  serie char(2) COLLATE latin1_bin NOT NULL DEFAULT '',
  PRIMARY KEY (codigo),
  UNIQUE KEY Indice_Numero_Factura (numero) USING HASH
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_bin AUTO_INCREMENT=3 ;
DROP TRIGGER IF EXISTS `tg_auditoria_factura`;
DELIMITER //
CREATE TRIGGER `tg_auditoria_factura` AFTER UPDATE ON `factura`
 FOR EACH ROW BEGIN
   INSERT INTO auditoria_factura
     (usuario, fecha, numero_old, importetotal_old,
     baseimponible_old, porcentajeiva_old, importeiva_old,
     porcentajedescuento_old, importedescuento_old,
     codigocliente_old, fecha_old, cobrado_old,
     observacion_old, importecobrado_old, codusuarioa_old,
     codusuariom_old, fechaa_old, fecham_old, contabiliza_old,
     imprimida_old, enviada_old, fechaenvio_old,
     piefactura_old, fechavencimiento_old, serie_old,
     numero_new, importetotal_new, baseimponible_new,
     porcentajeiva_new, importedescuento_new, importeiva_new,
     porcentajedescuento_new, codigocliente_new,
     fecha_new, cobrado_new, observacion_new,
     importecobrado_new, codusuarioa_new, codusuariom_new,
     fechaa_new, fecham_new, contabiliza_new, imprimida_new,
     enviada_new, fechaenvio_new, piefactura_new,
     fechavencimiento_new, serie_new)
     VALUES (CURRENT_USER(), NOW(), OLD.numero, OLD.importetotal,
     OLD.baseimponible, OLD.porcentajeiva, OLD.importeiva,
     OLD.porcentajedescuento, OLD.importedescuento,
     OLD.codigocliente, OLD.fecha, OLD.cobrado,
     OLD.observacion, OLD.importecobrado, OLD.codusuarioa,
     OLD.codusuariom, OLD.fechaa, OLD.fecham, OLD.contabiliza,
     OLD.imprimida, OLD.enviada, OLD.fechaenvio,
     OLD.piefactura, OLD.fechavencimiento, OLD.serie,
     NEW.numero, NEW.importetotal, NEW.baseimponible,
     NEW.porcentajeiva, NEW.importedescuento, NEW.importeiva,
     NEW.porcentajedescuento, NEW.codigocliente,
     NEW.fecha, NEW.cobrado, NEW.observacion,
     NEW.importecobrado, NEW.codusuarioa, NEW.codusuariom,
     NEW.fechaa, NEW.fecham, NEW.contabiliza, NEW.imprimida,
     NEW.enviada, NEW.fechaenvio, NEW.piefactura,
     NEW.fechavencimiento, NEW.serie);
END
//
DELIMITER ;

DROP TABLE IF EXISTS ventas;
CREATE TABLE IF NOT EXISTS ventas (
  codigo int(10) unsigned NOT NULL AUTO_INCREMENT,
  codigocliente int(10) unsigned NOT NULL,
  codigocomercial int(10) unsigned NOT NULL,
  importeventa decimal(9,2) DEFAULT NULL,
  importecomision decimal(9,2) DEFAULT NULL,
  PRIMARY KEY (codigo)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin AUTO_INCREMENT=1 ;
DROP TRIGGER IF EXISTS `tg_actualizar_comision`;
DELIMITER //
CREATE TRIGGER `tg_actualizar_comision` BEFORE INSERT ON `ventas`
 FOR EACH ROW BEGIN
  CALL pr_calculo_comision(NEW.importeventa);
  SET NEW.importecomision = @var_global_comision;
END
//
DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

USE master
GO
-- ----------------------------------------------------------------------------
IF  EXISTS (SELECT name FROM sys.databases WHERE name = 'SeguimientoProyectos')
DROP DATABASE SeguimientoProyectos
GO
CREATE DATABASE SeguimientoProyectos
GO
-- ----------------------------------------------------------------------------
USE SeguimientoProyectos
GO
--
CREATE TABLE tm_usuario(
	codigo_usuario		VARCHAR(30) NOT NULL PRIMARY KEY,
	nombres_usuario		VARCHAR(150) NULL,
	apellidos_usuario	VARCHAR(150) NULL,
	nacimiento_usuario	DATE NULL,
	password_usuario	VARCHAR(32) NULL
)
--
CREATE TABLE tm_proyecto(
	codigo_proyecto			NUMERIC(7, 0) NOT NULL PRIMARY KEY,
	nombre_proyecto			VARCHAR(150) NULL,
	descripcion_proyecto	VARCHAR(500) NULL,
	inicio_proyecto			DATE NULL,
	fin_proyecto			DATE NULL,
	responsable_proyecto	VARCHAR(30) NULL
)
--
CREATE TABLE tm_tarea(
	codigo_tarea		NUMERIC(7, 0) NOT NULL PRIMARY KEY,
	nombre_tarea		VARCHAR(150) NULL,
	descripcion_tarea	VARCHAR(500) NULL,
	codigo_proyecto		NUMERIC(7, 0) NULL
)
--
CREATE TABLE tm_responsable(
	codigo_responsable	NUMERIC(7, 0) NOT NULL PRIMARY KEY,
	codigo_tarea		NUMERIC(7, 0) NULL,
	codigo_usuario		VARCHAR(30) NULL,
	fecha_responsable	DATE NULL
)
-- ----------------------------------------------------------------------------
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('101', 'E. Sorto', 'San Miguel', '2011-10-27', '2004-07-21', 'Marlene');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('102', 'S. Monjaras', 'San Juan Tepezontes', '2011-02-13', '2001-09-02', 'Titiushko');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('103', 'Q. Gonzalez', 'Sonsonate', '2000-12-30', '2014-02-23', 'Alejandro');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('104', 'S. Alegria', 'Atiquizaya', '2008-02-26', '2009-06-30', 'Erick');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('105', 'P. Cruz', 'Yamabal', '2009-03-07', '2012-05-01', 'Edenilson');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('106', 'D. Pozos', 'Ahuachapan', '2006-10-09', '2012-01-30', 'Yosely');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('107', 'A. Gutierrez', 'Torola', '2004-04-29', '2013-05-16', 'Marvin');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('108', 'A. Sorto', 'Apastepeque', '2007-11-17', '2011-09-16', 'Erika');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('109', 'X. Urbina', 'San Julian', '2011-04-27', '2008-04-25', 'Daniel');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('110', 'K. Galdamez', 'San Antonio Masahuat', '2002-08-16', '2002-01-19', 'Daniel');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('111', 'H. Reyes', 'Paraiso de Osorio', '2007-08-01', '2005-09-25', 'Claudia');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('112', 'G. Calderon', 'Joateca', '2004-04-28', '2012-10-11', 'Karen');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('113', 'C. Alvarado', 'San Vicente', '2012-05-21', '2014-04-13', 'Garcia');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('114', 'O. Duarte', 'San Vicente', '2005-03-21', '2012-06-05', 'Marlene');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('115', 'K. Molina', 'Santa Ana', '2007-10-04', '2008-04-02', 'Sandra');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('116', 'J. Ponce', 'Cuisnahuat', '2003-10-13', '2010-11-16', 'Ivette');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('117', 'E. Lozano', 'Concepcion Quezaltepeque', '2002-06-18', '2002-09-06', 'Josue');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('118', 'P. Mendoza', 'El Congo', '2001-05-11', '2003-06-12', 'Titiushko');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('119', 'K. Perez', 'Morazan', '2006-10-08', '2008-05-05', 'Grissel');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('120', 'I. Perez', 'Ojos de Agua', '2000-01-24', '2010-10-23', 'Tatiana');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('121', 'C. Galdamez', 'La Union', '2002-04-23', '2006-12-22', 'Lisbeth');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('122', 'N. Duarte', 'San Miguel', '2013-04-26', '2003-10-19', 'Ivette');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('123', 'H. Duran', 'Chapeltique', '2002-02-23', '2011-03-31', 'Ingris');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('124', 'E. Brito', 'Chalatenango', '2001-10-26', '2006-06-15', 'Ingris');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('125', 'X. Mejia', 'San Buenaventura', '2005-09-04', '2006-03-06', 'Beatriz');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('126', 'H. Flores', 'Tacuba', '2013-08-11', '2005-10-03', 'Iris');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('127', 'A. Castro', 'La Union', '2007-07-14', '2012-08-31', 'Kevin');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('128', 'W. Romero', 'Santa Ana', '2004-03-29', '2010-01-17', 'Maria');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('129', 'P. Calderon', 'Morazan', '2005-10-16', '2002-01-08', 'Alejandro');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('130', 'Y. Ponce', 'Aguilares', '2006-12-29', '2001-12-15', 'Xiomara');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('131', 'Q. Hernandez', 'San Miguel', '2005-10-31', '2007-10-29', 'Vladimir');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('132', 'M. Vega', 'Morazan', '2010-04-05', '2006-11-15', 'Abigail');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('133', 'E. Bonilla', 'Chirilagua', '2011-11-22', '2010-01-12', 'Karen');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('134', 'M. Mejia', 'La Libertad', '2008-09-09', '2011-10-29', 'Yosely');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('135', 'D. Bonilla', 'Uluazapa', '2011-05-15', '2004-10-19', 'Evelyn');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('136', 'Y. Leon', 'Jayaque', '2013-12-04', '2001-04-02', 'Rodolfo');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('137', 'P. Henriquez', 'Cabañas', '2008-05-16', '2000-01-02', 'Marlene');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('138', 'W. Perez', 'San Antonio Masahuat', '2011-06-29', '2011-03-20', 'Alfredo');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('139', 'N. Cabrera', 'San Luis La Herradura', '2007-07-01', '2008-01-16', 'Carlos');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('140', 'H. Gamez', 'Cuscatlan', '2006-03-26', '2006-10-13', 'Ana');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('141', 'X. Carrillo', 'Morazan', '2006-02-28', '2006-01-30', 'Rosa');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('142', 'D. Escobar', 'Guadalupe', '2011-01-14', '2002-06-30', 'Kevin');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('143', 'T. Martinez', 'San Ignacio', '2013-02-23', '2010-12-28', 'Ana');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('144', 'M. Molina', 'El Rosario', '2014-01-26', '2009-03-16', 'Jacqueline');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('145', 'C. Cubas', 'San Salvador', '2006-12-20', '2001-08-28', 'Yosely');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('146', 'I. Cruz', 'La Libertad', '2009-12-06', '2008-07-17', 'Garcia');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('147', 'X. Escobar', 'La Union', '2014-01-13', '2011-01-28', 'Marlene');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('148', 'P. Cornejo', 'La Union', '2004-04-30', '2010-11-13', 'Carmen');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('149', 'E. Oviedo', 'Santa Ana', '2005-08-30', '2000-09-27', 'Nestor');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('150', 'I. Medrano', 'San Miguel', '2013-11-11', '2009-04-13', 'Marlene');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('151', 'X. Hernandez', 'San Salvador', '2001-01-03', '2010-11-16', 'Carmen');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('152', 'O. Contreras', 'Sonsonate', '2006-08-08', '2004-08-20', 'Jimmy');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('153', 'C. Medrano', 'La Laguna', '2013-07-22', '2012-03-31', 'Erika');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('154', 'G. Cornejo', 'San Vicente', '2008-08-04', '2009-12-15', 'Alexander');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('155', 'T. Vega', 'Jayaque', '2009-12-16', '2014-03-08', 'Emperatriz');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('156', 'K. Mendoza', 'Ilobasco', '2012-11-05', '2002-11-25', 'Marlene');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('157', 'X. Portillo', 'San Miguel', '2007-07-06', '2007-10-16', 'Sanchez');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('158', 'A. Duran', 'Santa Rosa de Lima', '2008-05-20', '2006-06-08', 'Ernesto');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('159', 'N. Sanchez', 'La Paz', '2004-02-27', '2006-04-28', 'Yosely');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('160', 'D. Flores', 'San Esteban Catarina', '2000-08-05', '2000-03-22', 'Edenilson');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('161', 'P. Gamez', 'Teotepeque', '2008-11-14', '2004-05-02', 'Maria');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('162', 'R. Oviedo', 'San Rafael', '2000-07-28', '2013-05-10', 'Marlene');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('163', 'D. Carrillo', 'Cuscatlan', '2006-07-09', '2011-01-14', 'Jacqueline');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('164', 'S. Henriquez', 'San Isidro Labrador', '2004-07-31', '2000-10-16', 'Lisbeth');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('165', 'D. Fernandez', 'Ahuachapan', '2006-11-30', '2007-06-15', 'Ana');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('166', 'F. Martínez', 'Santa Ana', '2004-12-21', '2003-03-22', 'Marlene');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('167', 'Q. Reyes', 'San Cayetano Istepeque', '2005-04-28', '2012-08-30', 'Carlos');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('168', 'E. Urbina', 'Cuscatlan', '2010-05-08', '2000-12-26', 'Rodolfo');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('169', 'P. Orantes', 'Candelaria', '2007-06-10', '2006-10-09', 'Nestor');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('170', 'P. Oviedo', 'Usulutan', '2005-10-17', '2013-04-12', 'Marlene');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('171', 'A. Rivera', 'Tejutla', '2001-08-03', '2003-08-23', 'Ingris');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('172', 'N. Reyes', 'San Salvador', '2010-07-06', '2011-11-08', 'Lisbeth');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('173', 'X. Garcia', 'Tepecoyo', '2001-04-23', '2000-07-04', 'Yamileth');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('174', 'X. Duarte', 'Usulutan', '2000-02-12', '2005-02-11', 'Denis');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('175', 'G. Cubas', 'Yoloaiquin', '2009-06-23', '2006-01-16', 'Marlene');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('176', 'T. Angel', 'San Buenaventura', '2001-08-02', '2010-06-15', 'Evelyn');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('177', 'C. Hernandez', 'Cuscatlan', '2013-12-16', '2001-06-13', 'Alexander');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('178', 'B. Colocho', 'San Fernando', '2012-07-09', '2000-01-15', 'Alfredo');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('179', 'J. Alegria', 'Cabañas', '2000-03-02', '2010-10-03', 'Marlene');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('180', 'V. Ortega', 'La Libertad', '2003-06-21', '2012-10-28', 'Douglas');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('181', 'D. Trinidad', 'Tecoluca', '2008-12-04', '2011-04-20', 'Evelyn');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('182', 'C. Lozano', 'Cabañas', '2013-12-16', '2009-03-21', 'Marlene');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('183', 'J. Castro', 'Santa Ana', '2011-10-23', '2003-08-04', 'Alejandro');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('184', 'U. Ortega', 'Usulutan', '2012-12-03', '2009-11-11', 'Marlene');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('185', 'C. Ponce', 'Sonsonate', '2002-09-13', '2008-12-14', 'Boris');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('186', 'Z. Cerritos', 'San Jose Villanueva', '2001-09-13', '2011-05-18', 'Daniel');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('187', 'G. Osorio', 'Nahuizalco', '2001-08-07', '2012-01-08', 'Evelyn');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('188', 'Q. Alvarenga', 'San Antonio Pajonal', '2001-10-24', '2004-07-03', 'Ana');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('189', 'X. Vasquez', 'Santa Rosa Guachipilin', '2009-09-27', '2006-12-28', 'Sandra');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('190', 'T. Cubas', 'Santa Ana', '2012-10-29', '2006-03-07', 'Anthony');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('191', 'A. Molina', 'Sonsonate', '2009-08-20', '2014-01-06', 'Jose');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('192', 'J. Quijada', 'San Miguel', '2010-01-05', '2005-11-25', 'Josue');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('193', 'P. Mejia', 'Santa Ana', '2003-08-04', '2005-03-19', 'Herbert');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('194', 'K. Ortega', 'La Union', '2009-07-09', '2006-11-14', 'Ingris');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('195', 'Q. Roscala', 'Ahuachapan', '2013-03-06', '2011-04-28', 'Lisbeth');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('196', 'Y. Tobar', 'Concepcion Batres', '2012-02-07', '2004-04-10', 'Xiomara');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('197', 'D. Mart?nez', 'San Antonio del Monte', '2013-09-02', '2002-06-02', 'Jenifer');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('198', 'Y. Lopez', 'Panchimalco', '2009-08-30', '2001-06-08', 'Marta');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('199', 'D. Mart?nez', 'El Carrizal', '2010-01-28', '2005-04-17', 'Nestor');
INSERT INTO tm_proyecto(codigo_proyecto, nombre_proyecto, descripcion_proyecto, inicio_proyecto, fin_proyecto, responsable_proyecto) VALUES('200', 'K. Guerrero', 'La Paz', '2011-03-03', '2001-02-12', 'Tatiana');
GO
--
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('201', 'T. Mendoza', 'Egypt', '129');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('203', 'I. Bonilla', '"Virgin Islands, U.S."', '195');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('204', 'N. Carrillo', 'Madagascar', '189');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('205', 'G. Mejia', 'Gabon', '188');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('206', 'W. Alas', 'South Georgia and The South Sandwich Islands', '199');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('207', 'G. Osorio', 'Andorra', '183');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('208', 'S. Gomez', 'Guinea-bissau', '148');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('209', 'C. Duarte', 'Suriname', '155');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('210', 'T. Avelar', 'Tunisia', '113');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('211', 'N. Aguilar', 'Malaysia', '180');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('212', 'T. Rafaelano', 'China', '167');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('213', 'G. Ortiz', 'Sudan', '132');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('214', 'L. Garc', 'Uzbekistan', '186');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('215', 'C. Alvarado', 'Luxembourg', '187');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('216', 'P. Hernandez', '"Virgin Islands, British"', '145');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('217', 'U. Rivas', 'French Guiana', '119');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('218', 'Z. Romero', '"Virgin Islands, U.S."', '119');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('219', 'B. Quijada', 'Vanuatu', '113');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('220', 'I. Flores', 'Qatar', '182');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('221', 'R. Ortiz', 'Denmark', '115');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('222', 'J. Molina', 'Venezuela', '111');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('223', 'J. Diaz', 'Thailand', '129');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('224', 'X. Guerrero', 'Jordan', '179');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('225', 'W. Diaz', 'Nicaragua', '120');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('226', 'Q. Martinez', 'Tuvalu', '162');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('227', 'Z. Henriquez', 'Equatorial Guinea', '164');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('228', 'H. Oviedo', 'Bulgaria', '135');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('229', 'L. Mejia', 'Lithuania', '135');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('230', 'S. Osorio', 'Svalbard and Jan Mayen', '173');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('231', 'Y. Gamez', 'Bouvet Island', '118');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('232', 'O. Cruz', 'Sierra Leone', '150');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('233', 'I. Mencos', 'Svalbard and Jan Mayen', '159');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('234', 'Q. Ayala', 'Rwanda', '143');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('235', 'H. Vasquez', 'Japan', '162');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('236', 'Q. Vasquez', 'Ireland', '125');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('237', 'O. Escobar', 'Norfolk Island', '192');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('238', 'K. Ortega', 'Myanmar', '172');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('239', 'Y. Fernandez', 'Denmark', '125');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('240', 'P. Urbina', 'Angola', '159');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('241', 'E. Ponce', 'Ukraine', '135');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('242', 'A. Lozano', 'Italy', '161');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('243', 'Y. Gomez', 'Libyan Arab Jamahiriya', '197');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('244', 'J. Brito', 'Mongolia', '153');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('245', 'C. Uceda', 'Palau', '187');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('246', 'L. Martinez', 'Denmark', '119');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('247', 'I. Carrillo', 'Cyprus', '179');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('248', 'Z. Marquez', 'Bouvet Island', '115');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('249', 'J. Rivas', 'Tokelau', '148');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('250', 'T. Quijada', 'Afghanistan', '117');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('251', 'A. Orellana', 'Ireland', '170');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('252', 'M. Cabrera', 'Netherlands Antilles', '118');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('253', 'Z. Guzman', 'Micronesia', '119');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('254', 'X. Duarte', 'Rwanda', '184');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('255', 'B. Sanchez', 'Belize', '171');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('256', 'U. Valle', 'Bermuda', '189');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('257', 'Y. Ponce', 'Reunion', '199');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('258', 'W. Valle', 'Jordan', '110');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('259', 'L. Reyes', 'Cyprus', '180');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('260', 'Y. Alegria', 'Mali', '120');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('261', 'G. Rafaelano', 'Grenada', '189');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('262', 'S. Sanchez', 'Brazil', '196');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('263', 'E. Hilario', 'Sri Lanka', '101');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('264', 'Y. Echeverria', 'United States Minor Outlying Islands', '111');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('265', 'X. Mencos', 'Jamaica', '188');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('266', 'K. Aguilar', 'San Marino', '141');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('267', 'G. Rodriguez', 'Turkey', '128');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('268', 'U. Quijada', 'Germany', '160');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('269', 'X. Alvarenga', 'Zambia', '196');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('270', 'X. Garc', 'Haiti', '145');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('271', 'Q. Urbina', 'Kazakhstan', '166');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('272', 'M. Lozano', 'Palau', '170');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('273', 'G. Diaz', 'Angola', '114');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('274', 'G. Uceda', 'Vanuatu', '109');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('275', 'K. Ponce', 'Kiribati', '114');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('276', 'A. Guzman', 'Yemen', '138');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('277', 'X. Castro', 'Macedonia', '141');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('278', 'M. Pacheco', 'Luxembourg', '132');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('279', 'N. Duran', 'United States', '171');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('280', 'K. Mencos', 'Estonia', '166');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('281', 'Y. Reyes', 'Latvia', '178');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('282', 'N. Pena', 'Antarctica', '115');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('283', 'Y. Martinez', 'Tokelau', '137');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('284', 'P. Urbina', 'Malawi', '153');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('285', 'I. Castro', 'Turkmenistan', '123');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('286', 'K. Valencia', 'Macedonia', '157');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('287', 'T. Lozano', 'French Polynesia', '112');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('288', 'R. Mart?nez', 'Saint Lucia', '102');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('289', 'A. Diaz', 'Somalia', '179');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('290', 'D. Gonzalez', '"Virgin Islands, U.S."', '158');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('291', 'W. Cerritos', 'Cocos (Keeling) Islands', '197');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('292', 'P. Flores', 'United States', '106');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('293', 'C. Alvarenga', 'Christmas Island', '143');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('294', 'S. Angel', 'Hungary', '119');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('295', 'J. Molina', 'Marshall Islands', '192');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('296', 'I. Gamez', 'Bermuda', '171');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('297', 'M. Mencos', 'Anguilla', '117');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('298', 'D. Urbina', 'Sierra Leone', '139');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('299', 'E. Pacheco', 'Guinea-bissau', '195');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('300', 'Y. Molina', 'Czech Republic', '196');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('301', 'F. Rafaelano', 'Gibraltar', '101');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('302', 'K. Alvarenga', 'Canada', '118');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('303', 'J. Mejia', 'Norway', '108');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('304', 'J. Angel', 'Germany', '180');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('305', 'I. Ponce', 'Bosnia and Herzegovina', '193');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('306', 'N. Garcia', 'Lesotho', '157');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('307', 'W. Brito', 'Ireland', '131');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('308', 'Q. Pena', 'Honduras', '124');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('309', 'T. Gutierrez', 'Guam', '195');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('310', 'M. Tobar', 'Seychelles', '155');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('311', 'S. Guerrero', 'Norfolk Island', '162');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('312', 'U. Novoa', 'Ireland', '127');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('313', 'N. Reyes', 'Bahrain', '107');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('314', 'H. Orellana', 'Austria', '113');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('315', 'X. Guerrero', 'Guadeloupe', '104');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('316', 'T. Perez', 'Israel', '189');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('317', 'Q. Trinidad', 'Egypt', '128');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('318', 'X. Ochoa', 'Finland', '130');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('319', 'L. Brito', 'Madagascar', '154');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('320', 'O. Ayala', 'Iceland', '110');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('321', 'C. Perez', 'Tunisia', '158');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('322', 'K. Rivera', 'Liechtenstein', '106');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('323', 'I. Mejia', 'Canada', '114');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('324', 'F. Ochoa', 'Greenland', '191');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('325', 'X. Echeverria', 'Anguilla', '197');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('326', 'T. Cubas', 'Palau', '142');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('327', 'O. Oviedo', 'Equatorial Guinea', '183');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('328', 'S. Guerrero', 'Ecuador', '132');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('329', 'B. Mejia', 'Nepal', '146');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('330', 'X. Sanchez', 'South Africa', '137');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('331', 'D. Molina', 'Sudan', '162');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('332', 'B. Guerrero', 'Brunei Darussalam', '132');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('333', 'O. Medrano', 'Palau', '105');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('334', 'Y. Pena', 'United Arab Emirates', '191');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('335', 'B. Cerritos', 'Thailand', '150');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('336', 'G. Morales', 'Wallis and Futuna', '191');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('337', 'J. Cubas', 'Comoros', '173');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('338', 'U. Rafaelano', 'American Samoa', '105');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('339', 'H. Lopez', 'Honduras', '147');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('340', 'H. Alvarenga', 'Sierra Leone', '109');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('341', 'O. Orellana', 'Colombia', '150');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('342', 'M. Beltran', 'Bahamas', '178');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('343', 'X. Mart?nez', 'Guinea-bissau', '154');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('344', 'E. Ortiz', 'Moldova', '187');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('345', 'C. Reyes', 'Norway', '136');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('346', 'B. Molina', 'Belgium', '111');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('347', 'W. Duarte', 'South Africa', '170');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('348', 'W. Mejia', 'Ghana', '124');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('349', 'Y. Orellana', 'Morocco', '132');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('350', 'L. Flores', 'Bangladesh', '103');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('351', 'D. Perez', 'Russian Federation', '196');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('352', 'L. Ochoa', 'Austria', '121');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('353', 'E. Cubas', 'Zimbabwe', '137');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('354', 'R. Duarte', 'Antarctica', '154');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('355', 'U. Uceda', 'Brazil', '131');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('356', 'W. Urbina', 'Saint Kitts and Nevis', '177');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('357', 'S. Medrano', '"Taiwan, Province of China"', '152');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('358', 'T. Guzman', 'Uzbekistan', '165');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('359', 'T. Rivera', '"Virgin Islands, U.S."', '175');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('360', 'C. Hilario', 'Iceland', '192');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('361', 'Q. Mejia', 'Congo', '176');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('362', 'R. Reyes', 'Swaziland', '135');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('363', 'C. Hernandez', 'French Guiana', '129');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('364', 'F. Contreras', 'Antigua and Barbuda', '167');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('365', 'W. Echeverria', 'American Samoa', '109');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('366', 'L. Gutierrez', 'Poland', '164');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('367', 'T. Rafaelano', 'Benin', '192');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('368', 'D. Castro', 'New Zealand', '101');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('369', 'L. Perez', 'Fiji', '152');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('370', 'B. Cruz', 'Malta', '153');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('371', 'T. Romero', 'Guadeloupe', '164');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('372', 'X. Gamez', 'Colombia', '195');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('373', 'K. Trinidad', 'Antigua and Barbuda', '104');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('374', 'N. Duarte', 'Greenland', '101');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('375', 'C. Ochoa', 'Belgium', '146');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('376', 'O. Perez', 'Romania', '148');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('377', 'R. Rafaelano', 'Ecuador', '165');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('378', 'U. Martinez', 'Bosnia and Herzegovina', '109');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('379', 'U. Calderon', 'Faroe Islands', '137');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('380', 'A. Garc', 'Denmark', '160');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('381', 'H. Gutierrez', 'United Arab Emirates', '136');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('382', 'Y. Aguilar', 'Swaziland', '176');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('383', 'V. Garc', 'Uruguay', '138');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('384', 'I. Colocho', 'Poland', '131');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('385', 'G. Perez', 'Belgium', '116');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('386', 'Y. Osorio', 'Mauritania', '102');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('387', 'F. Escobar', 'Belgium', '148');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('388', 'M. Diaz', 'Cambodia', '162');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('389', 'O. Quijada', 'Pitcairn', '106');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('390', 'T. Morales', 'Czech Republic', '188');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('391', 'Y. Valencia', 'Paraguay', '167');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('392', 'M. Mart?nez', 'Mauritania', '153');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('393', 'F. Mejia', 'Sierra Leone', '105');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('394', 'L. Perez', '"Tanzania, United Republic of"', '133');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('395', 'A. Flores', 'Samoa', '196');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('396', 'I. Alegria', 'United Kingdom', '103');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('397', 'F. Alvarado', 'Guadeloupe', '113');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('398', 'Y. Beltran', 'Lesotho', '137');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('399', 'L. Gutierrez', 'French Southern Territories', '134');
INSERT INTO tm_tarea( codigo_tarea, nombre_tarea, descripcion_tarea, codigo_proyecto) VALUES('400', 'A. Pena', 'Falkland Islands (Malvinas)', '112');
GO
--
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('201', '203', 'Jenifer', '1991-08-26');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('202', '321', 'Erika', '1982-09-04');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('203', '212', 'Erick', '1988-03-09');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('204', '271', 'Samus', '1989-08-08');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('205', '298', 'Ivonne', '1982-01-17');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('206', '294', 'Marta', '1987-09-18');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('207', '225', 'Daniel', '1992-08-05');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('208', '272', 'Yosely', '1991-06-29');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('209', '278', 'Erika', '1989-12-01');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('210', '201', 'Marta', '1991-12-19');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('211', '260', 'Ernesto', '1995-06-06');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('212', '272', 'Nestor', '1990-09-15');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('213', '395', 'Marta', '1981-09-24');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('214', '380', 'Titiushko', '1983-12-08');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('215', '326', 'Yosely', '1985-03-12');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('216', '220', 'Guillermo', '1980-12-11');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('217', '297', 'Rosa', '1985-10-28');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('218', '384', 'Alejandro', '1982-11-01');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('219', '252', 'Abigail', '1980-10-14');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('220', '366', 'Evelyn', '1984-04-01');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('221', '235', 'Jose', '1993-03-23');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('222', '361', 'Evelyn', '1982-03-16');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('223', '290', 'Guillermo', '1989-10-05');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('224', '361', 'Karen', '1980-08-18');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('225', '259', 'Isabel', '1988-07-02');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('226', '361', 'Tatiana', '1984-11-17');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('227', '288', 'Carlos', '1980-06-21');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('228', '354', 'Vladimir', '1983-06-19');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('229', '219', 'Isabel', '1987-11-15');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('230', '335', 'Elizabeth', '1992-06-08');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('231', '297', 'Marta', '1995-04-09');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('232', '396', 'Yamileth', '1985-05-09');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('233', '265', 'Ivette', '1983-08-15');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('234', '332', 'Carmen', '1980-04-25');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('235', '268', 'Carmen', '1987-01-31');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('236', '336', 'Hector', '1982-07-09');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('237', '247', 'Edgardo', '1991-03-06');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('238', '333', 'Rodolfo', '1986-10-08');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('239', '249', 'Rodolfo', '1981-07-29');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('240', '325', 'Tony', '1985-09-01');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('241', '215', 'Salvador', '1993-05-19');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('242', '397', 'Boris', '1989-02-17');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('243', '291', 'Lisbeth', '1983-10-12');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('244', '312', 'Iris', '1990-07-19');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('245', '219', 'Josue', '1986-12-05');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('246', '364', 'Samus', '1981-06-01');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('247', '244', 'Xiomara', '1989-04-15');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('248', '348', 'Jose', '1986-04-19');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('249', '209', 'Isabel', '1984-02-04');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('250', '355', 'Douglas', '1990-03-26');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('251', '258', 'Tatiana', '1988-10-25');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('252', '382', 'Yamileth', '1986-02-20');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('253', '235', 'Grissel', '1984-09-21');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('254', '320', 'Isabel', '1991-10-22');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('255', '283', 'Novoa', '1990-11-11');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('256', '364', 'Anthony', '1980-02-27');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('257', '246', 'Josue', '1985-12-25');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('258', '338', 'Manuel', '1983-02-24');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('259', '269', 'Elizabeth', '1987-07-23');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('260', '345', 'Herbert', '1982-12-28');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('261', '294', 'Manuel', '1986-05-19');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('262', '369', 'Maria', '1994-04-29');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('263', '266', 'Daniel', '1989-06-12');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('264', '374', 'Melissa', '1981-02-06');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('265', '228', 'Boris', '1981-11-21');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('266', '354', 'Lisbeth', '1982-05-12');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('267', '223', 'Sandra', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('268', '302', 'Jimmy', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('269', '297', 'Hector', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('270', '312', 'Marvin', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('271', '292', 'Rosa', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('272', '378', 'Novoa', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('273', '252', 'Alejandra', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('274', '393', 'Karen', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('275', '222', 'Elizabeth', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('276', '352', 'Titiushko', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('277', '244', 'Novoa', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('278', '348', 'Francisco', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('279', '262', 'Carmen', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('280', '375', 'Erick', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('281', '221', 'Erick', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('282', '327', 'Nestor', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('283', '264', 'Novoa', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('284', '397', 'Novoa', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('285', '234', 'Ana', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('286', '379', 'Sandra', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('287', '276', 'Carlos', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('288', '367', 'Ivonne', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('289', '233', 'Beatriz', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('290', '354', 'Erika', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('291', '250', 'Titiushko', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('292', '335', 'Melissa', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('293', '269', 'Anthony', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('294', '333', 'Douglas', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('295', '234', 'Ana', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('296', '352', 'Ingris', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('297', '290', 'Erick', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('298', '375', 'Iris', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('299', '279', 'Beatriz', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('300', '367', 'Titiushko', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('301', '247', 'Vladimir', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('302', '321', 'Francisco', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('303', '235', 'Xiomara', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('304', '331', 'Lisbeth', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('306', '390', 'Claudia', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('307', '253', 'Alexander', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('308', '393', 'Jose', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('309', '268', 'Elizabeth', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('310', '332', 'Novoa', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('311', '281', 'Anthony', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('312', '303', 'Maria', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('313', '233', 'Edwin', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('314', '398', 'Jimmy', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('315', '270', 'Novoa', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('316', '312', 'Alexander', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('317', '234', 'Beatriz', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('318', '338', 'Alexander', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('319', '270', 'Garcia', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('320', '369', 'Abigail', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('321', '221', 'Alejandro', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('322', '331', 'Claudia', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('323', '231', 'Denis', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('324', '325', 'Jimmy', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('325', '243', 'Iris', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('326', '337', 'Alexander', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('328', '329', 'Herbert', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('329', '252', 'Ernesto', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('330', '397', 'Edenilson', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('331', '235', 'Sanchez', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('332', '332', 'Anthony', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('333', '296', 'Xiomara', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('334', '330', 'Ingris', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('335', '279', 'Zelda', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('336', '383', 'Josue', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('337', '227', 'Alejandra', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('338', '386', 'Isabel', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('339', '283', 'Tatiana', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('340', '333', 'Tatiana', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('341', '293', 'Isabel', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('342', '316', 'Rodolfo', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('343', '299', 'Lisbeth', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('344', '231', 'Grissel', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('345', '245', 'Josue', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('346', '370', 'Rodolfo', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('347', '276', 'Sanchez', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('348', '327', 'Marlene', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('349', '234', 'Emperatriz', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('350', '397', 'Marta', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('351', '263', 'Francisco', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('352', '372', 'Tatiana', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('353', '228', 'Jazmin', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('354', '347', 'Beatriz', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('355', '211', 'Beatriz', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('356', '315', 'Anthony', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('357', '218', 'Samus', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('358', '371', 'Rodolfo', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('359', '271', 'Boris', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('360', '337', 'Vladimir', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('361', '214', 'Edwin', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('362', '318', 'Melissa', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('363', '291', 'Evelyn', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('364', '397', 'Claudia', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('365', '246', 'Elizabeth', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('366', '339', 'Jose', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('367', '222', 'Sandra', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('368', '336', 'Ana', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('369', '264', 'Tony', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('370', '383', 'Salvador', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('371', '214', 'Alejandra', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('372', '373', 'Rosa', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('373', '218', 'Grissel', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('374', '230', 'Carlos', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('375', '217', 'Sandra', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('376', '359', 'Salvador', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('377', '257', 'Marvin', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('378', '341', 'Abigail', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('379', '281', 'Tony', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('381', '233', 'Abigail', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('382', '356', 'Jacqueline', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('383', '256', 'Jacqueline', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('384', '375', 'Edenilson', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('385', '295', 'Guillermo', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('386', '394', 'Guillermo', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('388', '326', 'Vladimir', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('389', '292', 'Abigail', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('390', '325', 'Alejandro', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('391', '239', 'Josue', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('392', '385', 'Erick', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('393', '276', 'Ernesto', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('394', '340', 'Ernesto', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('395', '247', 'Beatriz', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('396', '363', 'Zelda', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('397', '295', 'Herbert', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('398', '348', 'Yamileth', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('399', '266', 'Guillermo', '');
INSERT INTO tm_responsable(codigo_responsable, codigo_tarea, codigo_usuario, fecha_responsable) VALUES('400', '389', 'Melissa', '');
GO
--
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Abigail', 'Henry Ernesto', 'Medrano Romero', '1991-08-26', '85011');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Alejandra', 'Jose Anthony', 'Bonilla Cerritos', '1982-09-04', '67826');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Alejandro', 'Ricardo Roxana', 'Carranza Orantes', '1988-03-09', 'U5M 2Q6');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Alexander', 'Jenifer Rolando', 'Gutierrez Escobar', '1989-08-08', '28285');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Alfredo', 'Sandra Karen', 'Hernandez Cerritos', '1982-01-17', '7692');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Ana', 'Rosa Manuel', 'Brito Duarte', '1987-09-18', 'I8P 2B4');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Anthony', 'Armando Orellana', 'Marquez Osorio', '1992-08-05', '6779');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Beatriz', 'Nestor Henry', 'Rodriguez Rivas', '1991-06-29', 'N3M 2O4');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Boris', 'Giovanni Oscar', 'Rivas Rodriguez', '1989-12-01', 'P6L 3Q0');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Carlos', 'Josue Marlene', 'Brito Valencia', '1991-12-19', 'L1M 9V9');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Carmen', 'Marvin Claudia', 'Valencia Gamez', '1995-06-06', '19087');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Claudia', 'Luis Francisco', 'Garcia Valencia', '1990-09-15', '54502');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Daniel', 'Hilario Ivette', 'Cruz Angel', '1981-09-24', 'K5G 4I2');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Denis', 'Yosely Ana', 'Fernandez Gonzalez', '1983-12-08', '41340');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Douglas', 'Xiomara Jesus', 'Portillo Ortiz', '1985-03-12', 'Y6A 1Q6');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Edenilson', 'Miguel Jazmin', 'Trinidad Castro', '1980-12-11', 'J7R 5S1');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Edgardo', 'Maria Hector', 'Colocho Guerrero', '1985-10-28', 'F4L 1Z7');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Edwin', 'Grissel Marvin', 'Cerritos Mencos', '1982-11-01', '9677');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Elizabeth', 'Carmen Hector', 'Gomez Rafaelano', '1980-10-14', 'J3W 5O1');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Emperatriz', 'Nestor Douglas', 'Gamez Cabrera', '1984-04-01', '27813');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Erick', 'Guadalupe Yamileth', 'Marquez Alvarenga', '1993-03-23', '15668');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Erika', 'Kevin Garcia', 'Vega Angel', '1982-03-16', '76574');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Ernesto', 'Lisbeth Carmen', 'Duran Henriquez', '1989-10-05', '36584');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Evelyn', 'Jesus Claudia', 'Mencos Mejia', '1980-08-18', 'D5T 5N3');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Francisco', 'Claudia Romeo', 'Lozano Rivera', '1988-07-02', '35128');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Garcia', 'Tony Alejandro', 'Ochoa Lopez', '1984-11-17', '67847');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Grissel', 'Ernesto Johanna', 'Orellana Pacheco', '1980-06-21', '1708');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Guillermo', 'Isabel Alicia', 'Sanchez Ayala', '1983-06-19', 'E3C 5L5');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Hector', 'Christian Xiomara', 'Castro Lopez', '1987-11-15', 'S6F 5H1');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Herbert', 'Ernesto Elmer', 'Escobar Duarte', '1992-06-08', 'Y5U 5E6');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Ingris', 'Willian Ingris', 'Pena Alvarado', '1995-04-09', '6631');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Iris', 'Roxana Marlene', 'Cornejo Tobar', '1985-05-09', '70668');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Isabel', 'Boris Marta', 'Romero Reyes', '1983-08-15', '35230');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Samus', 'Willian Romeo', 'Guzman Contreras', '1980-04-25', '12011');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Zelda', 'Ivan Claudia', 'Uceda Galdamez', '1987-01-31', 'H6C 1W4');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Ivette', 'Lisandro Roxana', 'Ponce Diaz', '1982-07-09', 'O6M 9K4');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Ivonne', 'Edwin Alfredo', 'Diaz Vega', '1991-03-06', '22651');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Jacqueline', 'Miguel Abigail', 'Portillo Mejia', '1986-10-08', '18739');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Jazmin', 'Jesus Evelyn', 'Carranza Rodriguez', '1981-07-29', 'D8V 3B2');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Jenifer', 'Jenifer Antonio', 'Gamez Rafaelano', '1985-09-01', '77161');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Jimmy', 'Yamileth Jose', 'Ortiz Contreras', '1993-05-19', 'X8U 5M7');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Jose', 'Grissel Daniel', 'Rafaelano Roscala', '1989-02-17', 'H3L 8M6');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Josue', 'Garcia Rolando', 'Garcia Lopez', '1983-10-12', 'S1F 4T4');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Karen', 'Erick Edenilson', 'Lopez Osorio', '1990-07-19', 'P5S 5F8');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Kevin', 'Tony Marvin', 'Ayala Flores', '1986-12-05', '88891');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Lisbeth', 'Katya Tony', 'Brito Gomez', '1981-06-01', 'K6P 7O4');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Manuel', 'Lisandro Tony', 'Quijada Novoa', '1989-04-15', 'J1S 6A1');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Maria', 'Ingris Garcia', 'Cabrera Alegria', '1986-04-19', 'O7G 5M2');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Marlene', 'Yamileth Yosely', 'Ortiz Galdamez', '1984-02-04', '35960');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Marta', 'Henry Edenilson', 'Rafaelano Valencia', '1990-03-26', 'X7D 1K7');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Marvin', 'Abigail Ivette', 'Gutierrez Carranza', '1988-10-25', 'I1P 2M0');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Melissa', 'Carmen Tatiana', 'Orellana Duarte', '1986-02-20', 'M2G 1A2');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Nestor', 'Saul Herbert', 'Ponce Castro', '1984-09-21', 'X2J 9E7');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Novoa', 'Yamileth Gerardo', 'Carrillo Alegria', '1991-10-22', '17665');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Rodolfo', 'Alicia Alexander', 'Valle Urbina', '1990-11-11', '40678');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Rosa', 'Francisco Iliana', 'Vasquez Roscala', '1980-02-27', '20394');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Salvador', 'Maria Alejandra', 'Oviedo Rivas', '1985-12-25', '12817');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Sanchez', 'Gerardo Cecilia', 'Oviedo Rodriguez', '1983-02-24', 'C6A 2Q1');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Sandra', 'Tatiana Garcia', 'Beltran Guerrero', '1987-07-23', '81055');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Tatiana', 'Jenifer Ricardo', 'Oviedo Portillo', '1982-12-28', 'C5O 4K9');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Titiushko', 'Tito Javier', 'Miguel Galdamez', '1986-05-19', 'tito');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Tony', 'Lisandro Alicia', 'Valencia Pacheco', '1994-04-29', '35251');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Vladimir', 'Isabel Jimmy', 'Martinez Ponce', '1989-06-12', '20127');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Xiomara', 'Johanna Jose', 'Mendoza Valle', '1981-02-06', 'Q7Z 7Y6');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Yamileth', 'Jairo Claudia', 'Sorto Uceda', '1981-11-21', '36350');
INSERT INTO tm_usuario(codigo_usuario, nombres_usuario, apellidos_usuario, nacimiento_usuario, password_usuario) VALUES('Yosely', 'Omar Johanna', 'Cabrera Hernandez', '1982-05-12', 'F1V 6H8');
GO
-- ----------------------------------------------------------------------------
ALTER TABLE tm_proyecto ADD CONSTRAINT tm_proyecto_tm_usuario FOREIGN KEY(responsable_proyecto)
REFERENCES tm_usuario(codigo_usuario)
GO
--
ALTER TABLE tm_responsable ADD CONSTRAINT tm_responsable_tm_tarea FOREIGN KEY(codigo_tarea)
REFERENCES tm_tarea(codigo_tarea)
GO
--
ALTER TABLE tm_responsable ADD CONSTRAINT tm_responsable_tm_usuario FOREIGN KEY(codigo_usuario)
REFERENCES tm_usuario(codigo_usuario)
GO
--
ALTER TABLE tm_tarea ADD CONSTRAINT tm_tarea_tm_proyecto FOREIGN KEY(codigo_proyecto)
REFERENCES tm_proyecto(codigo_proyecto)
GO
-- ----------------------------------------------------------------------------
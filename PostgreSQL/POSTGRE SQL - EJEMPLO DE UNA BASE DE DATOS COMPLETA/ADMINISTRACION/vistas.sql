-- Structure for table requisito_consejo 
CREATE TABLE requisito_consejo (
    correlativo integer NOT NULL,
    id_coordinador integer NOT NULL,
    titulo integer DEFAULT 0 NOT NULL,
    carta_aprobacion integer DEFAULT 0 NOT NULL,
    partida_nacimiento integer DEFAULT 0 NOT NULL,
    referencia integer DEFAULT 0 NOT NULL,
    fecha_recepcion date NOT NULL,
	CONSTRAINT pk_requisito_consejo PRIMARY KEY (correlativo),
	CONSTRAINT fk_debe_cumplir FOREIGN KEY (correlativo)
		REFERENCES solicitudes_recibidas(correlativo) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_establece FOREIGN KEY (id_coordinador)
		REFERENCES consejo_becas(id_coordinador) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE
) WITHOUT OIDS;

-- ******* VIEWS *******

-- Definition for view Becas_nueva
CREATE VIEW Becas_nueva AS
SELECT beca.estado, beca.nombre_beca, beca.tipo_beca,
    area_interes.nombre_area, beca.id_beca
FROM (beca JOIN area_interes ON (((beca.id_area)::text =
    (area_interes.id_area)::text)))
WHERE (beca.estado = 1);

-- Definition for view ver_oferta
CREATE VIEW ver_oferta AS
SELECT area_interes.nombre_area, beca.nombre_beca, beca.befecha_inicio,
    beca.tipo_beca, beca.descripcion, beca.area_aplicacion,
    beca.fecha_ingreso, fuente_cooperacion.nombre_fuente,
    institucion.nombre_institucion, requisito_beca.idioma_beca,
    requisito_beca.cupo, requisito_beca.nivel_experiencia,
    requisito_beca.edad_beca, requisito_beca.nivel_idioma_requerido, beca.id_beca
FROM (((((institucion JOIN beca ON ((institucion.id_institucion =
    beca.id_institucion))) JOIN fuente_cooperacion ON
    ((institucion.id_fuente = fuente_cooperacion.id_fuente))) JOIN
    area_interes ON (((beca.id_area)::text =
    (area_interes.id_area)::text))) CROSS JOIN requisito_beca) CROSS JOIN
    tipoaspirante);

-- Definition for view ver_solicitud
CREATE VIEW ver_solicitud AS
SELECT aspirante.apellido1, aspirante.apellido2, aspirante.apellido_casada,
    aspirante.primer_nombre, aspirante.segundo_nombre, aspirante.dui,
    aspirante.correo_electronico, aspirante.sexo, beca.nombre_beca,
    beca.befecha_inicio, detalle_aspirante.edad, detalle_aspirante.idioma,
    detalle_aspirante.nivel_idioma, detalle_aspirante.otro_idioma,
    detalle_aspirante.otro_nivel_idioma, detalle_aspirante.investigaciones,
    requisito_beca.edad_beca, requisito_beca.nivel_experiencia,
    requisito_beca.cupo, requisito_beca.idioma_beca,
    requisito_beca.nivel_idioma_requerido, solicitudes_recibidas.id_aspirante
FROM ((((aspirante JOIN detalle_aspirante ON
    (((aspirante.id_aspirante)::text =
    (detalle_aspirante.id_aspirante)::text))) JOIN solicitudes_recibidas ON
    (((aspirante.id_aspirante)::text =
    (solicitudes_recibidas.id_aspirante)::text))) JOIN beca ON
    ((solicitudes_recibidas.id_beca = beca.id_beca))) JOIN requisito_beca
    ON ((beca.id_beca = requisito_beca.id_beca)));

-- Definition for view cambio_candidato
CREATE VIEW cambio_candidato AS
SELECT beca.nombre_beca, beca.befecha_inicio, candidato.carta_facultad,
    facultad.nombre_facultad, aspirante.apellido1, aspirante.apellido2,
    aspirante.apellido_casada, aspirante.primer_nombre,
    aspirante.segundo_nombre, candidato.id_candidato, aspirante.dui,
    aspirante.lugar_nacimiento, aspirante.domicilio,
    aspirante.correo_electronico, aspirante.estado_civil, aspirante.sexo,
    solicitudes_recibidas.correlativo
FROM ((((candidato JOIN aspirante ON (((candidato.id_candidato)::text =
    (aspirante.id_aspirante)::text))) JOIN facultad ON
    ((aspirante.id_facultad = facultad.id_facultad))) JOIN
    solicitudes_recibidas ON (((aspirante.id_aspirante)::text =
    (solicitudes_recibidas.id_aspirante)::text))) JOIN beca ON
    ((solicitudes_recibidas.id_beca = beca.id_beca)))
WHERE (candidato.estado = 0);

-- Definition for view expediente
CREATE VIEW expediente AS
SELECT bc.id_becario AS id, (((((((aspirante.primer_nombre)::text ||
    ' '::text) || (aspirante.segundo_nombre)::text) || ' '::text) ||
    (aspirante.apellido1)::text) || ' '::text) ||
    (aspirante.apellido2)::text) AS nombre, be.nombre_beca AS beca,
    i.nombre_institucion AS institucion, p.nombre_pais AS pais,
    eb.descripcion AS estado, bc.costo_beca AS costo, bc.fecha_creacion_exp
    AS fecha_creacion
FROM (((((becario bc JOIN aspirante ON (((aspirante.id_aspirante)::text =
    (bc.id_becario)::text))) JOIN beca be ON ((be.id_beca = bc.id_beca)))
    JOIN institucion i ON ((i.id_institucion = be.id_institucion))) JOIN
    pais p ON ((p.id_pais = i.id_pais))) JOIN estado_becario eb ON
    ((eb.estado = bc.estado)));

-- Definition for view solicitudes
CREATE VIEW solicitudes AS
SELECT aspirante.id_aspirante, aspirante.apellido1, aspirante.apellido2,
    aspirante.apellido_casada, aspirante.primer_nombre,
    aspirante.segundo_nombre, beca.nombre_beca, area_interes.nombre_area,
    aspirante.id_tipoaspirante, solicitudes_recibidas.estado,
    solicitudes_recibidas.cumplimiento
FROM (((aspirante JOIN solicitudes_recibidas ON
    (((aspirante.id_aspirante)::text =
    (solicitudes_recibidas.id_aspirante)::text))) JOIN beca ON
    ((solicitudes_recibidas.id_beca = beca.id_beca))) JOIN area_interes ON
    (((beca.id_area)::text = (area_interes.id_area)::text)))
WHERE (solicitudes_recibidas.estado = 0);
-- Structure for table area_interes 
CREATE TABLE area_interes (
    id_area character varying(2) NOT NULL,
    nombre_area character varying(50) NOT NULL,
	CONSTRAINT pk_area_interes PRIMARY KEY (id_area)
) WITHOUT OIDS;

-- Structure for table IDentificador 
CREATE TABLE identificador (
    id_asp character varying(7)
)  WITHOUT OIDS;

-- Structure for table consejo_becas 
CREATE TABLE consejo_becas (
    id_coordinador serial NOT NULL,
    coordinador_actual character varying(100) NOT NULL,
    correo character varying(50) NOT NULL,
	CONSTRAINT pk_consejo_becas PRIMARY KEY (id_coordinador)
) WITHOUT OIDS;

-- Structure for table depto 
CREATE TABLE depto (
    id_depto serial NOT NULL,
    nom_depto character varying(50) NOT NULL,
	CONSTRAINT pk_depto PRIMARY KEY (id_depto)
) WITHOUT OIDS;

-- Structure for table estado_becario
CREATE TABLE estado_becario (
    estado integer NOT NULL,
    descripcion character varying(100) NOT NULL,
	CONSTRAINT pk_estado_becario PRIMARY KEY (estado)
) WITHOUT OIDS;

-- Structure for table facultad 
CREATE TABLE facultad (
    id_facultad integer NOT NULL,
    nombre_facultad character varying(100) NOT NULL,
	CONSTRAINT pk_facultad PRIMARY KEY (id_facultad)
) WITHOUT OIDS;

-- Structure for table municipio 
CREATE TABLE municipio (
    id_depto serial NOT NULL,
    id_municipio integer NOT NULL,
    nom_municipio character varying(100) NOT NULL,
	CONSTRAINT pk_municipio PRIMARY KEY (id_depto, id_municipio),
	CONSTRAINT fk_pertenece FOREIGN KEY (id_depto)
		REFERENCES depto(id_depto) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
) WITHOUT OIDS;

-- Structure for table pais 
CREATE TABLE pais (
    id_pais serial NOT NULL,
    nombre_pais character varying(100) NOT NULL,
	CONSTRAINT pk_pais PRIMARY KEY (id_pais)
) WITHOUT OIDS;

-- Structure for table tipoaspirante
CREATE TABLE tipoaspirante (
    id_tipoaspirante serial NOT NULL,
    nombre_tipoaspirante character varying(20) NOT NULL,
	CONSTRAINT pk_tipoaspirante PRIMARY KEY (id_tipoaspirante)
) WITHOUT OIDS;

-- Structure for table titulos 
CREATE TABLE titulos (
    id_titulo serial NOT NULL,
    nombre_titulo character varying(100) NOT NULL,
	CONSTRAINT pk_titulos PRIMARY KEY (id_titulo)
) WITHOUT OIDS;

-- Structure for table interesado  
CREATE TABLE interesado (
    id_interesado serial NOT NULL,
    correo_interesado character varying(100) NOT NULL,
	CONSTRAINT pk_interesado PRIMARY KEY (id_interesado),
	CONSTRAINT correo_interesado_unique UNIQUE (correo_interesado)
) WITHOUT OIDS;

-- Structure for table aspirante 
CREATE TABLE aspirante (
    id_aspirante character varying(7) NOT NULL,
    id_tipoaspirante integer NOT NULL,
    id_interesado integer NOT NULL,
    id_depto integer NOT NULL,
    id_municipio integer NOT NULL,
    id_facultad integer NOT NULL,
    apellido1 character varying(25) NOT NULL,
    apellido2 character varying(25) NULL,
    apellido_casada character varying(25) NULL,
    primer_nombre character varying(25) NOT NULL,
    segundo_nombre character varying(25) NULL,
    fecha_nacimiento date NOT NULL,
    dui character varying(9) NOT NULL,
    lugar_nacimiento character varying(100) NOT NULL,
    domicilio character varying(200) NOT NULL,
    correo_electronico character varying(50) NOT NULL,
    estado_civil character varying(15) NOT NULL,
    sexo character varying(1) NOT NULL,
    estado integer DEFAULT 0,
	CONSTRAINT pk_aspirante PRIMARY KEY (id_aspirante),
	CONSTRAINT fk_tipoaspirante FOREIGN KEY (id_tipoaspirante) 
		REFERENCES tipoaspirante (id_tipoaspirante) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT fk_ingresa_en FOREIGN KEY (id_interesado)
		REFERENCES interesado(id_interesado) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT fk_pertenece_a FOREIGN KEY (id_facultad)
		REFERENCES facultad(id_facultad) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT fk_vive FOREIGN KEY (id_depto, id_municipio)
		REFERENCES municipio(id_depto, id_municipio) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
) WITHOUT OIDS;

-- Structure for table administrativo
CREATE TABLE administrativo (
    id_admin character varying(7) NOT NULL,
    id_tipoaspirante integer DEFAULT 3,
    inicio_servicio_adm date NOT NULL,
    prom_salario_adm money NOT NULL,
    cargo_admin character varying(100) NOT NULL,
    tel_oficina character varying(8),
    titulo integer,
	CONSTRAINT pk_administrativo PRIMARY KEY (id_admin),
	CONSTRAINT fk_tipo_aspirante3 FOREIGN KEY(id_admin)
		REFERENCES aspirante(id_aspirante) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT fk_titulo_admin FOREIGN KEY (titulo)
		REFERENCES titulos (id_titulo) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
) WITHOUT OIDS;

-- Structure for table areas_interesado
CREATE TABLE areas_interesado (
    id_interesado integer NOT NULL,
    id_area character varying(2) NOT NULL,
	CONSTRAINT pk_areas_interesado PRIMARY KEY (id_interesado, id_area),
    CONSTRAINT fk_dentro_de FOREIGN KEY (id_area)
		REFERENCES area_interes(id_area) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT fk_elige FOREIGN KEY (id_interesado)
		REFERENCES interesado(id_interesado) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
) WITHOUT OIDS;


-- Structure for table comision_facultad
CREATE TABLE comision_facultad (
    id_comision character varying(4) NOT NULL,
    id_facultad integer NOT NULL,
    nombre_comision character varying(100),
    correo character varying(50),
	CONSTRAINT pk_comision_facultad PRIMARY KEY (id_comision),
	CONSTRAINT fk_posee FOREIGN KEY (id_facultad)
		REFERENCES facultad(id_facultad) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
) WITHOUT OIDS;

-- Structure for table fuente_cooperacion 
CREATE TABLE fuente_cooperacion (
    id_fuente serial NOT NULL,
    id_pais integer NOT NULL,
    nombre_fuente character varying(100) NOT NULL,
	CONSTRAINT pk_fuente_cooperacion PRIMARY KEY (id_fuente),
	CONSTRAINT fk_es_de FOREIGN KEY (id_pais)
		REFERENCES pais(id_pais) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
) WITHOUT OIDS;

-- Structure for table institucion  
CREATE TABLE institucion (
    id_institucion serial NOT NULL,
    id_pais integer,
    id_fuente integer,
    nombre_institucion character varying(100),
	CONSTRAINT pk_institucion PRIMARY KEY (id_institucion),
	CONSTRAINT fk_pertenece_ FOREIGN KEY (id_pais)
		REFERENCES pais(id_pais) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT fk_tiene__ FOREIGN KEY (id_fuente)
		REFERENCES fuente_cooperacion(id_fuente) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
) WITHOUT OIDS;


-- Structure for table bec
CREATE TABLE beca (
    id_beca serial NOT NULL,
    id_institucion integer NOT NULL,
    id_coordinador integer NOT NULL,
    id_area character varying(2) NOT NULL,
    nombre_beca character varying(100) NOT NULL,
    befecha_inicio date NOT NULL,
    befecha_fin date,
    tipo_beca integer NOT NULL,
    descripcion character varying(200),
    area_aplicacion character varying(50) NOT NULL,
    fecha_ingreso date NOT NULL,
    estado integer DEFAULT 1 NOT NULL,
	CONSTRAINT pk_beca PRIMARY KEY (id_beca),
	CONSTRAINT fk_area_beca FOREIGN KEY (id_area)
		REFERENCES area_interes(id_area) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT fk_impartida FOREIGN KEY (id_institucion)
		REFERENCES institucion(id_institucion) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT fk_registra FOREIGN KEY (id_coordinador)
		REFERENCES consejo_becas(id_coordinador) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
	
) WITHOUT OIDS;

-- Structure for table candidato
CREATE TABLE candidato (
    id_candidato character varying(7) NOT NULL,
    id_comision character varying(4),
    carta_facultad integer DEFAULT 0,
    estado integer DEFAULT 0,
	CONSTRAINT pk_candidato PRIMARY KEY (id_candidato),
	CONSTRAINT fk_pasa FOREIGN KEY (id_candidato)
		REFERENCES aspirante(id_aspirante) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT fk_selecciona FOREIGN KEY (id_comision)
		REFERENCES comision_facultad(id_comision) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
) WITHOUT OIDS;

-- Structure for table becario
CREATE TABLE becario (
    id_becario character varying(7) NOT NULL,
    id_coordinador integer NOT NULL,
    id_beca integer NOT NULL,
    estado integer NOT NULL,
    fecha_creacion_exp date NOT NULL,
    costo_beca money NOT NULL,
    fecha_cierre_exp date,
	CONSTRAINT pk_becario PRIMARY KEY (id_becario),
	CONSTRAINT fk_autoriza FOREIGN KEY (id_coordinador)
		REFERENCES consejo_becas(id_coordinador) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT fk_cambia FOREIGN KEY (id_becario)
		REFERENCES candidato(id_candidato) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT fk_cursa FOREIGN KEY (id_beca)
		REFERENCES beca(id_beca) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT fk_status FOREIGN KEY (estado)
		REFERENCES estado_becario(estado) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
) WITHOUT OIDS;

-- Structure for table carreras
CREATE TABLE carreras (
    id_facultad integer NOT NULL,
    id_carrera integer NOT NULL,
    nombre_carrera character varying(100) NOT NULL,
	CONSTRAINT pk_carreras PRIMARY KEY (id_carrera),
	CONSTRAINT fk_facultad_carrera FOREIGN KEY (id_facultad)
		REFERENCES facultad(id_facultad) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
) WITHOUT OIDS;

-- Structure for table detalle_aspirante 
CREATE TABLE detalle_aspirante (
    correlativo serial NOT NULL,
    id_aspirante character varying(7) NOT NULL,
    id_comision character varying(4) NOT NULL,
    edad integer NOT NULL,
    idioma character varying(10) NOT NULL,
    nivel_idioma character varying(15) NOT NULL,
    otro_idioma character varying(15),
    otro_nivel_idioma character varying(15),
    investigaciones character varying(150),
    cumplimiento character varying(100),
	CONSTRAINT pk_detalle_aspirante PRIMARY KEY (correlativo),
	CONSTRAINT fk_ingresa FOREIGN KEY (id_aspirante)
		REFERENCES aspirante(id_aspirante) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT fk_verifica FOREIGN KEY (id_comision)
		REFERENCES comision_facultad(id_comision) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
) WITHOUT OIDS;

-- Structure for table docente
CREATE TABLE docente (
    id_docente character varying(7) NOT NULL,
    id_tipoaspirante integer DEFAULT 2,
    inicio_servicio_doc date NOT NULL,
    escuela character varying(100),
    prom_salario_docente money NOT NULL,
    titulo integer,
	CONSTRAINT pk_docente PRIMARY KEY (id_docente),
	CONSTRAINT fk_tipo_aspirante FOREIGN KEY(id_docente)
		REFERENCES aspirante (id_aspirante) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT fk_titulo_docente FOREIGN KEY (titulo)
		REFERENCES titulos(id_titulo) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
) WITHOUT OIDS;

-- Structure for table estudiante
CREATE TABLE estudiante (
    id_Estudiante character varying(7) NOT NULL,
    id_tipoaspirante integer DEFAULT 1,
    carnet character varying(7) NOT NULL,
    carrera_cursada integer NOT NULL,
    cum real NOT NULL,
    anio_fin_carrera character varying(4) NOT NULL,
    cuota_mensualidad money,
	CONSTRAINT pk_estudiante PRIMARY KEY (id_Estudiante, carnet),
	CONSTRAINT fk_tipo_aspirante2 FOREIGN KEY(id_Estudiante)
		REFERENCES aspirante (id_aspirante) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT fk_estudio FOREIGN KEY (carrera_cursada)
		REFERENCES carreras(id_carrera) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
) WITHOUT OIDS;

-- Structure for table historial
CREATE TABLE historial (
    id_aspirante character varying(7) NOT NULL,
    becas_anteriores character varying(100),
    fecha_fin date,
	CONSTRAINT pk_historial PRIMARY KEY (id_aspirante),
	CONSTRAINT fk_tiene FOREIGN KEY (id_aspirante)
		REFERENCES aspirante(id_aspirante) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
) WITHOUT OIDS;

-- Structure for table informe 
CREATE TABLE informe (
    id_becario character varying(7) NOT NULL,
    modulo integer NOT NULL,
    nombre_informe character varying(100),
    fecha_envio date,
	CONSTRAINT pk_informe PRIMARY KEY (id_becario, modulo),
	CONSTRAINT fk_enviar FOREIGN KEY (id_becario)
		REFERENCES becario(id_becario) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
) WITHOUT OIDS;

-- Structure for table requisito_beca 
CREATE TABLE requisito_beca (
    correlativo serial NOT NULL,
    id_beca integer NOT NULL,
    edad_beca integer NOT NULL,
    nivel_experiencia integer DEFAULT 0,
    cupo integer,
    idioma_beca character varying(30),
    nivel_idioma_requerido character varying(15),
	CONSTRAINT pk_requisito_beca PRIMARY KEY (correlativo),
	CONSTRAINT fk_contiene FOREIGN KEY (id_beca)
		REFERENCES beca(id_beca) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
) WITHOUT OIDS;

-- Structure for table solicitudes_recibidas
CREATE TABLE solicitudes_recibidas (
    correlativo serial NOT NULL,
    id_beca integer NOT NULL,
    id_aspirante character varying(7) NOT NULL,
    id_comision character varying(4) NOT NULL,
    cumplimiento character varying(100),
    estado integer DEFAULT 0,
	CONSTRAINT pk_solicitudes_recibidas PRIMARY KEY (correlativo),
	CONSTRAINT fk_recepcion_aspirante FOREIGN KEY (id_aspirante)
		REFERENCES aspirante(id_aspirante) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT fk_recepcion_beca FOREIGN KEY (id_beca)
		REFERENCES beca(id_beca) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT fk_recepcion_comision FOREIGN KEY (id_comision)
		REFERENCES comision_facultad(id_comision) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
) WITHOUT OIDS;

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
		REFERENCES solicitudes_recibidas(correlativo) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT fk_establece FOREIGN KEY (id_coordinador)
		REFERENCES consejo_becas(id_coordinador) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
) WITHOUT OIDS;
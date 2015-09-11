-- ******* TRIGGERS *******

-- cambio de estado aspirante a candidato
CREATE OR REPLACE FUNCTION aspirante2candidato()
  RETURNS trigger AS
$BODY$
DECLARE
_aspirante varchar(10);
_facultad int;
_estado integer;
_query text;
_comision varchar(100);

BEGIN
		
	IF (new.estado = 1) THEN
		SELECT id_comision into _comision FROM comision_facultad WHERE id_facultad=new.id_facultad;
		
		_query := 'INSERT INTO candidato(id_candidato, id_comision) VALUES ('''||new.id_aspirante||''','''||_comision||''')';

		execute _query;
		
	END IF;

	RETURN NEW;

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
  
CREATE TRIGGER aspirante2candidato AFTER INSERT OR UPDATE
   ON aspirante FOR EACH ROW
   EXECUTE PROCEDURE aspirante2candidato();
   
-- cambio de estado candidato a becario
CREATE OR REPLACE FUNCTION candidato2becario()
  RETURNS trigger AS
$BODY$
DECLARE
_candidato varchar(10);
_coordinador int;
_beca int;
_estado int;
_solicitud int;
_comision varchar(100);
_creacion date;
_monto money;
_costo money;
_duracion int;

BEGIN
		
	IF (new.estado = 1) THEN

		SELECT estado into _estado FROM solicitudes_recibidas WHERE id_aspirante=new.id_candidato AND id_comision=new.id_comision;

		IF (_estado != 1) THEN
			UPDATE solicitudes_recibidas SET estado = 1 WHERE id_aspirante = new.id_candidato;
		END IF;
		
		SELECT id_coordinador into _coordinador FROM consejo_becas;
		--
		SELECT MAX(correlativo) into _solicitud FROM solicitudes_recibidas WHERE id_aspirante=new.id_candidato AND id_comision=new.id_comision;
		--
		SELECT id_beca into _beca FROM solicitudes_recibidas WHERE correlativo=_solicitud;
		
		IF exists(SELECT prom_salario_adm FROM administrativo WHERE id_admin = new.id_candidato) THEN
			SELECT prom_salario_adm into _monto FROM administrativo WHERE id_admin = new.id_candidato;
		ELSIF exists(SELECT prom_salario_docente FROM docente WHERE id_docente = new.id_candidato) THEN
			SELECT prom_salario_docente into _monto FROM docente WHERE id_docente = new.id_candidato;
		ELSE
			SELECT cuota_mensualidad into _monto FROM estudiante WHERE id_aspirante = new.candidato;
		END IF;
		
		SELECT date_part('Month', age(befecha_fin,befecha_inicio)) into _duracion FROM beca WHERE id_beca=_beca;
		
		_costo := _monto * _duracion;
		
		_creacion := now();
		
		INSERT INTO becario(id_becario,id_coordinador,id_beca,estado,fecha_creacion_exp,costo_beca)
			VALUES(new.id_candidato,_coordinador,_beca,1,_creacion,_costo);
		
	END IF;

	RETURN NEW;

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

CREATE TRIGGER candidato2becario AFTER INSERT OR UPDATE
   ON candidato FOR EACH ROW
   EXECUTE PROCEDURE candidato2becario();
   
-- manda al historial la info cuando se ingresa la fecha de cierre del expediente
CREATE OR REPLACE FUNCTION mandahistorial()
  RETURNS trigger AS
$BODY$
DECLARE
_fecha date;
_aspirante varchar(10);
_beca int;
_nombre_beca varchar(100);

BEGIN
	
	SELECT nombre_beca into _nombre_beca FROM beca WHERE id_beca = new.beca;
	
	INSERT INTO historial (id_aspirante, becas_anteriores, fecha_fin) VALUES (new.aspirante, _nombre_beca, new.fecha);
	
	RETURN NEW;

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

  
CREATE TRIGGER mandaHistorial AFTER UPDATE
	ON becario FOR EACH ROW
	EXECUTE PROCEDURE mandahistorial();
	
-- cambio de estado en solicitudes recibidas de candidato a becario
CREATE OR REPLACE FUNCTION solicitudRecibida()
  RETURNS trigger AS
$BODY$
DECLARE
_aspirante varchar(10);
_facultad int;
_estado integer;
_query text;
_comision varchar(100);

BEGIN
		
	IF (new.estado = 1) THEN
		
		UPDATE candidato SET estado = 1 WHERE id_candidato = new.id_aspirante;
		
	END IF;

	RETURN NEW;

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
  
CREATE TRIGGER solicitudRecibida AFTER UPDATE
	ON solicitudes_recibidas FOR EACH ROW
	EXECUTE PROCEDURE solicitudRecibida();
	
-- eliminar aspirante
CREATE OR REPLACE FUNCTION eliminaraspirante()
  RETURNS trigger AS
$BODY$
DECLARE
_query text;
_id_aspirante varchar(7);

BEGIN

IF (TG_OP = 'DELETE') THEN
	SELECT id_candidato INTO _id_aspirante FROM candidato WHERE id_candidato = old.id_aspirante;
	IF NOT FOUND THEN
		DELETE FROM aspirante WHERE id_aspirante = old.aspirante AND estado = 2;
	ELSE
		RAISE EXCEPTION '## NO SE PUEDE ELIMINAR EL ASPIRANTE CON ID: «%»,  YA QUE SE ENCUENTRA EN PROCESO DE CANDIDATO A BECARIO. ##',old.id_aspirante;
	END IF;
ELSE
	DELETE FROM aspirante WHERE estado=2;
END IF;

RETURN OLD;

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

CREATE TRIGGER eliminarAspirante BEFORE UPDATE OR DELETE
   ON aspirante FOR EACH ROW
   EXECUTE PROCEDURE eliminarAspirante();
--obtener el ID de estudiante
create or replace function obtener_idES() returns void as
$$
declare
carnet character varying(7);
anio character varying (4);
anio_ultimo character varying(2);
ad character varying(2);
id character varying(7);
count integer;

begin

select max(substr(id_aspirante,1,2)) into ad from aspirante where id_aspirante LIKE 'ES%';

if ad = 'ES' then
	select max(subtr(id_aspirante,3,2)) into anio_ultimo from aspirante where id_aspirante LIKE 'ES%';
	select date_part('year', current_date) into anio;

	select count(*) into count from aspirante where id_aspirante LIKE 'ES%';

	if  count = 0 then
		id := 'ES'+anio+'001';
	else
		if anio_ultimo != anio then
			id := 'ES'+anio+'001';

		else
			select (max(substr(id_aspirante,3,5)))+1 into carnet from aspirante where id_aspirante LIKE 'ES%';

			if char_length(carnet) = 5 then
				id := 'ES'+carnet;
			end if;
		end if;
	end if;

	insert into identificador(id_asp) values (id);
end if;

end
$$
LANGUAGE plpgsql VOLATILE COST 100;

--obtener el ID de docente
CREATE OR REPLACE FUNCTION obtener_iddo()
  RETURNS void AS
$$
declare
carnet character varying(7);
anio character varying (4);
anio_ultimo character varying(2);
ad character varying(2);
id character varying(7);
count integer;

begin

select max(substr(id_aspirante,1,2)) into ad from aspirante where id_aspirante LIKE 'DO%';

if ad = 'DO' then
	select max(subtr(id_aspirante,3,2)) into anio_ultimo from aspirante where id_aspirante LIKE 'DO%';
	select date_part('year', current_date) into anio;

	select count(*) into count from aspirante where id_aspirante LIKE 'DO%';

	if  count = 0 then
		id := 'DO'+anio+'001';
	else
		if anio_ultimo != anio then
			id := 'DO'+anio+'001';

		else
			select (max(substr(id_aspirante,3,5)))+1 into carnet from aspirante where id_aspirante LIKE 'DO%';

			if char_length(carnet) = 5 then
				id := 'DO'+carnet;
			end if;
		end if;
	end if;

	insert into identificador(id_asp) values (id);
end if;

end
$$
LANGUAGE plpgsql VOLATILE COST 100;

--obtener el ID de administrativo
CREATE OR REPLACE FUNCTION obtener_idad()
  RETURNS void AS
$$
declare
carnet character varying(7);
anio character varying (4);
anio_ultimo character varying(2);
ad character varying(2);
id character varying(7);
count integer;

begin

select max(substr(id_aspirante,1,2)) into ad from aspirante where id_aspirante LIKE 'AD%';

if ad = 'AD' then
	select max(subtr(id_aspirante,3,2)) into anio_ultimo from aspirante where id_aspirante LIKE 'AD%';
	select date_part('year', current_date) into anio;

	select count(*) into count from aspirante where id_aspirante LIKE 'AD%';

	if  count = 0 then
		id := 'AD'+anio+'001';
	else
		if anio_ultimo != anio then
			id := 'AD'+anio+'001';

		else
			select (max(substr(id_aspirante,3,5)))+1 into carnet from aspirante where id_aspirante LIKE 'AD%';

			if char_length(carnet) = 5 then
				id := 'AD'+carnet;
			end if;
		end if;
	end if;

	insert into identificador(id_asp) values (id);
end if;

end
$$
LANGUAGE plpgsql VOLATILE COST 100;

--ingresar datos del aspirante
CREATE OR REPLACE FUNCTION in_aspirante(id_tipoaspirante integer, id_depto integer, id_municipio integer, id_facultad integer, apellido1 character varying, apellido2 character varying, apellido_casada character varying, primer_nombre character varying, segundo_nombre character varying, fecha_nacimiento date, dui character varying, lugar_nacimiento character varying, domicilio character varying, correo_electronico character varying, estado_civil character varying, sexo character varying, carnet character varying, carrera_cursada integer, cum real, anio_fin_carrera character varying, cuota_mensualidad money, inicio_servicio_doc date, escuela character varying, prom_salario_docente money, titulo integer, inicio_servicio_adm date, prom_salario_adm money, cargo_admin character varying, tel_oficina character varying, titulo_adm integer, idioma character varying, nivel_idioma character varying, otro_idioma character varying, otro_nivel character varying, investigaciones character varying, tipo integer, id_beca integer)
  RETURNS character varying AS
$$

declare
correo int;
corr int;
idad varchar(7);
id_comision varchar(4);
edad int;
msg varchar(100);

begin

start transaction;

if tipo = 1 then
	select obtener_idES();
elsif tipo = 2 then
	select obtener_idDO();
elsif tipo = 3 then 
	select obtener_idAD();
else
	msg := "Tipo de solicitante invalido...";
	return msg;
end if;
	
select * into idad from identificador;
delete from identificador;

select count(*) into correo from interesado where correo_interesado = correo_electronico;

if correo = 0 then
	insert into interesado(correo_interesado) values(correo_electronico);
	select max(id_interesado) into corr from interesado;
end if;

INSERT INTO aspirante(id_aspirante,id_tipoaspirante,id_interesado,id_depto,id_municipio,id_facultad,apellido1,apellido2,apellido_casada,primer_nombre,segundo_nombre	,fecha_nacimiento,dui,lugar_nacimiento,domicilio,correo_electronico,estado_civil,sexo)
values(idad, id_tipoaspirante,corr ,id_depto ,id_municipio ,id_facultad ,apellido1 ,apellido2 ,apellido_casada ,primer_nombre ,segundo_nombre,fecha_nacimiento,dui ,lugar_nacimiento ,domicilio ,correo_electronico,estado_civil ,sexo );
		
if tipo = 1 then
	INSERT INTO estudiante(id_aspirante,carnet,carrera_cursada,cum,anio_fin_carrera,cuota_mensualidad)
	values(idad,carnet ,carrera_cursada,cum ,anio_fin_carrera ,cuota_mensualidad);
elsif tipo = 2 then
	insert into docente (id_docente,inicio_servicio_doc,escuela,prom_salario_docente,titulo)
	values(idad,inicio_servicio_doc,escuela,prom_salario_docente,titulo);
else
	insert into administrativo(id_admin,inicio_servicio_adm,prom_salario_adm,cargo_admin,tel_oficina,titulo)
	values(idad,inicio_servicio_adm,prom_salario_adm,cargo_admin,tel_oficina,titulo_adm);
end if;

select (date_part('year', current_date) - date_part('year', cast(fecha_nacimiento as date))) into edad from aspirante where id_aspirante = idad;
select id_comision into id_comision from comision_facultad where id_facultad = id_facultad;

insert into detalle_aspirante (id_aspirante,id_comision,edad,idioma,nivel_idioma,otro_idioma,otro_nivel_idioma,investigaciones)
values(idad,id_comision,edad,idioma,nivel_idioma,otro_idioma,otro_nivel,investigaciones);

select in_nueva_solicitud(id_beca,idad,id_comision);

COMMIT;
msg := 'La Solicitud se registro correctamente.';
return msg;

exception when others then 
rollback;
msg := 'Error: % - %', SQLERRM, SQLSTATE;
return msg;
end
$$
LANGUAGE plpgsql VOLATILE COST 100;

--ingresar una nueva solicitud
CREATE OR REPLACE FUNCTION in_nueva_solicitud(id_beca integer, id_aspirante character varying, id_comision character varying)
  RETURNS void AS
$$

declare estado int = 0;

begin

 insert into solicitudes_recibidas(id_beca,id_aspirante,id_comision,estado)
 values(id_beca,id_aspirante,id_comision,estado);
 select compara_requisitosbeca_detalle (id_beca, id_aspirante);
 
end
$$
LANGUAGE plpgsql VOLATILE COST 100;

--comparacion de requisitos de la beca
CREATE OR REPLACE FUNCTION compara_requisitosbeca_detalle(id_beca integer, id_aspirante character varying)
  RETURNS void AS
$$

begin

select compara_requisitosbeca_detalle_100 (id_beca,id_aspirante);
select compara_requisitosbeca_detalle_70 (id_beca,id_aspirante);
select compara_requisitosbeca_detalle_30 (id_beca,id_aspirante);
select compara_requisitosbeca_detalle_0 (id_beca,id_aspirante);

end
$$
LANGUAGE plpgsql VOLATILE COST 100;

--comparacion de requisitos de la beca con 0%
CREATE OR REPLACE FUNCTION compara_requisitosbeca_detalle_0(id_beca integer, id_aspirante character varying)
  RETURNS void AS
$$
declare 
edad int;
idioma Varchar(7);
nivel Varchar (15);
edad_beca int;
idioma_beca  Varchar(7);
nivel_beca Varchar (15);
otro_idioma_beca  Varchar(7);
otro_nivel_idioma Varchar (15);
edads Varchar (15);
idiomas  Varchar (15); 
nivels Varchar (15);
--variable que contiene porcentaje
porcentaje varchar(4);

begin
--asiganacion de valores a variables desde detalle_aspirante
select edad into edad from detalle_aspirante where id_aspirante = id_aspirante;
select idioma into idioma FROM detalle_aspirante WHERE id_aspirante = id_aspirante;
select nivel_idioma into nivel from detalle_aspirante where id_aspirante = id_aspirante;
select otro_idioma into otro_idioma_beca FROM detalle_aspirante WHERE id_aspirante = id_aspirante;
select otro_nivel_idioma into otro_nivel_idioma from detalle_aspirante where id_aspirante = id_aspirante;
-- asignacion de valores a varibles desde requisitos_beca
select edad_beca into edad_beca from requisito_beca where id_beca = id_beca;
select idioma_beca into idioma_beca FROM requisito_beca WHERE id_beca = id_beca;
select nivel_idioma_requerido into nivel_beca from requisito_beca where id_beca = id_beca;

if ((edad <edad_beca) and (idioma<>idioma_beca)) then
	porcentaje := '0%';
	update solicitudes_recibidas set cumplimiento= porcentaje where id_aspirante=id_aspirante;
else
	if ((edad <edad_beca) and (otro_idioma_beca<>idioma_beca)) then
		porcentaje = '0%';
		update solicitudes_recibidas set cumplimiento= porcentaje where id_aspirante=id_aspirante;
	end if;
end if;
end
$$
LANGUAGE plpgsql VOLATILE COST 100;

--comparacion de requisitos de la beca con 35%  
CREATE OR REPLACE FUNCTION compara_requisitosbeca_detalle_30(id_beca integer, id_aspirante character varying)
  RETURNS void AS
$$
declare 
edad int;
idioma Varchar(7);
nivel Varchar (15);
edad_beca int;
idioma_beca  Varchar(7);
nivel_beca Varchar (15);
otro_idioma_beca  Varchar(7);
otro_nivel_idioma Varchar (15);
edads Varchar (15);
idiomas  Varchar (15); 
nivels Varchar (15);
--variable que contiene porcentaje
porcentaje varchar(4);

begin
--asiganacion de valores a variables desde detalle_aspirante
select edad into edad from detalle_aspirante where id_aspirante = id_aspirante;
select idioma into idioma FROM detalle_aspirante WHERE id_aspirante = id_aspirante;
select nivel_idioma into nivel from detalle_aspirante where id_aspirante = id_aspirante;
select otro_idioma into otro_idioma_beca FROM detalle_aspirante WHERE id_aspirante = id_aspirante;
select otro_nivel_idioma into otro_nivel_idioma from detalle_aspirante where id_aspirante = id_aspirante;
-- asignacion de valores a varibles desde requisitos_beca
select edad_beca into edad_beca from requisito_beca where id_beca = id_beca;
select idioma_beca into idioma_beca FROM requisito_beca WHERE id_beca = id_beca;
select nivel_idioma_requerido into nivel_beca from requisito_beca where id_beca = id_beca;

if (edad >= edad_beca) and (idioma<>idioma_beca) and (otro_idioma_beca<>idioma_beca) then
	porcentaje := '35%';
	update solicitudes_recibidas set cumplimiento=porcentaje where id_aspirante=id_aspirante;
else
	if ((edad < edad_beca) and (idioma=idioma_beca)) then
		porcentaje := '35%';
		update solicitudes_recibidas set cumplimiento=porcentaje where id_aspirante=id_aspirante;
	else
		if ((edad < edad_beca) and (otro_idioma_beca=idioma_beca)) then
			porcentaje := '35%';
			update solicitudes_recibidas set cumplimiento=porcentaje where id_aspirante=id_aspirante;
		end if;
	end if;
end if;
end
$$
LANGUAGE plpgsql VOLATILE COST 100;
  
--comparacion de requisitos de la beca con 70%  
CREATE OR REPLACE FUNCTION compara_requisitosbeca_detalle_70(id_beca integer, id_aspirante character varying)
  RETURNS void AS
$$
declare 
edad int;
idioma Varchar(7);
nivel Varchar (15);
edad_beca int;
idioma_beca  Varchar(7);
nivel_beca Varchar (15);
otro_idioma_beca  Varchar(7);
otro_nivel_idioma Varchar (15);
edads Varchar (15);
idiomas  Varchar (15); 
nivels Varchar (15);
--variable que contiene porcentaje
porcentaje varchar(4);

begin
--asiganacion de valores a variables desde detalle_aspirante
select edad into edad from detalle_aspirante where id_aspirante = id_aspirante;
select idioma into idioma FROM detalle_aspirante WHERE id_aspirante = id_aspirante;
select nivel_idioma into nivel from detalle_aspirante where id_aspirante = id_aspirante;
select otro_idioma into otro_idioma_beca FROM detalle_aspirante WHERE id_aspirante = id_aspirante;
select otro_nivel_idioma into otro_nivel_idioma from detalle_aspirante where id_aspirante = id_aspirante;
-- asignacion de valores a varibles desde requisitos_beca
select edad_beca into edad_beca from requisito_beca where id_beca = id_beca;
select idioma_beca into idioma_beca FROM requisito_beca WHERE id_beca = id_beca;
select nivel_idioma_requerido into nivel_beca from requisito_beca where id_beca = id_beca;

if (edad < edad_beca) and (idioma=idioma_beca) and (nivel_beca=nivel) then
	porcentaje := '70%';
	update solicitudes_recibidas set cumplimiento= porcentaje where id_aspirante=id_aspirante;
else
	if ((edad < edad_beca) and (otro_idioma_beca=idioma_beca) and (nivel_beca=otro_nivel_idioma)) then
		porcentaje := '70%';
		update solicitudes_recibidas set cumplimiento= porcentaje where id_aspirante=id_aspirante;
	else
		if ((edad >= edad_beca) and (idioma=idioma_beca)) then
			porcentaje := '70%';
			update solicitudes_recibidas set cumplimiento= porcentaje where id_aspirante=id_aspirante;
		else
			if ((edad >= edad_beca) and (otro_idioma_beca=idioma_beca)) then
				porcentaje = '70%';
				update solicitudes_recibidas set cumplimiento= porcentaje where id_aspirante=id_aspirante;
			end if;
		end if;
	end if;
end if;
end
$$
LANGUAGE plpgsql VOLATILE COST 100;

--comparacion de requisitos de la beca con 100%
CREATE OR REPLACE FUNCTION compara_requisitosbeca_detalle_100(id_beca integer, id_aspirante character varying)
  RETURNS void AS
$$
declare 
edad int;
idioma Varchar(7);
nivel Varchar (15);
edad_beca int;
idioma_beca  Varchar(7);
nivel_beca Varchar (15);
otro_idioma_beca  Varchar(7);
otro_nivel_idioma Varchar (15);
edads Varchar (15);
idiomas  Varchar (15); 
nivels Varchar (15);
--variable que contiene porcentaje
porcentaje varchar(4);

begin
--asiganacion de valores a variables desde detalle_aspirante
select edad into edad from detalle_aspirante where id_aspirante = id_aspirante;
select idioma into idioma FROM detalle_aspirante WHERE id_aspirante = id_aspirante;
select nivel_idioma into nivel from detalle_aspirante where id_aspirante = id_aspirante;
select otro_idioma into otro_idioma_beca FROM detalle_aspirante WHERE id_aspirante = id_aspirante;
select otro_nivel_idioma into otro_nivel_idioma from detalle_aspirante where id_aspirante = id_aspirante;
-- asignacion de valores a varibles desde requisitos_beca
select edad_beca into edad_beca from requisito_beca where id_beca = id_beca;
select idioma_beca into idioma_beca FROM requisito_beca WHERE id_beca = id_beca;
select nivel_idioma_requerido into nivel_beca from requisito_beca where id_beca = id_beca;

if ((edad >= edad_beca) and (idioma=idioma_beca) and (nivel_beca=nivel)) then
	porcentaje := '100%';
	update solicitudes_recibidas set cumplimiento=porcentaje where id_aspirante=id_aspirante;
else
	if ((edad >=edad_beca) and (otro_idioma_beca=idioma_beca) and (nivel_beca=otro_nivel_idioma)) then
		porcentaje = '100%';
		update solicitudes_recibidas set cumplimiento=porcentaje where id_aspirante=id_aspirante;
	end if;
end if;
end
$$
LANGUAGE plpgsql VOLATILE COST 100;

--prueba del sp in_aspirante
--SELECT in_aspirante(1,6,10,5,cast('SANCHEZ' as varchar),cast('PALACIOS' as varchar),cast('' as varchar),cast('GRACIA' as varchar),cast('MARIA' as varchar),cast('1988-05-24' as date),cast('018235762' as varchar),cast('ZACATECOLUCA' as varchar),cast('ZACATECOLUCA' as varchar),cast('gracia.maria@hotmail.com' as varchar),cast('SOLTERO' as varchar),cast('F' as varchar),506,cast(8.71 as real),cast('2011' as varchar),cast('22.73' as money),cast('' as varchar),cast('' as varchar),cast('' as varchar),cast('' as varchar),cast('' as varchar),cast('' as varchar),cast('' as varchar),cast('' as varchar),cast('' as varchar),cast('Japones' as varchar),cast('Avanzado' as varchar),cast('Frances' as varchar),cast('Avanzado' as varchar),cast('Investigacion Cientifica' as varchar),1,87);

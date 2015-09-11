-- Function: sistema_becas.insertarinteresado()

-- DROP FUNCTION sistema_becas.insertarinteresado();

CREATE OR REPLACE FUNCTION sistema_becas.insertarinteresado()
  RETURNS void AS
$BODY$
DECLARE
id_interesado INTEGER:=0;
email character varying;
BEGIN
WHILE id_interesado <1000000 LOOP
    id_interesado:=id_interesado+1;
    BEGIN
    email:='administrativo'||CAST(id_interesado AS character varying)||'@gmail.com';
    INSERT INTO sistema_becas.interesado VALUES(id_interesado,email);
        
EXCEPTION WHEN OTHERS THEN
	 RAISE NOTICE 'error en la insercion';
 END;
 
END LOOP;

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sistema_becas.insertarinteresado()
  OWNER TO postgres;



-- Function: sistema_becas.insertaradministrativo()

-- DROP FUNCTION sistema_becas.insertaradministrativo();

CREATE OR REPLACE FUNCTION sistema_becas.insertaradministrativo()
  RETURNS void AS
$BODY$
DECLARE
idaspirante CHARACTER VARYING(7);
idTipoAspirante INTEGER:=3;
idInteresado INTEGER;
id_depto INTEGER:=6;
id_municipio INTEGER:=8;
id_facultad integer:=2;
apellido1 CHARACTER VARYING;
apellido2 CHARACTER VARYING;
primerNombre CHARACTER VARYING;
segundoNombre CHARACTER VARYING;
fechaN DATE;
dui CHARACTER VARYING;
lugarNac CHARACTER VARYING;

/*tabla administrativo*/

idAdministrativo CHARACTER VARYING;
inicioServicioAdm date;
promedioSalario money;
cargoAdministrativo CHARACTER VARYING;
tel_oficina CHARACTER VARYING;
titulo CHARACTER VARYING;



 ms INTEGER :=0;
	s INTEGER :=0;
idn VARCHAR(7);
temp_s VARCHAR(3);
temp_s2 VARCHAR(2);
temp_f VARCHAR(7);
n_dui INTEGER:=0;
BEGIN

 WHILE ms < 10 LOOP /*control del numero de años*/
 ms:=ms+1;
 

     s:=0;
  temp_s2:=lpad(''||CAST(ms AS VARCHAR),2,'0');
     WHILE s<800 LOOP /*Control del numero de registros por año*/
			s:=s+1;
	    n_dui:=n_dui+1;
      idInteresado=n_dui;
      temp_s:=lpad(''||CAST(s AS VARCHAR),3,'0');
      temp_f:='AD'||temp_s2||temp_s;
      idaspirante:=temp_f;
      idAdministrativo:=idaspirante;
			dui:=lpad(''||CAST(n_dui AS VARCHAR),8,'0')||'0';
              
         BEGIN
					INSERT INTO sistema_becas.aspirante VALUES(idaspirante,idTipoAspirante,idInteresado,id_depto,id_municipio,id_facultad,'Rivera','Salinas',NULL,'Alexander','Antonio','1998-03-03',dui,' Pasaje José Simeón Cañas # 338 San salvador','Carretera al puerto de la Libertad, Km. 9 1/2','email@gmail.com','soltero','M',0);
          INSERT INTO sistema_becas.administrativo VALUES(idAdministrativo,idTipoAspirante,'2008-05-04',455.34,'Cargo admisnitrativo','24349933',4);
					EXCEPTION WHEN OTHERS THEN
						 RAISE NOTICE 'error en la insercion';
					END;


      
     
    END LOOP;
 
END LOOP;



END;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sistema_becas.insertaradministrativo()
  OWNER TO postgres;



-- Function: sistema_becas.insertardocente()

-- DROP FUNCTION sistema_becas.insertardocente();

CREATE OR REPLACE FUNCTION sistema_becas.insertardocente()
  RETURNS void AS
$BODY$
DECLARE
idaspirante CHARACTER VARYING(7);
idTipoAspirante INTEGER:=2;
idInteresado INTEGER:=8000;
id_depto INTEGER:=6;
id_municipio INTEGER:=14;
id_facultad integer:=5;
apellido1 CHARACTER VARYING;
apellido2 CHARACTER VARYING;
primerNombre CHARACTER VARYING;
segundoNombre CHARACTER VARYING;
fechaN DATE;
dui CHARACTER VARYING;
lugarNac CHARACTER VARYING;

/*tabla administrativo*/

idDocente CHARACTER VARYING;
inicioServicioDoc date;
promedioSalario money;
escuela CHARACTER VARYING;
titulo CHARACTER VARYING;



 ms INTEGER :=0;
	s INTEGER :=0;
idn VARCHAR(7);
temp_s VARCHAR(3);
temp_s2 VARCHAR(2);
temp_f VARCHAR(7);
n_dui INTEGER:=0;
BEGIN

 WHILE ms < 10 LOOP /*control del numero de años*/
 ms:=ms+1;
 

     s:=0;
  temp_s2:=lpad(''||CAST(ms AS VARCHAR),2,'0');
     WHILE s<800 LOOP /*Control del numero de registros por año*/
			s:=s+1;
	    n_dui:=n_dui+1;
      idInteresado:=idInteresado+1;
      temp_s:=lpad(''||CAST(s AS VARCHAR),3,'0');
      temp_f:='DO'||temp_s2||temp_s;
      idaspirante:=temp_f;
      idDocente:=idaspirante;
			dui:=lpad(''||CAST(n_dui AS VARCHAR),8,'1')||'0';
              
         BEGIN
					INSERT INTO sistema_becas.aspirante VALUES(idaspirante,idTipoAspirante,idInteresado,id_depto,id_municipio,id_facultad,'Hernandez','Flores',NULL,'Aida','Margarita','1986-03-09',dui,' Pasaje XYZ # 338 San salvador','Colonia El milagro ','email@gmail.com','soltera','F',0);
          INSERT INTO sistema_becas.docente VALUES(idDocente,idTipoAspirante,'2009-08-07','Escuela de civil',1200.34,3);
					EXCEPTION WHEN OTHERS THEN
						 RAISE NOTICE 'error en la insercion';
					END;


      
     
    END LOOP;
 
END LOOP;



END;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sistema_becas.insertardocente()
  OWNER TO postgres;



-- Function: sistema_becas.insertarestudiante()

-- DROP FUNCTION sistema_becas.insertarestudiante();

CREATE OR REPLACE FUNCTION sistema_becas.insertarestudiante()
  RETURNS void AS
$BODY$
DECLARE
idaspirante CHARACTER VARYING(7);
idTipoAspirante INTEGER:=1;
idInteresado INTEGER:=16000;
id_depto INTEGER:=6;
id_municipio INTEGER:=12;
id_facultad integer:=8;
apellido1 CHARACTER VARYING;
apellido2 CHARACTER VARYING;
primerNombre CHARACTER VARYING;
segundoNombre CHARACTER VARYING;
fechaN DATE;
dui CHARACTER VARYING;
lugarNac CHARACTER VARYING;

/*tabla administrativo*/

idEstudiante CHARACTER VARYING;
inicioServicioDoc date;
carnet CHARACTER VARYING(7);
carrera_cursada INTEGER;
cum REAL;
anioFinCarrera CHARACTER VARYING;
cuotaMensualidad money;

 ms INTEGER :=0;
	s INTEGER :=0;
idn VARCHAR(7);
temp_s VARCHAR(3);
temp_s2 VARCHAR(2);
temp_f VARCHAR(7);
n_dui INTEGER:=0;
BEGIN

 WHILE ms < 10 LOOP /*control del numero de años*/
 ms:=ms+1;
 

     s:=0;
  temp_s2:=lpad(''||CAST(ms AS VARCHAR),2,'0');
     WHILE s<800 LOOP /*Control del numero de registros por año*/
			s:=s+1;
	    n_dui:=n_dui+1;
      idInteresado:=idInteresado+1;
      temp_s:=lpad(''||CAST(s AS VARCHAR),3,'0');
      temp_f:='ES'||temp_s2||temp_s;
      idaspirante:=temp_f;
      idEstudiante:=idaspirante;
			dui:=lpad(''||CAST(n_dui AS VARCHAR),8,'1')||'0';
          carnet:='CA'||lpad(''||CAST(idInteresado AS VARCHAR),5,'0');
         BEGIN
					INSERT INTO sistema_becas.aspirante VALUES(idaspirante,idTipoAspirante,idInteresado,id_depto,id_municipio,id_facultad,'Segovia','Villanueva',NULL,'Sandra','Mariela','1990-04-05',dui,' Pasaje XYZ # 338 San salvador','Colonia El milagro ','email@gmail.com','soltera','F',0);
					RAISE NOTICE 'carnet = %',idEstudiante;
          INSERT INTO sistema_becas.estudiante VALUES(idEstudiante,idTipoAspirante,carnet,701,7.87,2012,5.20);
					EXCEPTION WHEN OTHERS THEN
						 RAISE NOTICE 'error en la insercion';
					END;


      
     
    END LOOP;
 
END LOOP;



END;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sistema_becas.insertarestudiante()
  OWNER TO postgres;


CREATE USER aspirante
PASSWORD 'aspirante'; 
--- PRIVILEGIOS EN LAS TABLAS
GRANT USAGE ON SCHEMA sistema_becas TO aspirante;
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE aspirante TO aspirante;
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE administrativo TO aspirante;
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE docente TO aspirante;
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE estudiante TO aspirante;
GRANT SELECT ON TABLE historial TO aspirante;
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE municipio TO aspirante;
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE depto TO aspirante;

GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE detalle_aspirante TO aspirante;
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE tipoaspirante TO aspirante;

GRANT SELECT ON TABLE comision_facultad TO aspirante;
GRANT SELECT ON TABLE facultad TO aspirante;
GRANT SELECT ON TABLE carreras TO aspirante;
GRANT SELECT,INSERT,UPDATE ON TABLE requisito_beca TO aspirante;
CREATE USER comision_facultad PASSWORD 'comision_facultad';
---PRIVILEGIOS
GRANT USAGE ON SCHEMA sistema_becas TO comision_facultad;
GRANT SELECT,INSERT,UPDATE ON TABLE comision_facultad TO comision_facultad;
GRANT SELECT,UPDATE ON TABLE detalle_aspirante TO comision_facultad;
GRANT SELECT,UPDATE ON TABLE solicitudes_recibidas TO comision_facultad;
GRANT SELECT,UPDATE ON TABLE detalle_aspirante TO comision_facultad;
GRANT SELECT,UPDATE ON TABLE candidato TO comision_facultad;

GRANT SELECT,UPDATE ON TABLE administrativo TO comision_facultad;
GRANT SELECT,UPDATE ON TABLE docente TO comision_facultad;
GRANT SELECT,UPDATE ON TABLE estudiante TO comision_facultad;
GRANT SELECT ON TABLE historial TO comision_facultad;
GRANT SELECT,UPDATE ON TABLE municipio TO comision_facultad;
GRANT SELECT,UPDATE ON TABLE depto TO comision_facultad;
GRANT SELECT ON TABLE requisito_consejo TO comision_facultad;
GRANT SELECT ON TABLE requisito_beca TO comision_facultad;
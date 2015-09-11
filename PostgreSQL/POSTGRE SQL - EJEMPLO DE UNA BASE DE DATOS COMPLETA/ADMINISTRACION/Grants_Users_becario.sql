CREATE USER becario PASSWORD 'becario';
---PRIVILEGIOS
GRANT USAGE ON SCHEMA sistema_becas TO becario;
GRANT SELECT ON TABLE becario TO becario;
GRANT SELECT ON TABLE beca TO becario;
GRANT SELECT,INSERT ON TABLE informe TO becario;

GRANT SELECT ON TABLE administrativo TO becario;
GRANT SELECT ON TABLE docente TO becario;
GRANT SELECT ON TABLE estudiante TO becario;
GRANT SELECT ON TABLE historial TO becario;
GRANT SELECT ON TABLE municipio TO becario;
GRANT SELECT ON TABLE depto TO becario;

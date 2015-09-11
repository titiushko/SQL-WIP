CREATE USER consejo_becas PASSWORD 'consejo_becas';
---PRIVILEGIOS
GRANT USAGE ON SCHEMA sistema_becas TO consejo_becas;
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE requisito_consejo TO consejo_becas;
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE requisito_beca TO consejo_becas;
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE beca TO consejo_becas;
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE candidato TO consejo_becas;
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE becario TO consejo_becas;
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE estado_becario TO consejo_becas;
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE informe TO consejo_becas;
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE institucion TO consejo_becas;
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE pais TO consejo_becas;
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE fuente_cooperacion TO consejo_becas;

GRANT SELECT ON TABLE administrativo TO consejo_becas;
GRANT SELECT ON TABLE docente TO consejo_becas;
GRANT SELECT ON TABLE estudiante TO consejo_becas;
GRANT SELECT ON TABLE municipio TO consejo_becas;
GRANT SELECT ON TABLE depto TO consejo_becas;
GRANT SELECT ON TABLE aspirante TO consejo_becas;
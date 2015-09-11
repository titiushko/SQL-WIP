CREATE USER candidato
PASSWORD 'candidato';
---PRIVILEGIOS EN LAS TABLAS
GRANT USAGE ON SCHEMA sistema_becas TO candidato;
GRANT SELECT,INSERT,UPDATE ON TABLE candidato TO candidato;
GRANT SELECT ON TABLE aspirante TO candidato;
GRANT SELECT,INSERT,UPDATE ON TABLE requisito_consejo TO candidato;
GRANT SELECT ON TABLE requisito_beca TO candidato;

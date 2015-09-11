-- ******* GRANTS & USERS *******   
CREATE USER interesado
PASSWORD 'interesado';
--- PRIVILEGIOS EN LAS TABLAS
GRANT USAGE ON SCHEMA sistema_becas TO interesado;
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE sistema_becas.interesado TO interesado;
GRANT SELECT ON TABLE sistema_becas.area_interes TO interesado;
GRANT SELECT ON TABLE sistema_becas.areas_interesado TO interesado;

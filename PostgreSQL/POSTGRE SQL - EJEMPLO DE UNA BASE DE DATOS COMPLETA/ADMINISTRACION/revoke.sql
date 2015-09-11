REVOKE USAGE ON SCHEMA sistema_becas FROM interesado;
revoke SELECT,INSERT,UPDATE,DELETE ON sistema_becas.interesado  from interesado;
revoke SELECT ON sistema_becas.area_interes from interesado;
revoke  SELECT ON  sistema_becas.areas_interesado from interesado;






REVOKE USAGE ON SCHEMA sistema_becas FROM aspirante;
revoke SELECT,INSERT,UPDATE,DELETE ON sistema_becas.aspirante from aspirante;
revoke SELECT,INSERT,UPDATE,DELETE ON sistema_becas.administrativo from aspirante;
revoke SELECT,INSERT,UPDATE,DELETE ON sistema_becas.docente from aspirante;
revoke SELECT,INSERT,UPDATE,DELETE ON sistema_becas.estudiante from aspirante;
revoke SELECT ON  sistema_becas.historial from aspirante;
revoke SELECT,INSERT,UPDATE,DELETE ON  sistema_becas.municipio from aspirante;
revoke SELECT,INSERT,UPDATE,DELETE ON  sistema_becas.depto from aspirante;

revoke SELECT,INSERT,UPDATE,DELETE ON  sistema_becas.detalle_aspirante from aspirante;
revoke SELECT,INSERT,UPDATE,DELETE ON sistema_becas.tipoaspirante from aspirante;

revoke SELECT ON  sistema_becas.comision_facultad from aspirante;
revoke SELECT ON  sistema_becas.facultad from aspirante;
revoke SELECT ON  sistema_becas.carreras from aspirante;
revoke SELECT,INSERT,UPDATE ON  sistema_becas.requisito_beca from aspirante;







REVOKE USAGE ON SCHEMA sistema_becas FROM candidato;
REVOKE SELECT,INSERT,UPDATE ON TABLE sistema_becas.candidato FROM candidato;
REVOKE SELECT ON TABLE sistema_becas.aspirante FROM candidato;
REVOKE SELECT,INSERT,UPDATE ON TABLE sistema_becas.requisito_consejo FROM candidato;
REVOKE SELECT ON TABLE sistema_becas.requisito_beca FROM candidato;






REVOKE USAGE ON SCHEMA sistema_becas FROM comision_facultad;
REVOKE SELECT,INSERT,UPDATE ON TABLE sistema_becas.comision_facultad FROM comision_facultad;
REVOKE SELECT,UPDATE ON TABLE sistema_becas.detalle_aspirante FROM comision_facultad;
REVOKE SELECT,UPDATE ON TABLE sistema_becas.solicitudes_recibidas FROM comision_facultad;
REVOKE SELECT,UPDATE ON TABLE sistema_becas.detalle_aspirante FROM comision_facultad;
REVOKE SELECT,UPDATE ON TABLE sistema_becas.candidato FROM comision_facultad;

REVOKE SELECT,UPDATE ON TABLE sistema_becas.administrativo FROM comision_facultad;
REVOKE SELECT,UPDATE ON TABLE sistema_becas.docente FROM comision_facultad;
REVOKE SELECT,UPDATE ON TABLE sistema_becas.estudiante FROM comision_facultad;
REVOKE SELECT ON TABLE sistema_becas.historial FROM comision_facultad;
REVOKE SELECT,UPDATE ON TABLE sistema_becas.municipio FROM comision_facultad;
REVOKE SELECT,UPDATE ON TABLE sistema_becas.depto FROM comision_facultad;
REVOKE SELECT ON TABLE sistema_becas.requisito_consejo FROM comision_facultad;
REVOKE SELECT ON TABLE sistema_becas.requisito_beca FROM comision_facultad;










REVOKE USAGE ON SCHEMA sistema_becas FROM becario;
REVOKE SELECT ON TABLE sistema_becas.becario FROM becario;
REVOKE SELECT ON TABLE sistema_becas.beca FROM becario;
REVOKE SELECT,INSERT ON TABLE sistema_becas.informe FROM becario;

REVOKE SELECT ON TABLE sistema_becas.administrativo FROM becario;
REVOKE SELECT ON TABLE sistema_becas.docente FROM becario;
REVOKE SELECT ON TABLE sistema_becas.estudiante FROM becario;
REVOKE SELECT ON TABLE sistema_becas.historial FROM becario;
REVOKE SELECT ON TABLE sistema_becas.municipio FROM becario;
REVOKE SELECT ON TABLE sistema_becas.depto FROM becario;





---PRIVILEGIOS
REVOKE USAGE ON SCHEMA sistema_becas FROM consejo_becas;
REVOKE SELECT,INSERT,UPDATE,DELETE ON TABLE sistema_becas.requisito_consejo FROM consejo_becas;
REVOKE SELECT,INSERT,UPDATE,DELETE ON TABLE sistema_becas.requisito_beca FROM consejo_becas;
REVOKE SELECT,INSERT,UPDATE,DELETE ON TABLE sistema_becas.beca FROM consejo_becas;
REVOKE SELECT,INSERT,UPDATE,DELETE ON TABLE sistema_becas.candidato FROM consejo_becas;
REVOKE SELECT,INSERT,UPDATE,DELETE ON TABLE sistema_becas.becario FROM consejo_becas;
REVOKE SELECT,INSERT,UPDATE,DELETE ON TABLE sistema_becas.estado_becario FROM consejo_becas;
REVOKE SELECT,INSERT,UPDATE,DELETE ON TABLE sistema_becas.informe FROM consejo_becas;
REVOKE SELECT,INSERT,UPDATE,DELETE ON TABLE sistema_becas.institucion FROM consejo_becas;
REVOKE SELECT,INSERT,UPDATE,DELETE ON TABLE sistema_becas.pais FROM consejo_becas;
REVOKE SELECT,INSERT,UPDATE,DELETE ON TABLE sistema_becas.fuente_cooperacion FROM consejo_becas;

REVOKE SELECT ON TABLE sistema_becas.administrativo FROM consejo_becas;
REVOKE SELECT ON TABLE sistema_becas.docente FROM consejo_becas;
REVOKE SELECT ON TABLE sistema_becas.estudiante FROM consejo_becas;
REVOKE SELECT ON TABLE sistema_becas.municipio FROM consejo_becas;
REVOKE SELECT ON TABLE sistema_becas.depto FROM consejo_becas;
REVOKE SELECT ON TABLE sistema_becas.aspirante FROM consejo_becas;



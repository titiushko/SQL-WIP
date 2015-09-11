/*======================================*/
--HR_EMPLOYEES
/*======================================*/
CREATE OR REPLACE TRIGGER hr_tr_generate_email
    BEFORE INSERT
    ON hr_employees
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
DECLARE
    v_inicial_nombre VARCHAR2(2) := NULL;
    v_apellido hr_employees.last_name%TYPE := NULL;
BEGIN
    v_inicial_nombre := UPPER(SUBSTR(:NEW.first_name,1,1));
    v_apellido := UPPER(:NEW.last_name);
    --:NEW.email := v_inicial_nombre || v_apellido || '@dominio.com';
    :NEW.email := v_inicial_nombre || v_apellido;
END hr_tr_generate_email;
--
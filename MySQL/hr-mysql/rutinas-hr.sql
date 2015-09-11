DELIMITER $$
DROP FUNCTION IF EXISTS fn_employee_last_id $$
CREATE FUNCTION fn_employee_last_id() RETURNS INT(6)
NOT DETERMINISTIC
SQL SECURITY DEFINER
COMMENT 'funcion que devuelve ultimo codigo de empleado insertado'
BEGIN
	DECLARE v_codigo INT(6);
	SET v_codigo = (SELECT MAX(employee_id) FROM employees);
	RETURN v_codigo;        
END;
$$
DELIMITER ;

-- --------------------------------------------------------------------------------------------------

DELIMITER $$
DROP FUNCTION IF EXISTS fn_full_name $$
CREATE FUNCTION fn_full_name(p_codigo_empleado INTEGER(6)) RETURNS VARCHAR(100)
NOT DETERMINISTIC
SQL SECURITY DEFINER
COMMENT 'funcion que devuelve el nombre completo de un empleado'
BEGIN
	DECLARE v_nombre VARCHAR(100);
	-- DECLARE v_termina BOOL DEFAULT FALSE;
	DECLARE v_termina INT DEFAULT FALSE;
	
	DECLARE c_nombre CURSOR FOR
		SELECT CONCAT(first_name,' ',last_name) nombre
		FROM employees
		WHERE employee_id = p_codigo_empleado;
	
	-- DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET v_termina = TRUE;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_termina = TRUE;
	
	OPEN c_nombre;
	recorre_cursor: LOOP
		FETCH c_nombre INTO v_nombre;
		
		IF v_termina THEN
			LEAVE recorre_cursor;
		END IF;
		
	END LOOP;
	CLOSE c_nombre;
	
	RETURN v_nombre;
END;
$$
DELIMITER ;

-- --------------------------------------------------------------------------------------------------

-- funcion que devuelve el puesto que desempeña un empleado
FUNCTION fn_job(p_codigo_empleado IN employees.employee_id%TYPE)
RETURN VARCHAR2
IS    
	v_puesto VARCHAR2(100);
	no_hay_datos EXCEPTION;

	CURSOR c_puesto
	IS
		SELECT j.job_title puesto
		  FROM employees e, jobs j
		 WHERE e.job_id = j.job_id
		   AND employee_id = p_codigo_empleado;

BEGIN
	OPEN c_puesto;
	FETCH c_puesto INTO v_puesto;
	IF c_puesto%NOTFOUND THEN
		RAISE no_hay_datos;
	END IF;
	CLOSE c_puesto;

	RETURN v_puesto;
	
	EXCEPTION
		WHEN no_hay_datos THEN
			RETURN 'El empleado con el codigo: ' || p_codigo_empleado || ' no existe.';
		WHEN OTHERS THEN
			RETURN 'Ocurrido un error: ' || SQLERRM;
	
END fn_job;

-- --------------------------------------------------------------------------------------------------

-- funcion que devuelve el departamento al que pertenece un empleado
FUNCTION fn_department(p_codigo_empleado IN employees.employee_id%TYPE)
RETURN VARCHAR2
IS    
	v_departamento VARCHAR2(100);
	no_hay_datos EXCEPTION;

	CURSOR c_departamento
	IS
		SELECT d.department_name departamento
		  FROM employees e, departments d
		 WHERE e.department_id = d.department_id
		   AND employee_id = p_codigo_empleado;

BEGIN
	OPEN c_departamento;
	FETCH c_departamento INTO v_departamento;
	IF c_departamento%NOTFOUND THEN
		RAISE no_hay_datos;
	END IF;
	CLOSE c_departamento;

	RETURN v_departamento;
	
	EXCEPTION
		WHEN no_hay_datos THEN
			RETURN 'El empleado con el codigo: ' || p_codigo_empleado || ' no existe.';
		WHEN OTHERS THEN
			RETURN 'Ocurrido un error: ' || SQLERRM;
	
END fn_department;

-- --------------------------------------------------------------------------------------------------

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_remove_employee $$
CREATE PROCEDURE sp_remove_employee(p_codigo_empleado INTEGER(6), OUT p_resultado VARCHAR(255))
NOT DETERMINISTIC
SQL SECURITY DEFINER
COMMENT 'procedimiento que elimina un empleado'
BEGIN
	DELETE FROM employees WHERE employee_id = p_codigo_empleado;
	COMMIT;
	SET p_resultado = 'Se elimino correctamente el empleado.';
END;
$$
DELIMITER ;

-- --------------------------------------------------------------------------------------------------

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_up_salary_employees $$
CREATE PROCEDURE sp_up_salary_employees(p_codigo_departamento INT(4), p_aumento INT(4), OUT p_resultado VARCHAR(255))
NOT DETERMINISTIC
SQL SECURITY DEFINER
COMMENT 'procedimiento que actualiza el aumentando de un porcentaje en el salario de los empleados aumentando de un departamento...'
BEGIN
	DECLARE v_monto INT(4);
	
	SET v_monto = p_aumento / 100;
	
	UPDATE employees
	   SET salary = salary * (1 + v_monto)
	 WHERE department_id = p_codigo_departamento;
	COMMIT;
	
	SET p_resultado = 'Se actualizo con exito el aumento del salario en el departamento.';
END;
$$
DELIMITER ;

SET @p0='90'; SET @p1='2'; SET @p2=''; CALL `sp_up_salary_employees`(@p0, @p1, @p2);

-- --------------------------------------------------------------------------------------------------

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_add_employee $$
CREATE PROCEDURE sp_add_employee(
	p_nombre_empleado VARCHAR(20),
	p_apellido_empleado VARCHAR(25),
	p_numero_telefono VARCHAR(20),
	p_fecha_contrato DATE,
	p_puesto VARCHAR(35),
	p_salario_empleado NUMERIC(8,2),
	p_departamento VARCHAR(30),
	OUT p_resultado VARCHAR(255)
)
NOT DETERMINISTIC
SQL SECURITY DEFINER
COMMENT 'procedimiento que inserta un empleado'
BEGIN
	DECLARE v_codigo_puesto VARCHAR(10) DEFAULT NULL;
	DECLARE v_codigo_departamento NUMERIC(4) DEFAULT NULL;
	
	SET v_codigo_puesto = (SELECT job_id FROM jobs WHERE job_title = p_puesto);
	SET v_codigo_departamento = (SELECT department_id FROM departments WHERE department_name = p_departamento);
	
	INSERT INTO employees(first_name, last_name, phone_number, hire_date, job_id, salary, department_id)
		 VALUES(INITCAP(TRIM(p_nombre_empleado)), INITCAP(TRIM(p_apellido_empleado)), p_numero_telefono, STR_TO_DATE(p_fecha_contrato,'%d/%m/%Y'), v_codigo_puesto, p_salario_empleado, v_codigo_departamento);
	COMMIT;
	SET p_resultado = CONCAT('Se inserto correctamente el empleado: ',INITCAP(TRIM(p_nombre_empleado)),' ',INITCAP(TRIM(p_apellido_empleado)));
END;
$$
DELIMITER ;

-- --------------------------------------------------------------------------------------------------

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_update_hire_date_employees $$
CREATE PROCEDURE sp_update_hire_date_employees(p_codigo_departamento INT(4))
NOT DETERMINISTIC
SQL SECURITY DEFINER
COMMENT 'procedimiento que actualiza la fecha de contrato de los empleados de un departamento...'
BEGIN
	UPDATE employees
	   SET hire_date = NOW()
	 WHERE department_id = p_codigo_departamento;
	COMMIT;
END;
$$
DELIMITER ;

-- --------------------------------------------------------------------------------------------------

DELIMITER $$
DROP TRIGGER IF EXISTS hr_tr_generate_email $$
CREATE TRIGGER hr_tr_generate_email BEFORE INSERT ON employees
FOR EACH ROW
-- NOT DETERMINISTIC
-- SQL SECURITY DEFINER
-- COMMENT ''
BEGIN
    DECLARE v_inicial_nombre VARCHAR(2) DEFAULT NULL;
    DECLARE v_apellido VARCHAR(25) DEFAULT NULL;
    
	SET v_inicial_nombre = UPPER(SUBSTRING_INDEX(NEW.first_name,1,1));
    SET v_apellido = UPPER(NEW.last_name);
    -- SET NEW.email = CONCAT(v_inicial_nombre,v_apellido,'@dominio.com');
    SET NEW.email = CONCAT(v_inicial_nombre,v_apellido);
END;
$$
DELIMITER ;

-- --------------------------------------------------------------------------------------------------

SET GLOBAL event_scheduler = ON;
DELIMITER $$
DROP EVENT IF EXISTS e_update_hire_date_employees $$
CREATE EVENT e_update_hire_date_employees
ON SCHEDULE EVERY 1 MINUTE STARTS '2014-09-30 06:15:00'
DO
CALL sp_update_hire_date_employees(70);
$$
DELIMITER ;

CREATE OR REPLACE PACKAGE hr_pk_employee
IS
    -- funcion que devuelve ultimo codigo de empleado insertado
    FUNCTION fn_employee_id
    RETURN hr_employees.employee_id%TYPE;
    
    -- funcion que devuelve el nombre completo de un empleado
    FUNCTION fn_full_name(p_codigo_empleado IN hr_employees.employee_id%TYPE)
    RETURN VARCHAR2;
    
    -- funcion que devuelve el email de un empleado
    FUNCTION fn_email(p_codigo_empleado IN hr_employees.employee_id%TYPE)
    RETURN VARCHAR2;
    
    -- funcion que devuelve el numero de telefono de un empleado
    FUNCTION fn_phone_number(p_codigo_empleado IN hr_employees.employee_id%TYPE)
    RETURN VARCHAR2;
    
    -- funcion que devuelve la fecha de contratacion de un empleado
    FUNCTION fn_hire_date(p_codigo_empleado IN hr_employees.employee_id%TYPE)
    RETURN DATE;
    
    -- funcion que devuelve el puesto que desempeña un empleado
    FUNCTION fn_job(p_codigo_empleado IN hr_employees.employee_id%TYPE)
    RETURN VARCHAR2;
    
    -- funcion que devuelve el salario de un empleado
    FUNCTION fn_salary(p_codigo_empleado IN hr_employees.employee_id%TYPE)
    RETURN NUMBER;
    
    -- funcion que devuelve el departamento al que pertenece un empleado
    FUNCTION fn_department(p_codigo_empleado IN hr_employees.employee_id%TYPE)
    RETURN VARCHAR2;
    
    -- procedimiento que actualiza el aumentando de un porcentaje en el salario de los empleados aumentando de un departamento...
    PROCEDURE sp_up_salary_employees(p_codigo_departamento IN NUMBER, p_aumento IN NUMBER, p_resultado OUT VARCHAR2);
    
    -- procedimiento que inserta un empleado
    PROCEDURE sp_add_employee(
        p_nombre_empleado IN hr_employees.first_name%TYPE,
        p_apellido_empleado IN hr_employees.last_name%TYPE,
        p_numero_telefono IN hr_employees.phone_number%TYPE,
        p_fecha_contrato IN hr_employees.hire_date%TYPE,
        p_puesto IN hr_jobs.job_title%TYPE,
        p_salario_empleado IN hr_employees.salary%TYPE,
        p_departamento IN hr_departments.department_name%TYPE,
        p_resultado OUT VARCHAR2
    );
    
    -- procedimiento que elimina un empleado
    PROCEDURE sp_remove_employee(p_codigo_empleado IN hr_employees.employee_id%TYPE, p_resultado OUT VARCHAR2);

END hr_pk_employee;
/

CREATE OR REPLACE PACKAGE BODY TC.hr_pk_employee
IS
   -- funcion que devuelve ultimo codigo de empleado insertado
    FUNCTION fn_employee_id
    RETURN hr_employees.employee_id%TYPE
    IS    
        v_codigo hr_employees.employee_id%TYPE;    
    BEGIN
        SELECT MAX(employee_id) INTO v_codigo FROM hr_employees;    
        RETURN v_codigo;
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN 'No hay empleados.';
            WHEN OTHERS THEN
                RETURN 'Ocurrido un error: ' || SQLERRM;
        
    END fn_employee_id;
    
    -- funcion que devuelve el nombre completo de un empleado
    FUNCTION fn_full_name(p_codigo_empleado IN hr_employees.employee_id%TYPE)
    RETURN VARCHAR2
    IS    
        v_nombre VARCHAR2(100);
        no_hay_datos EXCEPTION;
    
        CURSOR c_nombre
        IS
            SELECT first_name || ' ' || last_name nombre
              FROM hr_employees
             WHERE employee_id = p_codigo_empleado;
    
    BEGIN
        OPEN c_nombre;
        FETCH c_nombre INTO v_nombre;
        IF c_nombre%NOTFOUND THEN
            RAISE no_hay_datos;
        END IF;
        CLOSE c_nombre;
    
        RETURN v_nombre;
        
        EXCEPTION
            WHEN no_hay_datos THEN
                RETURN 'El empleado con el codigo: ' || p_codigo_empleado || ' no existe.';
            WHEN OTHERS THEN
                RETURN 'Ocurrido un error: ' || SQLERRM;
        
    END fn_full_name;
    
    -- funcion que devuelve el email de un empleado
    FUNCTION fn_email(p_codigo_empleado IN hr_employees.employee_id%TYPE)
    RETURN VARCHAR2
    IS    
        v_email VARCHAR2(100);
        no_hay_datos EXCEPTION;
    
        CURSOR c_email
        IS
            SELECT email
              FROM hr_employees
             WHERE employee_id = p_codigo_empleado;
    
    BEGIN
        OPEN c_email;
        FETCH c_email INTO v_email;
        IF c_email%NOTFOUND THEN
            RAISE no_hay_datos;
        END IF;
        CLOSE c_email;
    
        RETURN v_email;
        
        EXCEPTION
            WHEN no_hay_datos THEN
                RETURN 'El empleado con el codigo: ' || p_codigo_empleado || ' no existe.';
            WHEN OTHERS THEN
                RETURN 'Ocurrido un error: ' || SQLERRM;
        
    END fn_email;
    
    -- funcion que devuelve el numero de telefono de un empleado
    FUNCTION fn_phone_number(p_codigo_empleado IN hr_employees.employee_id%TYPE)
    RETURN VARCHAR2
    IS    
        v_telefono VARCHAR2(100);
        no_hay_datos EXCEPTION;
    
        CURSOR c_telefono
        IS
            SELECT phone_number
              FROM hr_employees
             WHERE employee_id = p_codigo_empleado;
    
    BEGIN
        OPEN c_telefono;
        FETCH c_telefono INTO v_telefono;
        IF c_telefono%NOTFOUND THEN
            RAISE no_hay_datos;
        END IF;
        CLOSE c_telefono;
    
        RETURN v_telefono;
        
        EXCEPTION
            WHEN no_hay_datos THEN
                RETURN 'El empleado con el codigo: ' || p_codigo_empleado || ' no existe.';
            WHEN OTHERS THEN
                RETURN 'Ocurrido un error: ' || SQLERRM;
        
    END fn_phone_number;
    
    -- funcion que devuelve la fecha de contratacion de un empleado
    FUNCTION fn_hire_date(p_codigo_empleado IN hr_employees.employee_id%TYPE)
    RETURN DATE
    IS    
        v_fecha_contrato DATE;
        no_hay_datos EXCEPTION;
    
        CURSOR c_fecha_contrato
        IS
            SELECT hire_date
              FROM hr_employees
             WHERE employee_id = p_codigo_empleado;
    
    BEGIN
        OPEN c_fecha_contrato;
        FETCH c_fecha_contrato INTO v_fecha_contrato;
        IF c_fecha_contrato%NOTFOUND THEN
            RAISE no_hay_datos;
        END IF;
        CLOSE c_fecha_contrato;
    
        RETURN v_fecha_contrato;
        
        EXCEPTION
            WHEN no_hay_datos THEN
                RETURN 'El empleado con el codigo: ' || p_codigo_empleado || ' no existe.';
            WHEN OTHERS THEN
                RETURN 'Ocurrido un error: ' || SQLERRM;
        
    END fn_hire_date;
    
    -- funcion que devuelve el puesto que desempeña un empleado
    FUNCTION fn_job(p_codigo_empleado IN hr_employees.employee_id%TYPE)
    RETURN VARCHAR2
    IS    
        v_puesto VARCHAR2(100);
        no_hay_datos EXCEPTION;
    
        CURSOR c_puesto
        IS
            SELECT j.job_title puesto
              FROM hr_employees e, hr_jobs j
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
    
    -- funcion que devuelve el salario de un empleado
    FUNCTION fn_salary(p_codigo_empleado IN hr_employees.employee_id%TYPE)
    RETURN NUMBER
    IS    
        v_salario NUMBER(10,2);
        no_hay_datos EXCEPTION;
    
        CURSOR c_salario
        IS
            SELECT salary
              FROM hr_employees
             WHERE employee_id = p_codigo_empleado;
    
    BEGIN
        OPEN c_salario;
        FETCH c_salario INTO v_salario;
        IF c_salario%NOTFOUND THEN
            RAISE no_hay_datos;
        END IF;
        CLOSE c_salario;
    
        RETURN v_salario;
        
        EXCEPTION
            WHEN no_hay_datos THEN
                RETURN 'El empleado con el codigo: ' || p_codigo_empleado || ' no existe.';
            WHEN OTHERS THEN
                RETURN 'Ocurrido un error: ' || SQLERRM;
        
    END fn_salary;
    
    -- funcion que devuelve el departamento al que pertenece un empleado
    FUNCTION fn_department(p_codigo_empleado IN hr_employees.employee_id%TYPE)
    RETURN VARCHAR2
    IS    
        v_departamento VARCHAR2(100);
        no_hay_datos EXCEPTION;
    
        CURSOR c_departamento
        IS
            SELECT d.department_name departamento
              FROM hr_employees e, hr_departments d
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
    
    -- procedimiento que actualiza el aumentando de un porcentaje en el salario de los empleados aumentando de un departamento...
    PROCEDURE sp_up_salary_employees(p_codigo_departamento IN NUMBER, p_aumento IN NUMBER, p_resultado OUT VARCHAR2)
    IS
        v_monto NUMBER;
    
    BEGIN
    
        v_monto := p_aumento / 100;
        
        UPDATE hr_employees
           SET salary = salary * (1 + v_monto)
         WHERE department_id = p_codigo_departamento;
        COMMIT;
        
        p_resultado := 'Se actualizo con exito el aumento del salario en el departamento.';
        
        EXCEPTION
            WHEN OTHERS THEN
                p_resultado := 'Ocurrido un error: ' || SQLERRM;
        
    END sp_up_salary_employees;
        
    -- procedimiento que inserta un empleado
    PROCEDURE sp_add_employee(
        p_nombre_empleado IN hr_employees.first_name%TYPE,
        p_apellido_empleado IN hr_employees.last_name%TYPE,
        p_numero_telefono IN hr_employees.phone_number%TYPE,
        p_fecha_contrato IN hr_employees.hire_date%TYPE,
        p_puesto IN hr_jobs.job_title%TYPE,
        p_salario_empleado IN hr_employees.salary%TYPE,
        p_departamento IN hr_departments.department_name%TYPE,
        p_resultado OUT VARCHAR2
    )
    IS
        v_codigo_puesto hr_jobs.job_id%TYPE := NULL;
        v_codigo_departamento hr_departments.department_id%TYPE := NULL;
    BEGIN
        SELECT job_id INTO v_codigo_puesto FROM hr_jobs WHERE job_title = p_puesto;
        SELECT department_id INTO v_codigo_departamento FROM hr_departments WHERE department_name = p_departamento;
        
        INSERT INTO hr_employees(first_name, last_name, phone_number, hire_date, job_id, salary, department_id)
             VALUES(INITCAP(TRIM(p_nombre_empleado)), INITCAP(TRIM(p_apellido_empleado)), p_numero_telefono, TO_DATE(p_fecha_contrato,'DD/MM/RR'), v_codigo_puesto, p_salario_empleado, v_codigo_departamento);
        COMMIT;
        p_resultado := 'Se inserto correctamente el empleado: ' || INITCAP(TRIM(p_nombre_empleado)) || ' ' || INITCAP(TRIM(p_apellido_empleado));
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                IF v_codigo_puesto IS NULL THEN
                    p_resultado := 'No se inserto el empleado. No se encontro el puesto: ' || p_puesto;
                    ROLLBACK;
                ELSIF v_codigo_departamento IS NULL THEN
                    p_resultado := 'No se inserto el empleado. No se encontro el departamento: ' || p_departamento;
                    ROLLBACK;
                END IF;
            WHEN OTHERS THEN
                p_resultado := 'Ocurrido un error: ' || SQLERRM;
                ROLLBACK;
        
    END sp_add_employee;
    
    -- procedimiento que elimina un empleado
    PROCEDURE sp_remove_employee(p_codigo_empleado IN hr_employees.employee_id%TYPE, p_resultado OUT VARCHAR2)
    IS
    BEGIN
        DELETE FROM hr_employees
              WHERE employee_id = p_codigo_empleado;
        COMMIT;
        p_resultado := 'Se elimino correctamente el empleado.';
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                p_resultado := 'No se encontro el empleado a eliminar.';
            WHEN OTHERS THEN
                p_resultado := 'Ocurrido un error: ' || SQLERRM;
    
    END sp_remove_employee;
    
END hr_pk_employee;
/

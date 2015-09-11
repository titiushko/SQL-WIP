-- TRIGGER...

CREATE OR REPLACE TRIGGER trgAdicionRegInventario
BEFORE INSERT 
ON INVENTARIOS
FOR EACH ROW
BEGIN
	SELECT seqInventarios.NEXTVAL
	  INTO :new.correlativo
	  FROM dual;
END trgAdicionRegInventario;

CREATE OR REPLACE TRIGGER trgModificacionRegInventario
BEFORE UPDATE
ON INVENTARIOS
REFERENCING NEW AS new OLD AS old
FOR EACH ROW
BEGIN
	:new.fecha_mod := sysdate;
	:new.user_mod  := user;
END rgModificacionRegInventario;

-- PROCEDIMIENTOS...

create or replace procedure actualizar_salary
is
    vNuevoSalario   number(10,2);
    
    cursor cEmoleaods is
        select salary, employee_id
          from employees
         where department_id = 20;
         
begin
    for x in cEmoleados loop
        vNuevoSalario := 0;
        vNuevoSalario := x.salary*1.10;
        
        update employees
           set salary = vNuevoSalario
         where employee_id = x.employee_id;
         
    end loop;
end actualizar_salary;

create or replace procedure actualizar_salary(codigoDep in number)
is
    vNuevoSalario   number(10,2);
    
    cursor cEmoleaods is
        select salary, employee_id
          from employees
         where department_id = codigoDep;
         
begin
    for x in cEmoleados loop
        vNuevoSalario := 0;
        vNuevoSalario := x.salary*1.10;
        
        update employees
           set salary = vNuevoSalario
         where employee_id = x.employee_id;
                  
    end loop;
end actualizar_salary;

-- --------------------------------------------------------------------------------

-- FUNCIONES...

create or replace function nombre_empleado(codigoEmp in number)
return varchar2
is
    vNombre varchar2(100);
begin
    select first_name || ' ' || second_name
      into vNombre
      from employees
     where employee_id = codigoEmp;
     
     return vNombre;
end nombre_empleado;

create or replace function nombre_empleado(codigoEmp in number)
return varchar2
is
    vNombre varchar2(100);
    
    cursor nombre is
        select first_name || ' ' || second_name nombre_emp
          from employees
         where employee_id = codigoEmp;
         
begin
    for x in nombre loop
        vNombre := x.nombre_emp;
    end loop;
     
     return vNombre;
end nombre_empleado;

create or replace function nombre_empleado(codigoEmp in number)
return varchar2
is
    vNombre varchar2(100);
    
    cursor nombre is
        select first_name || ' ' || second_name nombre_emp
          from employees
         where employee_id = codigoEmp;
         
begin
    open nombre;    
    fetch nombre into vNombre;
    close nombre;
     
     return vNombre;
end nombre_empleado;

create or replace function nombre_empleado(codigoEmp in number)
return varchar2
is
    vNombre varchar2(100);
    vSalary number(10,2);
    
    cursor nombre (cod_emp in number) is
        select first_name || ' ' || second_name nombre_emp, salary
          from employees
         where employee_id = cod_emp;
         
begin
    open nombre(codigoEmp);    
    fetch nombre into vNombre, vSalary;
    close nombre;
     
     return vNombre;
end nombre_empleado;

create or replace function nombre_empleado(codigoEmp in number)
return varchar2
is
    vNombre varchar2(100);     
         
begin
    select first_name || ' ' || second_name nombre_emp
      into vNombre
      from employees
     where employee_id = codEmp;
     
     return vNombre;
     
     exception
        when no_data_found then
            return 'Empleado no existe';
        when others then
            return 'Error es:' || SQLERRM;
end nombre_empleado;

-- --------------------------------------------------------------------------------

-- PAQUETES...

-- spec...
create or replace package prueba
is
    function nombreEmp(codigoEmp in number)
    return varchar2;    
end prueba;  

-- body...
create or replace package body prueba
is
    function nombreEmp(codigoEmp in number)
    return varchar2
    
    is
        vNombre varchar2(100);
        
        cursor nombre is
        select first_name || ' ' || second_name nombre_emp
          from employees
         where employee_id = codigoEmp;
    
    begin
        open nombre(codEmp);    
        fetch nombre into vNombre;
        close nombre;
    end nombreEmp;
    
end prueba;

-- llamar una funcion que no esta en un paquete...
vNombre := nombreEmp(1);

-- llamar una funcion que esta en un paquete...
vNombre := prueba.nombreEmp(1);

--
CREATE OR REPLACE PACKAGE pEmpleados
IS
    -- funcion que devuelve el email de un empleado
    FUNCTION fEmailEmpleado(codigo_empleado IN NUMBER)
    RETURN VARCHAR2;
    
    -- funcion que devuelve el salario de un empleado
    FUNCTION fSalarioEmpleado(codigo_empleado IN NUMBER)
    RETURN NUMBER;
    
    -- procedimiento que actualiza el salario de los empleados aumentando un porcentaje, para un departamento...
    PROCEDURE pActualizarSalario(codigo_departamento IN NUMBER, aumento IN NUMBER, resultado OUT VARCHAR2);
    
END pEmpleados;

CREATE OR REPLACE PACKAGE BODY pEmpleados
IS
    -- funcion que devuelve el email de un empleado
    FUNCTION fEmailEmpleado(codigo_empleado IN NUMBER)
    RETURN VARCHAR2
    IS    
        vEmail VARCHAR2(100);
    
        CURSOR cEmail
        IS
            SELECT email
              FROM employees
             WHERE employee_id = codigo_empleado;
    
    BEGIN
        OPEN cEmail;
        FETCH cEmail INTO vEmail;
        CLOSE cEmail;
    
        RETURN vEmail;
        
        EXCEPTION
        WHEN no_data_found THEN
            RETURN 'Empleado no existe';
        WHEN others THEN
            RETURN 'Error es:' || SQLERRM;
        
    END fEmailEmpleado;
    
    -- funcion que devuelve el salario de un empleado
    FUNCTION fSalarioEmpleado(codigo_empleado IN NUMBER)
    RETURN NUMBER
    IS    
        vSalario NUMBER(10,2);
    
        CURSOR cSalario
        IS
            SELECT salary
              FROM employees
             WHERE employee_id = codigo_empleado;
    
    BEGIN
        OPEN cSalario;
        FETCH cSalario INTO vSalario;
        CLOSE cSalario;
    
        RETURN vSalario;
        
        EXCEPTION
        WHEN no_data_found THEN
            RETURN 'Empleado no existe';
        WHEN others THEN
            RETURN 'Error es:' || SQLERRM;
        
    END fSalarioEmpleado;    
    
    -- procedimiento que actualiza el salario de los empleados aumentando un porcentaje, para un departamento...
    PROCEDURE pActualizarSalario(codigo_departamento IN NUMBER, aumento IN NUMBER, resultado OUT VARCHAR2)
    IS
        vMonto NUMBER;
    
    BEGIN
    
        vMonto := aumento/100;
        
        UPDATE employees
           SET salary = salary*(1+vMonto)
         WHERE department_id = codigo_departamento;    
        COMMIT;
        
        resultado := 'Se actualizo con exito el aumneto del salario en el departamento';
        
        EXCEPTION
        WHEN OTHERS THEN
            resultado := 'No se actualizo, el error es:' || SQLERRM;
    END pActualizarSalario;
    
END pEmpleados;

-- --------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION func_NombreEmpleado(codigo_empleado IN NUMBER) RETURN VARCHAR2 IS
	nombre_completo VARCHAR2(30);
	
	CURSOR cur_NombreEmpleado IS
		SELECT first_name || ' ' || second_name
		  FROM employees
		 WHERE employee_id = codigo_empleado;
BEGIN
	OPEN cur_NombreEmpleado;
	FETCH cur_NombreEmpleado INTO nombre_completo;
	CLOSE cur_NombreEmpleado;
	
	RETURN nombre_completo;
	
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		RETURN 'No hay datos';
	WHEN OTHERS THEN
		RETURN 'Ocurrio un error' || SQLERRM;
	
END func_NombreEmpleado;
--
CREATE OR REPLACE FUNCTION func_NombreEmpleado(codigo_empleado IN NUMBER) RETURN VARCHAR2 IS
	nombre_completo VARCHAR2(30);
		
BEGIN
	SELECT first_name || ' ' || last_name
	  INTO nombre_completo
	  FROM employees
	 WHERE employee_id = codigo_empleado;
	
	RETURN nombre_completo;
	
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		RETURN 'No hay datos';
	WHEN OTHERS THEN
		RETURN 'Ocurrio un error' || SQLERRM;
	
END func_NombreEmpleado;
--
CREATE OR REPLACE PROCEDURE proc_InsertarEmpleado(nombre IN VARCHAR2, apellido IN VARCHAR2, correo IN VARCHAR2, telefono IN VARCHAR2, fecha_contrato IN DATE, salario IN NUMBER, nombre_departamento IN VARCHAR2) IS
	codigo_empleado NUMBER;
	codigo_departamento NUMBER;
BEGIN
	SELECT MAX(employee_id) + 1
	  INTO codigo_empleado
	  FROM employees;
	
	SELECT department_id
	  INTO codigo_departamento
	  FROM department
	 WHERE department_name = nombre_departamento;
	
	INSERT INTO employees(employee_id, first_name, second_name, email, phone_number, hire_date, salary, department_id)
	VALUES(codigo_empleado, nombre, apellido, correo, telefono, fecha_contrato, salario, codigo_departamento);
	COMMIT;
END proc_InsertarEmpleado;
--
CREATE OR REPLACE TRIGGER trig_VerificarSalario BEFORE INSERT OR UPDATE OF salary ON employees
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
BEGIN	
	IF :NEW.salary = 0 THEN
		dbms_output.put_line('No es posible asignar a un empleado salario cero.');
		IF INSERTING THEN
			dbms_output.put_line('Se detuvo la insercion.');
		ELSIF UPDATING THEN
			dbms_output.put_line('Se detuvo la actualizacion.');
		END IF;
	ELSE
		dbms_output.put_line('Se asigno a un empleado salario distinto de cero.');
	END IF;
END trig_VerificarSalario;
/*
declare
    resultado varchar2(100);
begin
    hr_pk_employee.sp_add_employee('javier  ','  francisco','12345678',trunc(sysdate),'Programmer',123.321,'IT',resultado);
    DBMS_OUTPUT.put_line(resultado);
end;
*/
--
/*
declare
    resultado varchar2(100);
begin
    hr_pk_employee.sp_up_salary_employees('ga',-10,resultado);
    DBMS_OUTPUT.put_line(resultado);
end;
*/
--
declare
    codigo_empleado hr_employees.employee_id%TYPE := hr_pk_employee.fn_employee_id;
begin
    DBMS_OUTPUT.put_line('CODIGO: ' || codigo_empleado);
    DBMS_OUTPUT.put_line('NOMBRE: ' || hr_pk_employee.fn_full_name(codigo_empleado));
    DBMS_OUTPUT.put_line('CORREO: ' || hr_pk_employee.fn_email(codigo_empleado));
    DBMS_OUTPUT.put_line('TELEFONO: ' || hr_pk_employee.fn_phone_number(codigo_empleado));
    DBMS_OUTPUT.put_line('FECHA CONTRATO: ' || hr_pk_employee.fn_hire_date(codigo_empleado));
    DBMS_OUTPUT.put_line('PUESTO: ' || hr_pk_employee.fn_job(codigo_empleado));
    DBMS_OUTPUT.put_line('SALARIO: ' || hr_pk_employee.fn_salary(codigo_empleado));
    DBMS_OUTPUT.put_line('DEPARTAMENTO: ' || hr_pk_employee.fn_department(codigo_empleado));
end;
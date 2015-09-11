-- JOIN ENTRE TABLAS
select a.employee_id, a.first_name, a.second_name, a.salary, 
       b.department_name
  from employees a, department b
 where b.department_id = a.department_id

-- EMPLEADOS DEPARTAMENTO IT O DEPARTAMENTO FINANZAS
select a.employee_id, a.first_name, a.second_name, a.salary, a.department_id, 
       b.department_name
  from employees a, department b
 where b.department_id = a.department_id 
   and ( a.department_id = 60 or a.department_id = 100 )
 
-- EMPLEADOS QUE NO TENGAN EMAIL
select a.employee_id, a.first_name, a.second_name, a.salary, a.email, b.department_name
  from employees a, department b
 where a.department_id = b.department_id
   and a.email is null

-- EMPLEADOS QUE TENGAN EMAIL
select a.employee_id, a.first_name, a.second_name, a.salary, a.email, b.department_name
  from employees a, department b
 where a.department_id = b.department_id
   and a.email is not null

-- EMPLEADOS CUYO SALARIO SEA MAYOR A 7500
select a.employee_id, a.first_name, a.second_name, a.salary, b.department_name
  from employees a, department b
 where a.department_id = b.department_id
   and a.salary > 7500

-- EMPLEADOS CUYO SALARIO SEA MENOR O IGUAL A 2100
select a.employee_id, a.first_name, a.second_name, a.salary, b.department_name
  from employees a, department b
 where a.department_id = b.department_id
   and a.salary <= 2100

-- EMPLEADOS QUE PERTENEZCAN AL DEPARTAMENTO IT Y FINANZAS (USANDO IN)
select a.employee_id, a.first_name, a.second_name, a.salary, b.department_name
  from employees a, department b
 where a.department_id = b.department_id
   and b.department_id in (60,100)

-- EMPLEADOS QUE NO OPERTENEZCAN AL DEPARTAMENTO IT 
select a.employee_id, a.first_name, a.second_name, a.salary, b.department_name
  from employees a, department b
 where a.department_id = b.department_id
   and b.department_id not in (60)
   
-- MOSTRAR LOS EMPLEADOS QUE EXISTEN POR DEPARTAMENTO
select b.department_name departamento, count(*) cantidad_empleados
  from employees a, department b
 where a.department_id = b.department_id
 group by b.department_name

-- MOSTRAR LOS EMPLEADOS DE LOS DEPARTAMENTOS DONDE SEAN MAS DE 15 EMPLEADOS
select b.department_name departamento, count(*) cantidad_empleados
  from employees a, department b
 where a.department_id = b.department_id
 group by b.department_name
having count(*) > 15

-- MOSTRAR CUANTO SUMAN LOS SALARIOS DE TODOS LOS EMPLEADOS POR DEPARTAMENTO
select b.department_name departamento, sum(a.salary) suma_salarios
  from employees a, department b
 where a.department_id = b.department_id
 group by b.department_name
 
select dos.departamento, dos.suma, uno.salario_total
  from (
        select sum(x.salary) salario_total
          from employees x    
       ) uno, 
       (
        select b.department_name departamento, sum(a.salary) suma
          from employees a, department b
         where a.department_id = b.department_id
         group by b.department_name
       ) dos

-- USO DE MIN, MAX, AVG 
select min(salary) from employees
select max(salary) from employees
select avg(salary) from employees
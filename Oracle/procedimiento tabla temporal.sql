create or replace procedure prPromedio authid current_user
as
stmt varchar2(1000);
begin
stmt:= 'CREATE GLOBAL TEMPORARY TABLE promedio_temp 
    ON COMMIT PRESERVE ROWS  
   AS
  select co.country_name pais, d.department_name departamento, round(avg(e.salary),2) promedio
  from employees e inner join departments d
    on e.department_id = d.department_id
    inner join locations l
    on d.location_id = l.location_id
    inner join countries co 
    on l.country_id = co.country_id
  WHERE d.department_id = e.department_id
  group by co.country_name, d.department_name'; 
  execute immediate stmt;
end;
/*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
--TABLES
/*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
/*======================================*/
--HR_REGIONS
/*======================================*/
CREATE TABLE hr_regions(
	region_id	NUMBER CONSTRAINT region_id_nn NOT NULL,
	region_name	VARCHAR2(25)
);
--
CREATE UNIQUE INDEX hr_reg_id_pk ON hr_regions(region_id);
--
ALTER TABLE hr_regions ADD(
	CONSTRAINT hr_reg_id_pk PRIMARY KEY(region_id)
);
--
COMMENT ON TABLE hr_regions IS 'Tabla de Regiones que contiene los números de región y nombres. Contiene 4 filas, referencias con la tabla de países.';
COMMENT ON COLUMN hr_regions.region_id IS 'La clave principal de la tabla de regiones.';
COMMENT ON COLUMN hr_regions.region_name IS 'Nombres de regiones. Las ubicaciones son en los países de esas regiones.';
--
/*======================================*/
--HR_COUNTRIES
/*======================================*/
CREATE TABLE hr_countries(
	country_id		CHAR(2) CONSTRAINT country_id_nn NOT NULL,
    country_name	VARCHAR2(40),
    region_id		NUMBER,
    CONSTRAINT hr_country_c_id_pk PRIMARY KEY(country_id)
) ORGANIZATION INDEX;

COMMENT ON TABLE hr_countries IS 'Tabla de países. Contiene 25 filas. Referencias con tabla de ubicaciones.';
COMMENT ON COLUMN hr_countries.country_id IS 'La clave principal de la tabla de países.';
COMMENT ON COLUMN hr_countries.country_name IS 'Nombre del país.';
COMMENT ON COLUMN hr_countries.region_id IS 'ID Región para el país. Clave externa para la columna region_id en la tabla de departamentos.';
--
/*======================================*/
--HR_LOCATIONS
/*======================================*/
CREATE TABLE hr_locations(
	location_id		NUMBER(4),
	street_address	VARCHAR2(40),
	postal_code		VARCHAR2(12),
	city			VARCHAR2(30) CONSTRAINT loc_city_nn NOT NULL,
	state_province	VARCHAR2(25),
	country_id		CHAR(2)
    );
--
CREATE UNIQUE INDEX hr_loc_id_pk ON hr_locations(location_id);
--
ALTER TABLE hr_locations ADD(
	CONSTRAINT hr_loc_id_pk PRIMARY KEY(location_id)
);
--
COMMENT ON TABLE hr_locations IS 'Tabla de localizaciones que contiene la dirección específica de una oficina específica, almacén y / o centro de producción de una empresa. No almacena direcciones / ubicaciones de los clientes. Contiene 23 filas, con referencia a los departamentos y tablas países.';
COMMENT ON COLUMN hr_locations.location_id IS 'La clave principal de la tabla de ubicaciones.';
COMMENT ON COLUMN hr_locations.street_address IS 'Dirección de la calle de una oficina, almacén o centro de producción de una empresa. Contiene edificio número y el nombre de la calle.';
COMMENT ON COLUMN hr_locations.postal_code IS 'Código postal de la ubicación de una oficina, almacén o centro de producción de una empresa.';
COMMENT ON COLUMN hr_locations.city IS 'Una columna no nula que muestra la ciudad en donde se encuentra una oficina, almacén o centro de producción de una empresa.';
COMMENT ON COLUMN hr_locations.state_province IS 'Estado o provincia donde se encuentra una oficina, almacén o centro de producción de una empresa.';
COMMENT ON COLUMN hr_locations.country_id IS 'País donde se encuentra una oficina, almacén o centro de producción de una empresa. Clave externa para la columna country_id de la tabla países.';
--
/*======================================*/
--HR_DEPARTMENTS
/*======================================*/
CREATE TABLE hr_departments(
	department_id	NUMBER(4),
	department_name	VARCHAR2(30) CONSTRAINT dept_name_nn NOT NULL,
	manager_id		NUMBER(6),
	location_id		NUMBER(4)
);
--
CREATE UNIQUE INDEX hr_dept_id_pk ON hr_departments(department_id);
--
ALTER TABLE hr_departments ADD(
	CONSTRAINT hr_dept_id_pk PRIMARY KEY(department_id)
);
--
COMMENT ON TABLE hr_departments IS 'Tabla de departamentos que muestra los detalles de los departamentos donde trabajan los empleados. Contiene 27 filas, referencias, con locales, empleados y la tabla job_history.';
COMMENT ON COLUMN hr_departments.department_id IS 'Columna de clave primaria de la tabla de departamentos.';
COMMENT ON COLUMN hr_departments.department_name IS 'Una columna no nula que muestra el nombre de un departamento. Administración, Marketing, Compras, Recursos Humanos, Transporte marítimo, IT, ejecutivos, relaciones públicas, ventas, finanzas y contabilidad.';
COMMENT ON COLUMN hr_departments.manager_id IS 'MANAGER_ID de un departamento. Clave externa para la columna employee_id de tabla de empleados. La columna manager_id de los empleados referencias de tabla esta columna.';
COMMENT ON COLUMN hr_departments.location_id IS 'Ubicación id donde se encuentra un departamento. Clave externa para la columna de tabla location_id lugares.';
--
/*======================================*/
--HR_JOBS
/*======================================*/
CREATE TABLE hr_jobs(
	job_id		VARCHAR2(10),
	job_title	VARCHAR2(35) CONSTRAINT job_title_nn NOT NULL,
	min_salary	NUMBER(6),
	max_salary	NUMBER(6)
);
--
CREATE UNIQUE INDEX hr_job_id_pk ON hr_jobs(job_id);
--
ALTER TABLE hr_jobs ADD(
	CONSTRAINT hr_job_id_pk PRIMARY KEY(job_id)
);
--
COMMENT ON TABLE hr_jobs IS 'Tabla de trabajo con los títulos de los puestos y rangos salariales. Contiene 19 filas. Referencias con los empleados y tabla job_history.';
COMMENT ON COLUMN hr_jobs.job_id IS 'La clave principal de la tabla de trabajos.';
COMMENT ON COLUMN hr_jobs.job_title IS 'Una columna no nula de que se ve el título de trabajo, por ejemplo, AD_VP, FI_ACCOUNTANT.';
COMMENT ON COLUMN hr_jobs.min_salary IS 'Salario mínimo para un puesto de trabajo.';
COMMENT ON COLUMN hr_jobs.max_salary IS 'Salario máximo para un puesto de trabajo.';
--
/*======================================*/
--HR_EMPLOYEES
/*======================================*/
CREATE TABLE hr_employees(
	employee_id		NUMBER(6),
	first_name		VARCHAR2(20),
	last_name		VARCHAR2(25) CONSTRAINT emp_last_name_nn NOT NULL,
	email			VARCHAR2(25) CONSTRAINT emp_email_nn NOT NULL,
	phone_number	VARCHAR2(20),
	hire_date		DATE CONSTRAINT emp_hire_date_nn NOT NULL,
	job_id			VARCHAR2(10) CONSTRAINT emp_job_nn NOT NULL,
	salary			NUMBER(8,2),
	commission_pct	NUMBER(2,2),
	manager_id		NUMBER(6),
	department_id	NUMBER(4),
	CONSTRAINT emp_salary_min CHECK(salary > 0),
	CONSTRAINT emp_email_uk UNIQUE(email)
);
--
CREATE UNIQUE INDEX hr_emp_emp_id_pk ON hr_employees(employee_id);
--
ALTER TABLE hr_employees ADD(
	CONSTRAINT hr_emp_emp_id_pk PRIMARY KEY(employee_id)
);
--
COMMENT ON TABLE hr_employees IS 'Los empleados de tabla. Contiene 107 filas. Referencias con departamentos, puestos de trabajo, tablas job_history. Contiene una referencia propia.';
COMMENT ON COLUMN hr_employees.employee_id IS 'La clave principal de la tabla de empleados.';
COMMENT ON COLUMN hr_employees.first_name IS 'Nombre del empleado. Una columna no es nula.';
COMMENT ON COLUMN hr_employees.last_name IS 'Apellido del empleado. Una columna no es nula.';
COMMENT ON COLUMN hr_employees.email IS 'Identificación del email del empleado.';
COMMENT ON COLUMN hr_employees.phone_number IS 'El número telefónico del empleado; incluye código de país y código de área.';
COMMENT ON COLUMN hr_employees.hire_date IS 'Fecha en que el empleado comenzó en este trabajo. Una columna no es nula.';
COMMENT ON COLUMN hr_employees.job_id IS 'Trabajo actual del empleado, clave externa a la columna job_id de la tabla de trabajos. Una columna no es nula.';
COMMENT ON COLUMN hr_employees.salary IS 'Salario mensual del empleado. Debe ser mayor que cero (impuesto por el emp_salary_min restricción).';
COMMENT ON COLUMN hr_employees.commission_pct IS 'Porcentaje de comisión del empleado; Sólo los empleados del departamento de ventas elegible para el porcentaje de comisión.';
COMMENT ON COLUMN hr_employees.manager_id IS 'Identificación del gerente del empleado, tiene el mismo dominio que MANAGER_ID en la tabla departamentos. Clave externa para la columna employee_id de tabla de empleados. (útil para reflexiva uniones y CONNECT BY consulta).';
COMMENT ON COLUMN hr_employees.department_id IS 'Departamento id donde trabaja el empleado, clave externa a la columna department_id de la tabla departamentos.';
--
/*======================================*/
--HR_JOB_HISTORY
/*======================================*/
CREATE TABLE hr_job_history(
	employee_id		NUMBER(6) CONSTRAINT jhist_employee_nn NOT NULL,
	start_date		DATE CONSTRAINT jhist_start_date_nn NOT NULL,
	end_date		DATE CONSTRAINT jhist_end_date_nn NOT NULL,
	job_id			VARCHAR2(10) CONSTRAINT jhist_job_nn NOT NULL,
	department_id	NUMBER(4),
	CONSTRAINT jhist_date_interval CHECK(end_date > start_date)
);
--
CREATE UNIQUE INDEX hr_jhist_emp_id_st_date_pk ON hr_job_history(employee_id, start_date);
--
ALTER TABLE hr_job_history ADD(
	CONSTRAINT hr_jhist_emp_id_st_date_pk PRIMARY KEY(employee_id, start_date)
);
--
COMMENT ON TABLE hr_job_history IS 'Tabla que almacena la historia laboral de los empleados. Si un empleado cambia departamentos del trabajo o cambia de trabajo dentro del departamento, las nuevas filas quedan insertados en esta tabla con la información viejo trabajo del empleado. Contiene una clave principal compleja: employee_id + start_date. Contiene 25 filas. Referencias con puestos de trabajo, los empleados, y las tablas de departamentos.';
COMMENT ON COLUMN hr_job_history.employee_id IS 'Una columna no es nula en el complejo employee_id clave principal + start_date. Clave externa para la columna employee_id de la tabla de empleados.';
COMMENT ON COLUMN hr_job_history.start_date IS 'Una columna no es nula en el complejo employee_id clave principal + start_date. Debe ser menor que el end_date de la tabla job_history. (impuesto por el jhist_date_interval restricción).';
COMMENT ON COLUMN hr_job_history.end_date IS 'Último día del empleado en este puesto de trabajo. Una columna no es nula. Debe ser mayor que el start_date de la tabla job_history. (impuesto por el jhist_date_interval restricción).';
COMMENT ON COLUMN hr_job_history.job_id IS 'Puesto de trabajo en la que el empleado trabajó en el pasado, clave externa a la columna job_id de la tabla jobs. Una columna no es nula.';
COMMENT ON COLUMN hr_job_history.department_id IS 'Identificación del Departamento en la que el empleado trabajó en el pasado, clave externa a la columna deparment_id en la tabla de departamentos.';
--
CREATE OR REPLACE PROCEDURE hr_sp_add_job_history(
	p_emp_id		hr_job_history.employee_id%TYPE,
	p_start_date	hr_job_history.start_date%TYPE,
	p_end_date		hr_job_history.end_date%TYPE,
	p_job_id		hr_job_history.job_id%TYPE,
	p_department_id	hr_job_history.department_id%TYPE
)
IS
BEGIN
	INSERT INTO hr_job_history(employee_id, start_date, end_date, job_id, department_id)
	VALUES(p_emp_id, p_start_date, p_end_date, p_job_id, p_department_id);
END hr_sp_add_job_history;
--
CREATE OR REPLACE TRIGGER hr_tr_update_job_history
	AFTER UPDATE OF job_id, department_id
	ON hr_employees
	FOR EACH ROW
BEGIN
	hr_sp_add_job_history(:OLD.employee_id,:OLD.hire_date,SYSDATE,:OLD.job_id,:OLD.department_id);
END;
--
/*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
--VIEWS
/*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
CREATE OR REPLACE VIEW hr_emp_details_view(
	employee_id,
	job_id,
	manager_id,
	department_id,
	location_id,
	country_id,
	first_name,
	last_name,
	salary,
	commission_pct,
	department_name,
	job_title,
	city,
	state_province,
	country_name,
	region_name
)
AS
SELECT e.employee_id,
	   e.job_id,
	   e.manager_id,
	   e.department_id,
	   d.location_id,
	   l.country_id,
	   e.first_name,
	   e.last_name,
	   e.salary,
	   e.commission_pct,
	   d.department_name,
	   j.job_title,
	   l.city,
	   l.state_province,
	   c.country_name,
	   r.region_name
  FROM hr_employees e,
	   hr_departments d,
	   hr_jobs j,
	   hr_locations l,
	   hr_countries c,
	   hr_regions r
 WHERE e.department_id = d.department_id
   AND d.location_id = l.location_id
   AND l.country_id = c.country_id
   AND c.region_id = r.region_id
   AND j.job_id = e.job_id
WITH READ ONLY;
--
/*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
--INDEXS
/*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
CREATE INDEX hr_emp_department_ix ON hr_employees(department_id);
CREATE INDEX hr_emp_job_ix ON hr_employees(job_id);
CREATE INDEX hr_emp_manager_ix ON hr_employees(manager_id);
CREATE INDEX hr_emp_name_ix ON hr_employees(last_name, first_name);
CREATE INDEX hr_dept_location_ix ON hr_departments(location_id);
CREATE INDEX hr_jhist_job_ix ON hr_job_history(job_id);
CREATE INDEX hr_jhist_employee_ix ON hr_job_history(employee_id);
CREATE INDEX hr_jhist_department_ix ON hr_job_history(department_id);
CREATE INDEX hr_loc_city_ix ON hr_locations(city);
CREATE INDEX hr_loc_state_province_ix ON hr_locations(state_province);
CREATE INDEX hr_loc_country_ix ON hr_locations(country_id);
--
/*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
--CONSTRAINTS
/*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
ALTER TABLE hr_countries ADD(
    CONSTRAINT hr_countr_reg_fk FOREIGN KEY(region_id) REFERENCES hr_regions(region_id)
);
--
ALTER TABLE hr_locations ADD(
    CONSTRAINT hr_loc_c_id_fk FOREIGN KEY(country_id) REFERENCES hr_countries(country_id)
);
--
ALTER TABLE hr_employees ADD(
    CONSTRAINT hr_emp_dept_fk FOREIGN KEY(department_id) REFERENCES hr_departments(department_id),
    CONSTRAINT hr_emp_job_fk FOREIGN KEY(job_id) REFERENCES hr_jobs(job_id),
    CONSTRAINT hr_emp_manager_fk FOREIGN KEY(manager_id) REFERENCES hr_employees(employee_id)
);
--
ALTER TABLE hr_departments ADD(
    CONSTRAINT hr_dept_loc_fk FOREIGN KEY(location_id) REFERENCES hr_locations(location_id),
    CONSTRAINT hr_dept_mgr_fk FOREIGN KEY(manager_id) REFERENCES hr_employees(employee_id)
);
--
ALTER TABLE hr_job_history ADD(
    CONSTRAINT hr_jhist_job_fk FOREIGN KEY(job_id) REFERENCES hr_jobs(job_id),
    CONSTRAINT hr_jhist_emp_fk FOREIGN KEY(employee_id) REFERENCES hr_employees(employee_id),
    CONSTRAINT hr_jhist_dept_fk FOREIGN KEY(department_id) REFERENCES hr_departments(department_id)
);
--
/*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
--INSERTS
/*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
ALTER TABLE hr_departments DISABLE CONSTRAINT hr_dept_mgr_fk;
ALTER TABLE hr_departments DISABLE CONSTRAINT hr_dept_loc_fk;
ALTER TABLE hr_employees DISABLE CONSTRAINT hr_emp_dept_fk;
ALTER TABLE hr_employees DISABLE CONSTRAINT hr_emp_job_fk;
ALTER TABLE hr_employees DISABLE CONSTRAINT hr_emp_manager_fk;
ALTER TABLE hr_job_history DISABLE CONSTRAINT hr_jhist_dept_fk;
ALTER TABLE hr_job_history DISABLE CONSTRAINT hr_jhist_emp_fk;
ALTER TABLE hr_job_history DISABLE CONSTRAINT hr_jhist_job_fk;
--
/*======================================*/
--HR_REGIONS
/*======================================*/
INSERT INTO hr_regions VALUES(1, 'Europe');
INSERT INTO hr_regions VALUES(2, 'Americas');
INSERT INTO hr_regions VALUES(3, 'Asia');
INSERT INTO hr_regions VALUES(4, 'Middle East and Africa');
--
/*======================================*/
--HR_COUNTRIES
/*======================================*/
INSERT INTO hr_countries VALUES('IT', 'Italy', 1);
INSERT INTO hr_countries VALUES('JP', 'Japan', 3);
INSERT INTO hr_countries VALUES('US', 'United States of America', 2);
INSERT INTO hr_countries VALUES('CA', 'Canada', 2);
INSERT INTO hr_countries VALUES('CN', 'China', 3);
INSERT INTO hr_countries VALUES('IN', 'India', 3);
INSERT INTO hr_countries VALUES('AU', 'Australia', 3);
INSERT INTO hr_countries VALUES('ZW', 'Zimbabwe', 4);
INSERT INTO hr_countries VALUES('SG', 'Singapore', 3);
INSERT INTO hr_countries VALUES('UK', 'United Kingdom', 1);
INSERT INTO hr_countries VALUES('FR', 'France', 1);
INSERT INTO hr_countries VALUES('DE', 'Germany', 1);
INSERT INTO hr_countries VALUES('ZM', 'Zambia', 4);
INSERT INTO hr_countries VALUES('EG', 'Egypt', 4);
INSERT INTO hr_countries VALUES('BR', 'Brazil', 2);
INSERT INTO hr_countries VALUES('CH', 'Switzerland', 1);
INSERT INTO hr_countries VALUES('NL', 'Netherlands', 1);
INSERT INTO hr_countries VALUES('MX', 'Mexico', 2);
INSERT INTO hr_countries VALUES('KW', 'Kuwait', 4);
INSERT INTO hr_countries VALUES('IL', 'Israel', 4);
INSERT INTO hr_countries VALUES('DK', 'Denmark', 1);
INSERT INTO hr_countries VALUES('HK', 'HongKong', 3);
INSERT INTO hr_countries VALUES('NG', 'Nigeria', 4);
INSERT INTO hr_countries VALUES('AR', 'Argentina', 2);
INSERT INTO hr_countries VALUES('BE', 'Belgium', 1);
--
/*======================================*/
--HR_LOCATIONS
/*======================================*/
INSERT INTO hr_locations VALUES(1000, '1297 Via Cola di Rie', '00989', 'Roma', NULL, 'IT');
INSERT INTO hr_locations VALUES(1100, '93091 Calle della Testa', '10934', 'Venice', NULL, 'IT');
INSERT INTO hr_locations VALUES(1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP');
INSERT INTO hr_locations VALUES(1300, '9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 'JP');
INSERT INTO hr_locations VALUES(1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');
INSERT INTO hr_locations VALUES(1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US');
INSERT INTO hr_locations VALUES(1600, '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US');
INSERT INTO hr_locations VALUES(1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US');
INSERT INTO hr_locations VALUES(1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA');
INSERT INTO hr_locations VALUES(1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA');
INSERT INTO hr_locations VALUES(2000, '40-5-12 Laogianggen', '190518', 'Beijing', NULL, 'CN');
INSERT INTO hr_locations VALUES(2100, '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN');
INSERT INTO hr_locations VALUES(2200, '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU');
INSERT INTO hr_locations VALUES(2300, '198 Clementi North', '540198', 'Singapore', NULL, 'SG');
INSERT INTO hr_locations VALUES(2400, '8204 Arthur St', NULL, 'London', NULL, 'UK');
INSERT INTO hr_locations VALUES(2500, 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK');
INSERT INTO hr_locations VALUES(2600, '9702 Chester Road', '09629850293', 'Stretford', 'Manchester', 'UK');
INSERT INTO hr_locations VALUES(2700, 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE');
INSERT INTO hr_locations VALUES(2800, 'Rua Frei Caneca 1360 ', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR');
INSERT INTO hr_locations VALUES(2900, '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH');
INSERT INTO hr_locations VALUES(3000, 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH');
INSERT INTO hr_locations VALUES(3100, 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL');
INSERT INTO hr_locations VALUES(3200, 'Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal,', 'MX');
--
/*======================================*/
--HR_DEPARTMENTS
/*======================================*/
INSERT INTO hr_departments VALUES(10, 'Administration', 200, 1700);
INSERT INTO hr_departments VALUES(20, 'Marketing', 201, 1800);
INSERT INTO hr_departments VALUES(30, 'Purchasing', 114, 1700);
INSERT INTO hr_departments VALUES(40, 'Human Resources', 203, 2400);
INSERT INTO hr_departments VALUES(50, 'Shipping', 121, 1500);
INSERT INTO hr_departments VALUES(60, 'IT', 103, 1400);
INSERT INTO hr_departments VALUES(70, 'Public Relations', 204, 2700);
INSERT INTO hr_departments VALUES(80, 'Sales', 145, 2500);
INSERT INTO hr_departments VALUES(90, 'Executive', 100, 1700);
INSERT INTO hr_departments VALUES(100, 'Finance', 108, 1700);
INSERT INTO hr_departments VALUES(110, 'Accounting', 205, 1700);
INSERT INTO hr_departments VALUES(120, 'Treasury', NULL, 1700);
INSERT INTO hr_departments VALUES(130, 'Corporate Tax', NULL, 1700);
INSERT INTO hr_departments VALUES(140, 'Control And Credit', NULL, 1700);
INSERT INTO hr_departments VALUES(150, 'Shareholder Services', NULL, 1700);
INSERT INTO hr_departments VALUES(160, 'Benefits', NULL, 1700);
INSERT INTO hr_departments VALUES(170, 'Manufacturing', NULL, 1700);
INSERT INTO hr_departments VALUES(180, 'Construction', NULL, 1700);
INSERT INTO hr_departments VALUES(190, 'Contracting', NULL, 1700);
INSERT INTO hr_departments VALUES(200, 'Operations', NULL, 1700);
INSERT INTO hr_departments VALUES(210, 'IT Support', NULL, 1700);
INSERT INTO hr_departments VALUES(220, 'NOC', NULL, 1700);
INSERT INTO hr_departments VALUES(230, 'IT Helpdesk', NULL, 1700);
INSERT INTO hr_departments VALUES(240, 'Government Sales', NULL, 1700);
INSERT INTO hr_departments VALUES(250, 'Retail Sales', NULL, 1700);
INSERT INTO hr_departments VALUES(260, 'Recruiting', NULL, 1700);
INSERT INTO hr_departments VALUES(270, 'Payroll', NULL, 1700);
--
/*======================================*/
--HR_JOBS
/*======================================*/
INSERT INTO hr_jobs VALUES('AD_PRES', 'President', 20000, 40000);
INSERT INTO hr_jobs VALUES('AD_VP', 'Administration Vice President', 15000, 30000);
INSERT INTO hr_jobs VALUES('AD_ASST', 'Administration Assistant', 3000, 6000);
INSERT INTO hr_jobs VALUES('FI_MGR', 'Finance Manager', 8200, 16000);
INSERT INTO hr_jobs VALUES('FI_ACCOUNT', 'Accountant', 4200, 9000);
INSERT INTO hr_jobs VALUES('AC_MGR', 'Accounting Manager', 8200, 16000);
INSERT INTO hr_jobs VALUES('AC_ACCOUNT', 'Public Accountant', 4200, 9000);
INSERT INTO hr_jobs VALUES('SA_MAN', 'Sales Manager', 10000, 20000);
INSERT INTO hr_jobs VALUES('SA_REP', 'Sales Representative', 6000, 12000);
INSERT INTO hr_jobs VALUES('PU_MAN', 'Purchasing Manager', 8000, 15000);
INSERT INTO hr_jobs VALUES('PU_CLERK', 'Purchasing Clerk', 2500, 5500);
INSERT INTO hr_jobs VALUES('ST_MAN', 'Stock Manager', 5500, 8500);
INSERT INTO hr_jobs VALUES('ST_CLERK', 'Stock Clerk', 2000, 5000);
INSERT INTO hr_jobs VALUES('SH_CLERK', 'Shipping Clerk', 2500, 5500);
INSERT INTO hr_jobs VALUES('IT_PROG', 'Programmer', 4000, 10000);
INSERT INTO hr_jobs VALUES('MK_MAN', 'Marketing Manager', 9000, 15000);
INSERT INTO hr_jobs VALUES('MK_REP', 'Marketing Representative', 4000, 9000);
INSERT INTO hr_jobs VALUES('HR_REP', 'Human Resources Representative', 4000, 9000);
INSERT INTO hr_jobs VALUES('PR_REP', 'Public Relations Representative', 4500, 10500);
--
/*======================================*/
--HR_EMPLOYEES
/*======================================*/
INSERT INTO hr_employees VALUES(100, 'Steven', 'King', 'SKING', '515.123.4567', TO_DATE ('17-JUN-1987', 'dd-MON-yyyy'), 'AD_PRES', 24000, NULL, NULL, 90);
INSERT INTO hr_employees VALUES(101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', TO_DATE ('21-SEP-1989', 'dd-MON-yyyy'), 'AD_VP', 17000, NULL, 100, 90);
INSERT INTO hr_employees VALUES(102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', TO_DATE ('13-ENE-1993', 'dd-MON-yyyy'), 'AD_VP', 17000, NULL, 100, 90);
INSERT INTO hr_employees VALUES(103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', TO_DATE ('03-ENE-1990', 'dd-MON-yyyy'), 'IT_PROG', 9000, NULL, 102, 60);
INSERT INTO hr_employees VALUES(104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', TO_DATE ('21-MAY-1991', 'dd-MON-yyyy'), 'IT_PROG', 6000, NULL, 103, 60);
INSERT INTO hr_employees VALUES(105, 'David', 'Austin', 'DAUSTIN', '590.423.4569', TO_DATE ('25-JUN-1997', 'dd-MON-yyyy'), 'IT_PROG', 4800, NULL, 103, 60);
INSERT INTO hr_employees VALUES(106, 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', TO_DATE ('05-FEB-1998', 'dd-MON-yyyy'), 'IT_PROG', 4800, NULL, 103, 60);
INSERT INTO hr_employees VALUES(107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', TO_DATE ('07-FEB-1999', 'dd-MON-yyyy'), 'IT_PROG', 4200, NULL, 103, 60);
INSERT INTO hr_employees VALUES(108, 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', TO_DATE ('17-AGO-1994', 'dd-MON-yyyy'), 'FI_MGR', 12000, NULL, 101, 100);
INSERT INTO hr_employees VALUES(109, 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', TO_DATE ('16-AGO-1994', 'dd-MON-yyyy'), 'FI_ACCOUNT', 9000, NULL, 108, 100);
INSERT INTO hr_employees VALUES(110, 'John', 'Chen', 'JCHEN', '515.124.4269', TO_DATE ('28-SEP-1997', 'dd-MON-yyyy'), 'FI_ACCOUNT', 8200, NULL, 108, 100);
INSERT INTO hr_employees VALUES(111, 'Ismael', 'Sciarra', 'ISCIARRA', '515.124.4369', TO_DATE ('30-SEP-1997', 'dd-MON-yyyy'), 'FI_ACCOUNT', 7700, NULL, 108, 100);
INSERT INTO hr_employees VALUES(112, 'Jose Manuel', 'Urman', 'JMURMAN', '515.124.4469', TO_DATE ('07-MAR-1998', 'dd-MON-yyyy'), 'FI_ACCOUNT', 7800, NULL, 108, 100);
INSERT INTO hr_employees VALUES(113, 'Luis', 'Popp', 'LPOPP', '515.124.4567', TO_DATE ('07-DIC-1999', 'dd-MON-yyyy'), 'FI_ACCOUNT', 6900, NULL, 108, 100);
INSERT INTO hr_employees VALUES(114, 'Den', 'Raphaely', 'DRAPHEAL', '515.127.4561', TO_DATE ('07-DIC-1994', 'dd-MON-yyyy'), 'PU_MAN', 11000, NULL, 100, 30);
INSERT INTO hr_employees VALUES(115, 'Alexander', 'Khoo', 'AKHOO', '515.127.4562', TO_DATE ('18-MAY-1995', 'dd-MON-yyyy'), 'PU_CLERK', 3100, NULL, 114, 30);
INSERT INTO hr_employees VALUES(116, 'Shelli', 'Baida', 'SBAIDA', '515.127.4563', TO_DATE ('24-DIC-1997', 'dd-MON-yyyy'), 'PU_CLERK', 2900, NULL, 114, 30);
INSERT INTO hr_employees VALUES(117, 'Sigal', 'Tobias', 'STOBIAS', '515.127.4564', TO_DATE ('24-JUL-1997', 'dd-MON-yyyy'), 'PU_CLERK', 2800, NULL, 114, 30);
INSERT INTO hr_employees VALUES(118, 'Guy', 'Himuro', 'GHIMURO', '515.127.4565', TO_DATE ('15-NOV-1998', 'dd-MON-yyyy'), 'PU_CLERK', 2600, NULL, 114, 30);
INSERT INTO hr_employees VALUES(119, 'Karen', 'Colmenares', 'KCOLMENA', '515.127.4566', TO_DATE ('10-AGO-1999', 'dd-MON-yyyy'), 'PU_CLERK', 2500, NULL, 114, 30);
INSERT INTO hr_employees VALUES(120, 'Matthew', 'Weiss', 'MWEISS', '650.123.1234', TO_DATE ('18-JUL-1996', 'dd-MON-yyyy'), 'ST_MAN', 8000, NULL, 100, 50);
INSERT INTO hr_employees VALUES(121, 'Adam', 'Fripp', 'AFRIPP', '650.123.2234', TO_DATE ('10-ABR-1997', 'dd-MON-yyyy'), 'ST_MAN', 8200, NULL, 100, 50);
INSERT INTO hr_employees VALUES(122, 'Payam', 'Kaufling', 'PKAUFLIN', '650.123.3234', TO_DATE ('01-MAY-1995', 'dd-MON-yyyy'), 'ST_MAN', 7900, NULL, 100, 50);
INSERT INTO hr_employees VALUES(123, 'Shanta', 'Vollman', 'SVOLLMAN', '650.123.4234', TO_DATE ('10-OCT-1997', 'dd-MON-yyyy'), 'ST_MAN', 6500, NULL, 100, 50);
INSERT INTO hr_employees VALUES(124, 'Kevin', 'Mourgos', 'KMOURGOS', '650.123.5234', TO_DATE ('16-NOV-1999', 'dd-MON-yyyy'), 'ST_MAN', 5800, NULL, 100, 50);
INSERT INTO hr_employees VALUES(125, 'Julia', 'Nayer', 'JNAYER', '650.124.1214', TO_DATE ('16-JUL-1997', 'dd-MON-yyyy'), 'ST_CLERK', 3200, NULL, 120, 50);
INSERT INTO hr_employees VALUES(126, 'Irene', 'Mikkilineni', 'IMIKKILI', '650.124.1224', TO_DATE ('28-SEP-1998', 'dd-MON-yyyy'), 'ST_CLERK', 2700, NULL, 120, 50);
INSERT INTO hr_employees VALUES(127, 'James', 'Landry', 'JLANDRY', '650.124.1334', TO_DATE ('14-ENE-1999', 'dd-MON-yyyy'), 'ST_CLERK', 2400, NULL, 120, 50);
INSERT INTO hr_employees VALUES(128, 'Steven', 'Markle', 'SMARKLE', '650.124.1434', TO_DATE ('08-MAR-2000', 'dd-MON-yyyy'), 'ST_CLERK', 2200, NULL, 120, 50);
INSERT INTO hr_employees VALUES(129, 'Laura', 'Bissot', 'LBISSOT', '650.124.5234', TO_DATE ('20-AGO-1997', 'dd-MON-yyyy'), 'ST_CLERK', 3300, NULL, 121, 50);
INSERT INTO hr_employees VALUES(130, 'Mozhe', 'Atkinson', 'MATKINSO', '650.124.6234', TO_DATE ('30-OCT-1997', 'dd-MON-yyyy'), 'ST_CLERK', 2800, NULL, 121, 50);
INSERT INTO hr_employees VALUES(131, 'James', 'Marlow', 'JAMRLOW', '650.124.7234', TO_DATE ('16-FEB-1997', 'dd-MON-yyyy'), 'ST_CLERK', 2500, NULL, 121, 50);
INSERT INTO hr_employees VALUES(132, 'TJ', 'Olson', 'TJOLSON', '650.124.8234', TO_DATE ('10-ABR-1999', 'dd-MON-yyyy'), 'ST_CLERK', 2100, NULL, 121, 50);
INSERT INTO hr_employees VALUES(133, 'Jason', 'Mallin', 'JMALLIN', '650.127.1934', TO_DATE ('14-JUN-1996', 'dd-MON-yyyy'), 'ST_CLERK', 3300, NULL, 122, 50);
INSERT INTO hr_employees VALUES(134, 'Michael', 'Rogers', 'MROGERS', '650.127.1834', TO_DATE ('26-AGO-1998', 'dd-MON-yyyy'), 'ST_CLERK', 2900, NULL, 122, 50);
INSERT INTO hr_employees VALUES(135, 'Ki', 'Gee', 'KGEE', '650.127.1734', TO_DATE ('12-DIC-1999', 'dd-MON-yyyy'), 'ST_CLERK', 2400, NULL, 122, 50);
INSERT INTO hr_employees VALUES(136, 'Hazel', 'Philtanker', 'HPHILTAN', '650.127.1634', TO_DATE ('06-FEB-2000', 'dd-MON-yyyy'), 'ST_CLERK', 2200, NULL, 122, 50);
INSERT INTO hr_employees VALUES(137, 'Renske', 'Ladwig', 'RLADWIG', '650.121.1234', TO_DATE ('14-JUL-1995', 'dd-MON-yyyy'), 'ST_CLERK', 3600, NULL, 123, 50);
INSERT INTO hr_employees VALUES(138, 'Stephen', 'Stiles', 'SSTILES', '650.121.2034', TO_DATE ('26-OCT-1997', 'dd-MON-yyyy'), 'ST_CLERK', 3200, NULL, 123, 50);
INSERT INTO hr_employees VALUES(139, 'John', 'Seo', 'JSEO', '650.121.2019', TO_DATE ('12-FEB-1998', 'dd-MON-yyyy'), 'ST_CLERK', 2700, NULL, 123, 50);
INSERT INTO hr_employees VALUES(140, 'Joshua', 'Patel', 'JPATEL', '650.121.1834', TO_DATE ('06-ABR-1998', 'dd-MON-yyyy'), 'ST_CLERK', 2500, NULL, 123, 50);
INSERT INTO hr_employees VALUES(141, 'Trenna', 'Rajs', 'TRAJS', '650.121.8009', TO_DATE ('17-OCT-1995', 'dd-MON-yyyy'), 'ST_CLERK', 3500, NULL, 124, 50);
INSERT INTO hr_employees VALUES(142, 'Curtis', 'Davies', 'CDAVIES', '650.121.2994', TO_DATE ('29-ENE-1997', 'dd-MON-yyyy'), 'ST_CLERK', 3100, NULL, 124, 50);
INSERT INTO hr_employees VALUES(143, 'Randall', 'Matos', 'RMATOS', '650.121.2874', TO_DATE ('15-MAR-1998', 'dd-MON-yyyy'), 'ST_CLERK', 2600, NULL, 124, 50);
INSERT INTO hr_employees VALUES(144, 'Peter', 'Vargas', 'PVARGAS', '650.121.2004', TO_DATE ('09-JUL-1998', 'dd-MON-yyyy'), 'ST_CLERK', 2500, NULL, 124, 50);
INSERT INTO hr_employees VALUES(145, 'John', 'Russell', 'JRUSSEL', '011.44.1344.429268', TO_DATE ('01-OCT-1996', 'dd-MON-yyyy'), 'SA_MAN', 14000, .4, 100, 80);
INSERT INTO hr_employees VALUES(146, 'Karen', 'Partners', 'KPARTNER', '011.44.1344.467268', TO_DATE ('05-ENE-1997', 'dd-MON-yyyy'), 'SA_MAN', 13500, .3, 100, 80);
INSERT INTO hr_employees VALUES(147, 'Alberto', 'Errazuriz', 'AERRAZUR', '011.44.1344.429278', TO_DATE ('10-MAR-1997', 'dd-MON-yyyy'), 'SA_MAN', 12000, .3, 100, 80);
INSERT INTO hr_employees VALUES(148, 'Gerald', 'Cambrault', 'GCAMBRAU', '011.44.1344.619268', TO_DATE ('15-OCT-1999', 'dd-MON-yyyy'), 'SA_MAN', 11000, .3, 100, 80);
INSERT INTO hr_employees VALUES(149, 'Eleni', 'Zlotkey', 'EZLOTKEY', '011.44.1344.429018', TO_DATE ('29-ENE-2000', 'dd-MON-yyyy'), 'SA_MAN', 10500, .2, 100, 80);
INSERT INTO hr_employees VALUES(150, 'Peter', 'Tucker', 'PTUCKER', '011.44.1344.129268', TO_DATE ('30-ENE-1997', 'dd-MON-yyyy'), 'SA_REP', 10000, .3, 145, 80);
INSERT INTO hr_employees VALUES(151, 'David', 'Bernstein', 'DBERNSTE', '011.44.1344.345268', TO_DATE ('24-MAR-1997', 'dd-MON-yyyy'), 'SA_REP', 9500, .25, 145, 80);
INSERT INTO hr_employees VALUES(152, 'Peter', 'Hall', 'PHALL', '011.44.1344.478968', TO_DATE ('20-AGO-1997', 'dd-MON-yyyy'), 'SA_REP', 9000, .25, 145, 80);
INSERT INTO hr_employees VALUES(153, 'Christopher', 'Olsen', 'COLSEN', '011.44.1344.498718', TO_DATE ('30-MAR-1998', 'dd-MON-yyyy'), 'SA_REP', 8000, .2, 145, 80);
INSERT INTO hr_employees VALUES(154, 'Nanette', 'Cambrault', 'NCAMBRAU', '011.44.1344.987668', TO_DATE ('09-DIC-1998', 'dd-MON-yyyy'), 'SA_REP', 7500, .2, 145, 80);
INSERT INTO hr_employees VALUES(155, 'Oliver', 'Tuvault', 'OTUVAULT', '011.44.1344.486508', TO_DATE ('23-NOV-1999', 'dd-MON-yyyy'), 'SA_REP', 7000, .15, 145, 80);
INSERT INTO hr_employees VALUES(156, 'Janette', 'King', 'JKING', '011.44.1345.429268', TO_DATE ('30-ENE-1996', 'dd-MON-yyyy'), 'SA_REP', 10000, .35, 146, 80);
INSERT INTO hr_employees VALUES(157, 'Patrick', 'Sully', 'PSULLY', '011.44.1345.929268', TO_DATE ('04-MAR-1996', 'dd-MON-yyyy'), 'SA_REP', 9500, .35, 146, 80);
INSERT INTO hr_employees VALUES(158, 'Allan', 'McEwen', 'AMCEWEN', '011.44.1345.829268', TO_DATE ('01-AGO-1996', 'dd-MON-yyyy'), 'SA_REP', 9000, .35, 146, 80);
INSERT INTO hr_employees VALUES(159, 'Lindsey', 'Smith', 'LSMITH', '011.44.1345.729268', TO_DATE ('10-MAR-1997', 'dd-MON-yyyy'), 'SA_REP', 8000, .3, 146, 80);
INSERT INTO hr_employees VALUES(160, 'Louise', 'Doran', 'LDORAN', '011.44.1345.629268', TO_DATE ('15-DIC-1997', 'dd-MON-yyyy'), 'SA_REP', 7500, .3, 146, 80);
INSERT INTO hr_employees VALUES(161, 'Sarath', 'Sewall', 'SSEWALL', '011.44.1345.529268', TO_DATE ('03-NOV-1998', 'dd-MON-yyyy'), 'SA_REP', 7000, .25, 146, 80);
INSERT INTO hr_employees VALUES(162, 'Clara', 'Vishney', 'CVISHNEY', '011.44.1346.129268', TO_DATE ('11-NOV-1997', 'dd-MON-yyyy'), 'SA_REP', 10500, .25, 147, 80);
INSERT INTO hr_employees VALUES(163, 'Danielle', 'Greene', 'DGREENE', '011.44.1346.229268', TO_DATE ('19-MAR-1999', 'dd-MON-yyyy'), 'SA_REP', 9500, .15, 147, 80);
INSERT INTO hr_employees VALUES(164, 'Mattea', 'Marvins', 'MMARVINS', '011.44.1346.329268', TO_DATE ('24-ENE-2000', 'dd-MON-yyyy'), 'SA_REP', 7200, .10, 147, 80);
INSERT INTO hr_employees VALUES(165, 'David', 'Lee', 'DLEE', '011.44.1346.529268', TO_DATE ('23-FEB-2000', 'dd-MON-yyyy'), 'SA_REP', 6800, .1, 147, 80);
INSERT INTO hr_employees VALUES(166, 'Sundar', 'Ande', 'SANDE', '011.44.1346.629268', TO_DATE ('24-MAR-2000', 'dd-MON-yyyy'), 'SA_REP', 6400, .10, 147, 80);
INSERT INTO hr_employees VALUES(167, 'Amit', 'Banda', 'ABANDA', '011.44.1346.729268', TO_DATE ('21-ABR-2000', 'dd-MON-yyyy'), 'SA_REP', 6200, .10, 147, 80);
INSERT INTO hr_employees VALUES(168, 'Lisa', 'Ozer', 'LOZER', '011.44.1343.929268', TO_DATE ('11-MAR-1997', 'dd-MON-yyyy'), 'SA_REP', 11500, .25, 148, 80);
INSERT INTO hr_employees VALUES(169, 'Harrison', 'Bloom', 'HBLOOM', '011.44.1343.829268', TO_DATE ('23-MAR-1998', 'dd-MON-yyyy'), 'SA_REP', 10000, .20, 148, 80);
INSERT INTO hr_employees VALUES(170, 'Tayler', 'Fox', 'TFOX', '011.44.1343.729268', TO_DATE ('24-ENE-1998', 'dd-MON-yyyy'), 'SA_REP', 9600, .20, 148, 80);
INSERT INTO hr_employees VALUES(171, 'William', 'Smith', 'WSMITH', '011.44.1343.629268', TO_DATE ('23-FEB-1999', 'dd-MON-yyyy'), 'SA_REP', 7400, .15, 148, 80);
INSERT INTO hr_employees VALUES(172, 'Elizabeth', 'Bates', 'EBATES', '011.44.1343.529268', TO_DATE ('24-MAR-1999', 'dd-MON-yyyy'), 'SA_REP', 7300, .15, 148, 80);
INSERT INTO hr_employees VALUES(173, 'Sundita', 'Kumar', 'SKUMAR', '011.44.1343.329268', TO_DATE ('21-ABR-2000', 'dd-MON-yyyy'), 'SA_REP', 6100, .10, 148, 80);
INSERT INTO hr_employees VALUES(174, 'Ellen', 'Abel', 'EABEL', '011.44.1644.429267', TO_DATE ('11-MAY-1996', 'dd-MON-yyyy'), 'SA_REP', 11000, .30, 149, 80);
INSERT INTO hr_employees VALUES(175, 'Alyssa', 'Hutton', 'AHUTTON', '011.44.1644.429266', TO_DATE ('19-MAR-1997', 'dd-MON-yyyy'), 'SA_REP', 8800, .25, 149, 80);
INSERT INTO hr_employees VALUES(176, 'Jonathon', 'Taylor', 'JTAYLOR', '011.44.1644.429265', TO_DATE ('24-MAR-1998', 'dd-MON-yyyy'), 'SA_REP', 8600, .20, 149, 80);
INSERT INTO hr_employees VALUES(177, 'Jack', 'Livingston', 'JLIVINGS', '011.44.1644.429264', TO_DATE ('23-ABR-1998', 'dd-MON-yyyy'), 'SA_REP', 8400, .20, 149, 80);
INSERT INTO hr_employees VALUES(178, 'Kimberely', 'Grant', 'KGRANT', '011.44.1644.429263', TO_DATE ('24-MAY-1999', 'dd-MON-yyyy'), 'SA_REP', 7000, .15, 149, NULL);
INSERT INTO hr_employees VALUES(179, 'Charles', 'Johnson', 'CJOHNSON', '011.44.1644.429262', TO_DATE ('04-ENE-2000', 'dd-MON-yyyy'), 'SA_REP', 6200, .10, 149, 80);
INSERT INTO hr_employees VALUES(180, 'Winston', 'Taylor', 'WTAYLOR', '650.507.9876', TO_DATE ('24-ENE-1998', 'dd-MON-yyyy'), 'SH_CLERK', 3200, NULL, 120, 50);
INSERT INTO hr_employees VALUES(181, 'Jean', 'Fleaur', 'JFLEAUR', '650.507.9877', TO_DATE ('23-FEB-1998', 'dd-MON-yyyy'), 'SH_CLERK', 3100, NULL, 120, 50);
INSERT INTO hr_employees VALUES(182, 'Martha', 'Sullivan', 'MSULLIVA', '650.507.9878', TO_DATE ('21-JUN-1999', 'dd-MON-yyyy'), 'SH_CLERK', 2500, NULL, 120, 50);
INSERT INTO hr_employees VALUES(183, 'Girard', 'Geoni', 'GGEONI', '650.507.9879', TO_DATE ('03-FEB-2000', 'dd-MON-yyyy'), 'SH_CLERK', 2800, NULL, 120, 50);
INSERT INTO hr_employees VALUES(184, 'Nandita', 'Sarchand', 'NSARCHAN', '650.509.1876', TO_DATE ('27-ENE-1996', 'dd-MON-yyyy'), 'SH_CLERK', 4200, NULL, 121, 50);
INSERT INTO hr_employees VALUES(185, 'Alexis', 'Bull', 'ABULL', '650.509.2876', TO_DATE ('20-FEB-1997', 'dd-MON-yyyy'), 'SH_CLERK', 4100, NULL, 121, 50);
INSERT INTO hr_employees VALUES(186, 'Julia', 'Dellinger', 'JDELLING', '650.509.3876', TO_DATE ('24-JUN-1998', 'dd-MON-yyyy'), 'SH_CLERK', 3400, NULL, 121, 50);
INSERT INTO hr_employees VALUES(187, 'Anthony', 'Cabrio', 'ACABRIO', '650.509.4876', TO_DATE ('07-FEB-1999', 'dd-MON-yyyy'), 'SH_CLERK', 3000, NULL, 121, 50);
INSERT INTO hr_employees VALUES(188, 'Kelly', 'Chung', 'KCHUNG', '650.505.1876', TO_DATE ('14-JUN-1997', 'dd-MON-yyyy'), 'SH_CLERK', 3800, NULL, 122, 50);
INSERT INTO hr_employees VALUES(189, 'Jennifer', 'Dilly', 'JDILLY', '650.505.2876', TO_DATE ('13-AGO-1997', 'dd-MON-yyyy'), 'SH_CLERK', 3600, NULL, 122, 50);
INSERT INTO hr_employees VALUES(190, 'Timothy', 'Gates', 'TGATES', '650.505.3876', TO_DATE ('11-JUL-1998', 'dd-MON-yyyy'), 'SH_CLERK', 2900, NULL, 122, 50);
INSERT INTO hr_employees VALUES(191, 'Randall', 'Perkins', 'RPERKINS', '650.505.4876', TO_DATE ('19-DIC-1999', 'dd-MON-yyyy'), 'SH_CLERK', 2500, NULL, 122, 50);
INSERT INTO hr_employees VALUES(192, 'Sarah', 'Bell', 'SBELL', '650.501.1876', TO_DATE ('04-FEB-1996', 'dd-MON-yyyy'), 'SH_CLERK', 4000, NULL, 123, 50);
INSERT INTO hr_employees VALUES(193, 'Britney', 'Everett', 'BEVERETT', '650.501.2876', TO_DATE ('03-MAR-1997', 'dd-MON-yyyy'), 'SH_CLERK', 3900, NULL, 123, 50);
INSERT INTO hr_employees VALUES(194, 'Samuel', 'McCain', 'SMCCAIN', '650.501.3876', TO_DATE ('01-JUL-1998', 'dd-MON-yyyy'), 'SH_CLERK', 3200, NULL, 123, 50);
INSERT INTO hr_employees VALUES(195, 'Vance', 'Jones', 'VJONES', '650.501.4876', TO_DATE ('17-MAR-1999', 'dd-MON-yyyy'), 'SH_CLERK', 2800, NULL, 123, 50);
INSERT INTO hr_employees VALUES(196, 'Alana', 'Walsh', 'AWALSH', '650.507.9811', TO_DATE ('24-ABR-1998', 'dd-MON-yyyy'), 'SH_CLERK', 3100, NULL, 124, 50);
INSERT INTO hr_employees VALUES(197, 'Kevin', 'Feeney', 'KFEENEY', '650.507.9822', TO_DATE ('23-MAY-1998', 'dd-MON-yyyy'), 'SH_CLERK', 3000, NULL, 124, 50);
INSERT INTO hr_employees VALUES(198, 'Donald', 'OConnell', 'DOCONNEL', '650.507.9833', TO_DATE ('21-JUN-1999', 'dd-MON-yyyy'), 'SH_CLERK', 2600, NULL, 124, 50);
INSERT INTO hr_employees VALUES(199, 'Douglas', 'Grant', 'DGRANT', '650.507.9844', TO_DATE ('13-ENE-2000', 'dd-MON-yyyy'), 'SH_CLERK', 2600, NULL, 124, 50);
INSERT INTO hr_employees VALUES(200, 'Jennifer', 'Whalen', 'JWHALEN', '515.123.4444', TO_DATE ('17-SEP-1987', 'dd-MON-yyyy'), 'AD_ASST', 4400, NULL, 101, 10);
INSERT INTO hr_employees VALUES(201, 'Michael', 'Hartstein', 'MHARTSTE', '515.123.5555', TO_DATE ('17-FEB-1996', 'dd-MON-yyyy'), 'MK_MAN', 13000, NULL, 100, 20);
INSERT INTO hr_employees VALUES(202, 'Pat', 'Fay', 'PFAY', '603.123.6666', TO_DATE ('17-AGO-1997', 'dd-MON-yyyy'), 'MK_REP', 6000, NULL, 201, 20);
INSERT INTO hr_employees VALUES(203, 'Susan', 'Mavris', 'SMAVRIS', '515.123.7777', TO_DATE ('07-JUN-1994', 'dd-MON-yyyy'), 'HR_REP', 6500, NULL, 101, 40);
INSERT INTO hr_employees VALUES(204, 'Hermann', 'Baer', 'HBAER', '515.123.8888', TO_DATE ('07-JUN-1994', 'dd-MON-yyyy'), 'PR_REP', 10000, NULL, 101, 70);
INSERT INTO hr_employees VALUES(205, 'Shelley', 'Higgins', 'SHIGGINS', '515.123.8080', TO_DATE ('07-JUN-1994', 'dd-MON-yyyy'), 'AC_MGR', 12000, NULL, 101, 110);
INSERT INTO hr_employees VALUES(206, 'William', 'Gietz', 'WGIETZ', '515.123.8181', TO_DATE ('07-JUN-1994', 'dd-MON-yyyy'), 'AC_ACCOUNT', 8300, NULL, 205, 110);
--
/*======================================*/
--HR_JOB_HISTORY
/*======================================*/
INSERT INTO hr_job_history VALUES(102, TO_DATE ('13-ENE-1993', 'dd-MON-yyyy'), TO_DATE ('24-JUL-1998', 'dd-MON-yyyy'), 'IT_PROG', 60);
INSERT INTO hr_job_history VALUES(101, TO_DATE ('21-SEP-1989', 'dd-MON-yyyy'), TO_DATE ('27-OCT-1993', 'dd-MON-yyyy'), 'AC_ACCOUNT', 110);
INSERT INTO hr_job_history VALUES(101, TO_DATE ('28-OCT-1993', 'dd-MON-yyyy'), TO_DATE ('15-MAR-1997', 'dd-MON-yyyy'), 'AC_MGR', 110);
INSERT INTO hr_job_history VALUES(201, TO_DATE ('17-FEB-1996', 'dd-MON-yyyy'), TO_DATE ('19-DIC-1999', 'dd-MON-yyyy'), 'MK_REP', 20);
INSERT INTO hr_job_history VALUES(114, TO_DATE ('24-MAR-1998', 'dd-MON-yyyy'), TO_DATE ('31-DIC-1999', 'dd-MON-yyyy'), 'ST_CLERK', 50);
INSERT INTO hr_job_history VALUES(122, TO_DATE ('01-ENE-1999', 'dd-MON-yyyy'), TO_DATE ('31-DIC-1999', 'dd-MON-yyyy'), 'ST_CLERK', 50);
INSERT INTO hr_job_history VALUES(200, TO_DATE ('17-SEP-1987', 'dd-MON-yyyy'), TO_DATE ('17-JUN-1993', 'dd-MON-yyyy'), 'AD_ASST', 90);
INSERT INTO hr_job_history VALUES(176, TO_DATE ('24-MAR-1998', 'dd-MON-yyyy'), TO_DATE ('31-DIC-1998', 'dd-MON-yyyy'), 'SA_REP', 80);
INSERT INTO hr_job_history VALUES(176, TO_DATE ('01-ENE-1999', 'dd-MON-yyyy'), TO_DATE ('31-DIC-1999', 'dd-MON-yyyy'), 'SA_MAN', 80);
INSERT INTO hr_job_history VALUES(200, TO_DATE ('01-JUL-1994', 'dd-MON-yyyy'), TO_DATE ('31-DIC-1998', 'dd-MON-yyyy'), 'AC_ACCOUNT', 90);
--
COMMIT;
--
ALTER TABLE hr_departments ENABLE CONSTRAINT hr_dept_mgr_fk;
ALTER TABLE hr_departments ENABLE CONSTRAINT hr_dept_loc_fk;
ALTER TABLE hr_employees ENABLE CONSTRAINT hr_emp_dept_fk;
ALTER TABLE hr_employees ENABLE CONSTRAINT hr_emp_job_fk;
ALTER TABLE hr_employees ENABLE CONSTRAINT hr_emp_manager_fk;
ALTER TABLE hr_job_history ENABLE CONSTRAINT hr_jhist_dept_fk;
ALTER TABLE hr_job_history ENABLE CONSTRAINT hr_jhist_emp_fk;
ALTER TABLE hr_job_history ENABLE CONSTRAINT hr_jhist_job_fk;
--
/*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
--SEQUENCES
/*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
/*======================================*/
--HR_LOCATIONS
/*======================================*/
CREATE SEQUENCE hr_seq_locations
	START WITH		3300
	INCREMENT BY	100
	MAXVALUE		9900
	NOCACHE
	NOCYCLE;
--
CREATE OR REPLACE TRIGGER hr_tr_seq_locations
	BEFORE INSERT
	ON hr_locations
	REFERENCING NEW AS new OLD AS old
	FOR EACH ROW
BEGIN
	SELECT hr_seq_locations.NEXTVAL
	  INTO :new.location_id
	  FROM dual;
END hr_tr_seq_locations;
--
/*======================================*/
--HR_DEPARTMENTS
/*======================================*/
CREATE SEQUENCE hr_seq_departments
	START WITH		280
	INCREMENT BY	10
	MAXVALUE		9990
	NOCACHE
	NOCYCLE;
--
CREATE OR REPLACE TRIGGER hr_tr_seq_departments
	BEFORE INSERT
	ON hr_departments
	REFERENCING NEW AS new OLD AS old
	FOR EACH ROW
BEGIN
	SELECT hr_seq_departments.NEXTVAL
	  INTO :new.department_id
	  FROM dual;
END hr_tr_seq_departments;
--
/*======================================*/
--HR_EMPLOYEES
/*======================================*/
CREATE SEQUENCE hr_seq_employees
	START WITH		207
	INCREMENT BY	1
	NOCACHE
	NOCYCLE;
--
CREATE OR REPLACE TRIGGER hr_tr_seq_employees
	BEFORE INSERT
	ON hr_employees
	REFERENCING NEW AS new OLD AS old
	FOR EACH ROW
BEGIN
	SELECT hr_seq_employees.NEXTVAL
	  INTO :new.employee_id
	  FROM dual;
END hr_tr_seq_employees;
--
COMMIT;
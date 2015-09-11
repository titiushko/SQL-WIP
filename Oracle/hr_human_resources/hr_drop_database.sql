DROP PACKAGE hr_pk_employee;
--
DROP PROCEDURE hr_sp_add_job_history;
--
DROP VIEW hr_emp_details_view;
--
DROP SEQUENCE hr_seq_departments;
DROP SEQUENCE hr_seq_employees;
DROP SEQUENCE hr_seq_locations;
--
DROP TABLE hr_regions       CASCADE CONSTRAINTS;
DROP TABLE hr_departments	CASCADE CONSTRAINTS;
DROP TABLE hr_locations		CASCADE CONSTRAINTS;
DROP TABLE hr_jobs			CASCADE CONSTRAINTS;
DROP TABLE hr_job_history	CASCADE CONSTRAINTS;
DROP TABLE hr_employees		CASCADE CONSTRAINTS;
DROP TABLE hr_countries		CASCADE CONSTRAINTS;  
--
COMMIT;
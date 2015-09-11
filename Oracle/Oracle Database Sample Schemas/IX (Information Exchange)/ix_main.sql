rem
rem Copyright (c) 2001, 2002, Oracle Corporation.  All rights reserved.  
rem
rem Owner  : ahunold
rem
rem NAME
rem   ix_main.sql - Main script for IX schema
rem
rem DESCRIPTON
rem   Creates and populated the Information Exchange Sample Schema 
rem
rem NOTES
rem   Run as SYS or SYSTEM
rem   Prerequisites:
rem     Tablespaces present
rem
rem MODIFIED   (MM/DD/YY)
rem   ahunold   10/25/02 - gather_schema_stats
rem   huzhao    09/23/02 - 
rem   ahunold   09/16/02 - version literals
rem   hyeh      08/29/02 - hyeh_mv_comschema_to_rdbms
rem   meyoung   07/31/02 - created

SET ECHO OFF

PROMPT 
PROMPT specify password for IX as parameter 1:
DEFINE pass     = &1
PROMPT 
PROMPT specify default tablespeace for IX as parameter 2:
DEFINE tbs      = &2
PROMPT 
PROMPT specify temporary tablespace for IX as parameter 3:
DEFINE ttbs     = &3
PROMPT 
PROMPT specify password for SYS as parameter 4:
DEFINE pass_sys = &4
PROMPT 
PROMPT specify path for log files as parameter 5:
DEFINE log_path = &5
PROMPT
PROMPT specify version as parameter 6:
DEFINE vrs = &6
PROMPT

-- The first dot in the spool command below is 
-- the SQL*Plus concatenation character

DEFINE spool_file = &log_path.ix_&vrs..log
SPOOL &spool_file 

-- Dropping the user with all its objects

PROMPT dropping user ...

DROP USER ix CASCADE;

REM =======================================================
REM CREATE THE ix USER
REM The user is assigned tablespaces and quota in separate
REM ALTER USER statements so that the CREATE USER statement
REM will succeed even if the &tbs and temp tablespaces do
REM not exist.
REM =======================================================

REM =======================================================
REM Create a common user account 
REM =======================================================

PROMPT creating user ...
PROMPT

CREATE USER ix IDENTIFIED BY &pass;
ALTER USER ix DEFAULT TABLESPACE &tbs QUOTA UNLIMITED ON &tbs;
ALTER USER ix TEMPORARY TABLESPACE &ttbs;

REM =======================================================
REM Configure ix user as the AQ administrator 
REM =======================================================

GRANT ALTER SESSION TO ix;
GRANT CREATE CLUSTER TO ix;
GRANT CREATE DATABASE LINK TO ix;
GRANT CREATE SEQUENCE TO ix;
GRANT CREATE SESSION TO ix;
GRANT CREATE SYNONYM TO ix;
GRANT CREATE TABLE TO ix;
GRANT CREATE VIEW TO ix;
GRANT CREATE CLUSTER TO ix;
GRANT CREATE INDEXTYPE TO ix;
GRANT CREATE OPERATOR TO ix;
GRANT CREATE PROCEDURE TO ix;
GRANT CREATE SEQUENCE TO ix;
GRANT CREATE TABLE TO ix;
GRANT CREATE TRIGGER TO ix;
GRANT CREATE TYPE TO ix;
GRANT aq_administrator_role TO ix;
GRANT EXECUTE ON DBMS_AQ TO ix;
GRANT EXECUTE ON DBMS_AQADM TO ix;


REM =======================================================
REM Configure the ix user as an AQ user
REM =======================================================

GRANT CREATE SESSION TO ix;
GRANT aq_user_role to ix;

REM =======================================================
REM Privileges
REM =======================================================

GRANT CONNECT, RESOURCE, SELECT_CATALOG_ROLE TO ix;

REM =======================================================
REM Grant privilege for Streams, where appropriate
REM =======================================================

CONNECT sys/&pass_sys AS SYSDBA;

SET SERVEROUTPUT ON

DECLARE
 v CHAR(2);
BEGIN
 SELECT '&vrs' INTO v
  FROM dual;
 IF (v = 'v2') OR (v = 'v3') THEN
   DBMS_OUTPUT.PUT_LINE('');
   DBMS_OUTPUT.PUT_LINE('Granting Streams privileges, vrs='||v||' ...');
   DBMS_RULE_ADM.GRANT_SYSTEM_PRIVILEGE(
    privilege    => DBMS_RULE_ADM.CREATE_RULE_SET_OBJ, 
    grantee      => 'ix', 
    grant_option => FALSE);
   DBMS_RULE_ADM.GRANT_SYSTEM_PRIVILEGE(
    privilege    => DBMS_RULE_ADM.CREATE_RULE_OBJ, 
    grantee      => 'ix', 
    grant_option => FALSE);
   EXECUTE IMMEDIATE 'GRANT EXECUTE ON DBMS_APPLY_ADM TO ix';
   EXECUTE IMMEDIATE 'GRANT EXECUTE ON DBMS_CAPTURE_ADM TO ix';
   EXECUTE IMMEDIATE 'GRANT EXECUTE ON DBMS_FLASHBACK TO ix';
   EXECUTE IMMEDIATE 'GRANT EXECUTE ON DBMS_PROPAGATION_ADM TO ix';
   EXECUTE IMMEDIATE 'GRANT EXECUTE ON DBMS_STREAMS_ADM TO ix';
   EXECUTE IMMEDIATE 'GRANT EXECUTE ON DBMS_STATS TO ix';
   EXECUTE IMMEDIATE 'GRANT SELECT ANY DICTIONARY TO ix';
 END IF;
END;
/

PROMPT setting job_queue_processes and aq_tm_processes ...

REM =======================================================
REM Set AQ system parameters - JOB_QUEUE_PROCESSES and
REM                            AQ_TM_PROCESSES
REM =======================================================

DECLARE
 n NUMBER;
BEGIN
 SELECT value INTO n
  FROM v$parameter
  WHERE name = 'job_queue_processes';
 IF (n = 0) THEN
	EXECUTE IMMEDIATE 'ALTER SYSTEM SET job_queue_processes = 2';
 END IF;
 SELECT value INTO n
  FROM v$parameter
  WHERE name = 'aq_tm_processes';
 IF (n = 0) THEN
	EXECUTE IMMEDIATE 'ALTER SYSTEM SET aq_tm_processes = 2';
 END IF;
END;
/

REM =======================================================
REM Create objects - message, queuetable, queue
REM =======================================================

CONNECT ix/&pass

DEFINE vscript = ?/demo/schema/info_exchange/cix_&vrs
@&vscript

REM =======================================================
REM Using The Queues and Verification
REM =======================================================

CONNECT ix/&pass

DEFINE vscript = ?/demo/schema/info_exchange/vix_&vrs
@&vscript

spool off

/*
USE master;
GO
*/
-- consulta que devuelve las conexiones activas
SELECT spid,
       sysprocesses.status,
       hostname,
       program_name,
       cmd,
       cpu,
       physical_io,
       blocked,
       sysdatabases.name,
       loginame
  FROM master.dbo.sysprocesses INNER JOIN master.dbo.sysdatabases ON sysprocesses.dbid = sysdatabases.dbid
 WHERE program_name NOT LIKE 'Microsoft%'
   AND loginame = 'bw_user'
 ORDER BY spid;
--
-- consulta para ver las base de datos que estan haciendo utilizadas, el numero de conexiones y la sesion que la esta utilizando
SELECT db_name(dbid) as DBName, count(dbid) as NumberOfConnections, loginame as LoginName
  FROM sys.sysprocesses
 WHERE dbid > 0
 GROUP BY  dbid, loginame;
--
-- consulta para buscar los usuarios que estan conectados al servidor y se devuelve el numero de sesiones de cada usuario
SELECT login_name, COUNT(session_id) AS session_count
  FROM sys.dm_exec_sessions 
 GROUP BY login_name;
--
-- consulta para buscar los cursores que se han abierto durante mas de un periodo concreto, quien los creo y en que sesion estan
SELECT creation_time, cursor_id, name, c.session_id, login_name
  FROM sys.dm_exec_cursors(0) AS c JOIN sys.dm_exec_sessions AS s ON c.session_id = s.session_id 
 WHERE DATEDIFF(mi, c.creation_time, GETDATE()) > 5;
--
-- consulta para buscar sesiones que tienen transacciones abiertas y estan inactivas, una sesion inactiva es aquella que no tiene ninguna solicitud en ejecucion
SELECT s.* 
  FROM sys.dm_exec_sessions AS s
 WHERE EXISTS(SELECT * 
			    FROM sys.dm_tran_session_transactions AS t
			   WHERE t.session_id = s.session_id)
      AND NOT EXISTS(SELECT * 
					   FROM sys.dm_exec_requests AS r
					  WHERE r.session_id = s.session_id);
--
-- consulta para ver las tablas de una base de datos
SELECT table_name
  FROM QA576_local.INFORMATION_SCHEMA.TABLES
 WHERE table_type = 'BASE TABLE' AND table_schema = 'dbo' AND table_name LIKE '%invoice%'
 ORDER BY table_name ASC;
--
-- consulta para ver los campos de una tablas de una base de datos
 SELECT table_name, column_name
  FROM QA504.INFORMATION_SCHEMA.COLUMNS
 WHERE table_catalog = 'QA504' AND table_schema = 'dbo' AND table_name LIKE '%user%'
 ORDER BY table_name, column_name ASC;
--
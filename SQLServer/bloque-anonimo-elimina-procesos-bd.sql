USE master
GO

DECLARE @proceso INT, @estatus VARCHAR(10), @servidor VARCHAR(10), @programa VARCHAR(20), @comando VARCHAR(20), @cpu INT, @puerto INT, @bloqueo INT, @base_datos VARCHAR(20), @nombre_usuario VARCHAR(10)
DECLARE procesos CURSOR FOR
	SELECT spid, sysprocesses.status, hostname, program_name, cmd, cpu, physical_io, blocked, sysdatabases.name, loginame
	FROM master.dbo.sysprocesses INNER JOIN master.dbo.sysdatabases ON sysprocesses.dbid = sysdatabases.dbid
	WHERE program_name NOT LIKE 'Microsoft%' AND loginame = 'bw_user'
	ORDER BY spid
OPEN procesos
FETCH NEXT FROM procesos
INTO @proceso, @estatus, @servidor, @programa, @comando, @cpu, @puerto, @bloqueo, @base_datos, @nombre_usuario
WHILE @@FETCH_STATUS = 0 BEGIN
	BEGIN TRY
		EXEC('KILL ' + @proceso)
		PRINT 'proceso ' + CONVERT(VARCHAR(4), @proceso) + ' eliminado...'
		PRINT 'estatus: ' + @estatus + '  | servidor: ' + @servidor + '  | programa: ' + @programa + '  | @comando: ' + @comando + '  | cpu: ' + CONVERT(VARCHAR(4), @cpu) + '  | puerto: ' + CONVERT(VARCHAR(4), @puerto) + '  | bloqueo: ' + CONVERT(VARCHAR(4), @bloqueo) + '  | base_datos: ' + @base_datos + '  | nombre_usuario: ' + @nombre_usuario
		PRINT ''
		FETCH NEXT FROM procesos
		INTO @proceso, @estatus, @servidor, @programa, @comando, @cpu, @puerto, @bloqueo, @base_datos, @nombre_usuario
	END TRY
	BEGIN CATCH
		PRINT 'error en proceso ' + CONVERT(VARCHAR(4), @proceso)
	END CATCH
END
CLOSE procesos
DEALLOCATE procesos;
GO

/*
DECLARE @spid int
DECLARE procesos CURSOR FOR
	SELECT spid
	FROM master.dbo.sysprocesses INNER JOIN master.dbo.sysdatabases ON sysprocesses.dbid = sysdatabases.dbid
	WHERE program_name NOT LIKE 'Microsoft%' AND loginame = 'bw_user'
	ORDER BY spid
OPEN procesos
FETCH NEXT FROM procesos INTO @spid
WHILE @@FETCH_STATUS = 0 BEGIN
	BEGIN TRY
		EXEC('KILL ' + @spid)
		PRINT @spid
		FETCH NEXT FROM procesos INTO @spid
	END TRY
	BEGIN CATCH
		PRINT @spid
	END CATCH
END
CLOSE procesos
DEALLOCATE procesos;
GO
*/
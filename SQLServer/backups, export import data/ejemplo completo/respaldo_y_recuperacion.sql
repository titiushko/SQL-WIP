-- conectarse a la base de datos del sistema
use master
go

-- cambiar el modelo de recuperacion al completo
alter database parcial3
set recovery full
go

-- crear un dispositivo virtual para el backup de la base de datos
exec sp_addumpdevice 'disk', 'devicedatabase', 'e:\practica_parcial3_mg04077\database_parcial3.bak'
go

-- crear un dispositivo virtual para el backup del log
exec sp_addumpdevice 'disk', 'devicelog', 'e:\practica_parcial3_mg04077\log_parcial3.bak'
go

-- crear un backup de la base de datos
backup database parcial3 to devicedatabase
go

-- crear un backup del log
backup log parcial3 to devicelog
-- with norecovery
go

-- restaurar la base de datos
restore database parcial3 from devicedatabase
with file=3,
replace
go

-- restaurar el log
restore log parcial3 from devicelog
with recovery
go

-- probar los resultados en la base de datos
use parcial3
go

select * from miexamenmg04077
go

delete from miexamenmg04077
go

insert into miexamenmg04077
values ('2012-01-24','25','mg','2012','t','1','1','01','000-999','999-000','2012-01-24','0','recibido','25.25','1','2012-01-22 10:27:35.000','codigo')
go

exec sp_insert_miexamenmg04077 100
go
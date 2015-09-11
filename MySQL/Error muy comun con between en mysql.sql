Cuando hacemos una comparaci�n de fechas en Mysql, es muy facil cometer un error que puede no verse reflejado en las pruebas que se hagan.

SELECT * FROM tabla WHERE fecha BETWEEN �2009-09-01' AND �2009-09-30' ;

Esta consulta algunas veces dar� resultados v�lidos y otros invalidos. El problema es que si el campo fecha es un campo TIMESTAMP, no hace la comprobaci�n unicamente por la fecha como nosotros queremos.

Para asegurarnos que hace la comparaci�n unicamente con la fecha debemos a�adir el comando DATE.

La consulta correcta ser�a :

SELECT * FROM tabla WHERE DATE(fecha) BETWEEN �2009-09-01' AND �2009-09-30' ;


http://blogdavidrodriguez.piensaennaranja.com/2009/09/25/error-muy-comun-con-between-en-mysql/
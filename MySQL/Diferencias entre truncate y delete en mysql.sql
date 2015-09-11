TRUNCATE
Este comando borra todas las filas de una tabla sin registrar las eliminaciones individuales en el log de transacciones.
Por ejemplo:
TRUNCATE Cursos;
Borra todos los registros de la tabla Cursos

DELETE
DELETE borra las filas de una tabla, pero registra las eliminaciones individuales en el log de transacciones. Podemos utilizar la clausula WHERE para filtrar las filas que necesitemos eliminar.
Ejemplo:
DELETE FROM Cursos  WHERE CursoId = 50;

DIFERENCIAS ENTRE TRUNCATE Y DELETE
- Ambas eliminan los datos, no la estructura.
- Solo DELETE permite la eliminación condicional de los registros.
- DELETE es una operación registrada en el log de transacciones y trucate no.
- TRUNCATE es una operación registrada en el log de transacciones, pero como un todo, en conjunto, no por eliminación individual. TRUNCATE se registra como una liberación de las páginas de datos en las cuales existen los datos.
- TRUNCATE es más rápida que DELETE.
- Ambas se pueden deshacer con un ROLLBACK.
- TRUNCATE reiniciará el contador para una tabla que contenga una columna IDENTITY.
- DELETE mantendrá el contador de la tabla para una columna IDENTITY.
- TRUNCATE es un comando DDL(lenguaje de definición de datos) mientras que DELETE es un DML(lenguaje de manipulación de datos).
- TRUNCATE no desencadena un TRIGGER, DELETE sí.
- TRUNCATE recrea una tabla.

CUANDO USARLAS
- Usar Truncate es más rapido que Delete si vas a borrar toda una tabla y no te importan los indices(identity) o bien quieres resetearlos.
- Usar Delete para borrados selectivos.
- Usar Delete en caso de tener Foreign Key, es decir .. usarla en caso de borrados en cascada.
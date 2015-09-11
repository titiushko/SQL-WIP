TRANSACTION (PROCESS ID 86) WAS DEADLOCKED ON LOCK RESOURCES WITH ANOTHER
PROCESS AND HAS BEEN CHOSEN AS THE DEADLOCK VICTIM. RERUN THE TRANSACTION

Esto sucede cuando un proceso A bloquea el recurso X e intenta bloquear
el recurso Y. Pero a la vez hay un proceso B que tiene bloqueado el Y (por
lo que A no puede obtenerlo) y que está intentando bloquear el X (que lo
tiene pillado el A pero nunca lo suelta porque está esperando al Y, que lo
tiene pillado B). Esto se llama un "abrazo mortal" o interbloqueo
(deadlock). SQL Server es capaz de detectar automáticamente esta situación,
y la resuelve matando uno de los dos procesos, con lo cual el programa
cliente que estaba llamando a ese proceso que ha sido matado recibe el error
que indicas.

La forma de que no se produzcan interbloqueos es cuidar de que todos tus
procesos accedan a los recursos en el mismo orden. Por ejemplo, si tienes
una transacción que graba registros en las tablas A y B, no hagas otra que
acceda a B y A, porque corres el riesgo de que se produzca un interbloqueo
si coincide que las dos se ejecutan simultaneamente. Cambia el acceso a B y
A por A y B, y de esa manera esta transacción no podrá interbloquearse con
la otra.
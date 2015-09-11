-- SINTAXIS PROCEDIMIENTOS
CREATE [OR REPLACE} PROCEDURE [esquema].<nombre_procedimiento> (<nombre_parametro> {IN | OUT | IN OUT} <tipo_de_dato>, ...)
{IS | AS} 
	-- declaracion de variables locales;
	-- declaracion de constantes locales;
	-- declaracion de cursores locales;
	
BEGIN
	-- cuerpo del subprograma PL/SQL;
	
	[EXCEPTION]
		-- bloque de excepciones PL/SQL;
	
END [[esquema].<nombre_procedimiento>];

-- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

-- SINTAXIS FUNCIONES
CREATE [OR REPLACE] FUNCTION [esquema].<nombre_funcion> (<nombre_parametro> {IN | OUT | IN OUT} <tipo_de_dato>, ...)
RETURN <tipo_de_dato>
{IS | AS} 
	-- declaracion de variables locales;
	-- declaracion de constantes locales;
	-- declaracion de cursores locales;
	
BEGIN
	-- cuerpo del subprograma PL/SQL;
	
	[EXCEPTION]
		-- bloque de excepciones PL/SQL;
	
END [[esquema].<nombre_funcion>];

-- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

-- SINTAXIS DISPARADORES
CREATE [OR REPLACE] TRIGGER [esquema].<nombre_disparador>
{BEFORE | AFTER} {DELETE | INSERT | UPDATE [OF <nombre_columna>, ...] [OR {DELETE | INSERT | UPDATE [OF <nombre_columna>, ...]]}
ON <nombre_tabla>
[REFERENCING OLD AS OLD NEW AS NEW]
[FOR EACH {ROW | STATEMENT | WHEN (condicion)}]

DECLARE
	-- declaracion de variables locales;
	-- declaracion de constantes locales;
	-- declaracion de cursores locales;
	
BEGIN
	-- cuerpo del subprograma PL/SQL;
	
	[EXCEPTION]
		-- bloque de excepciones PL/SQL;
	
END [[esquema].<nombre_disparador>];

/*
INSERT, DELETE, UPDATE --> define que tipo de orden DML provoca la activacion del disparador
BEFORE, AFTER --> define si el disparador se activa antes o despues de que se ejecute la orden
FOR EACH --> nivel del disparo del disparador que por defecto es STATEMENT, significa que se dispara una sola vez por cada operacion independientemente del numero de filas afectadas
FOR EACH ROW --> los disparadores con nivel de fila se activan una vez por cada fila afectada por la orden que provoco el disparo
WHEN --> se establece una restriccion, el disparador solo actuara sobre las filas que satisfagan la restriccion
INSERTING --> TRUE si la orden de disparo es INSERT; FALSE en otro caso.
UPDATING --> TRUE si la orden de disparo es UPDATE; FALSE en otro caso. 
DELETING --> TRUE si la orden de disparo es DELETE; FALSE en otro caso.
*/

-- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

-- SINTAXIS PAQUETES
-- SPEC
CREATE [OR REPLACE] PACKAGE [esquema].<nombre_paquete> 
IS   
	-- declaraciones de tipos y registros publicos;
	{[TYPE <nombre_tipo> IS <tipo_de_dato>;]}

	-- declaracion de variables locales;
	-- declaracion de constantes locales;
	-- declaracion de cursores locales;
	{[<nombre_de_constante> CONSTANT <tipo_de_dato> := <valor>;]}  
	{[<nombre_de_variable> <tipo_de_dato>;]}

	-- declaraciones de procedimientos y funciones publicos;
	{[FUNCTION <nombre_funcion> (<nombre_parametro> <tipo_de_dato>,...) 
	RETURN <tipo_de_dato>;]}

	{[PROCEDURE <nombre_procedimiento> (<nombre_parametro> <tipo_de_dato>, ...);]}

END [[esquema].<nombre_paquete>];

-- BODY
CREATE [OR REPLACE] PACKAGE BODY [esquema].<nombre_paquete> 
IS	
	-- declaraciones de tipos y registros privados;
	{[TYPE <nombre_tipo> IS <tipo_de_dato>;]}

	-- declaracion de variables privados;
	-- declaracion de constantes privados;
	-- declaracion de cursores privados;
	{[<nombre_de_constante> CONSTANT <tipo_de_dato> := <valor>;]}  
	{[<nombre_de_variable> <tipo_de_dato>;]}

	-- implementacion de funciones y procedimientos
	FUNCTION <nombre_funcion> (<nombre_parametro> {IN | OUT | IN OUT} <tipo_de_dato>, ...)
	RETURN <tipo_de_dato>
	IS
		-- declaracion de variables del procedimiento;
		-- declaracion de constantes del procedimiento;
		-- declaracion de cursores del procedimiento;
		
	BEGIN
		-- cuerpo del subprograma PL/SQL;
		
		[EXCEPTION]
			-- bloque de excepciones PL/SQL;

	END [<nombre_funcion>];

	PROCEDURE <nombre_procedimiento> (<nombre_parametro> {IN | OUT | IN OUT} <tipo_de_dato>, ...)
	IS
		-- declaracion de variables de la funcion;
		-- declaracion de constantes de la funcion;
		-- declaracion de cursores de la funcion;
		
	BEGIN
		-- cuerpo del subprograma PL/SQL;
		
		[EXCEPTION]
			-- bloque de excepciones PL/SQL;
		
	END [<nombre_procedimiento>];

END [[esquema].<nombre_paquete>];
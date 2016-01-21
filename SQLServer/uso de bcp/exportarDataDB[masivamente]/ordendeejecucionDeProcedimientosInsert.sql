/*insertar en tabla customers*/
EXEC insert_customers 2000000;
/*Insertar en tabla contracts 3 contratos por cliente*/
EXEC insert_contracts 
/*insertar en tabla call_center*/
exec insert_callCenter 9999;
/*Insertar en tabla Ref_Call_Outcomes*/
exec insert_Ref_Call_Outcomes 999999
/*Insertar en tabla Ref_Call_Status_Codes*/
exec insert_Ref_Call_Status_Codes 99999
/*Insertar en tabla Staff*/
exec insert_Staff 100000

/*insertar los problemas es para los unicos que no cree procedimiento xD*/
	BEGIN TRAN
	INSERT INTO Common_Problems VALUES (1,'contrato insatisfecho','relacionado a contrato incumplido');
	INSERT INTO Common_Problems VALUES (2,'servicio no prestado','relacionado a servicios');
	INSERT INTO Common_Problems VALUES (3,'cliente insatisfecho','relacionado a servicios');
	INSERT INTO Common_Problems VALUES (4,'Diversos problemas en la garantia','relacionado a servicios');
		COMMIT	

/*insertar en tabla common_solution*/
exec insert_CommonSolution 1000000

/*insertar en tabla Solution for common problems*/

exec insert_Solutions_For_Common_Problems

/*insertar en tabla customer calls*/

exec insert_Customers_Calls

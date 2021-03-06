USE [call_centerEva1]
GO
/****** Object:  StoredProcedure [dbo].[insert_CommonSolution]    Script Date: 01/03/2012 12:06:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[insert_CommonSolution] @n_generator int
AS
	BEGIN
				DECLARE @solution_ID int;
				
				SET @solution_ID=0;
				
				WHILE(@solution_ID<@n_generator)
				  BEGIN 
				  SET	@solution_ID=@solution_ID+1;
				           IF(@solution_ID%2=0)
				           BEGIN 
				           BEGIN TRY
									BEGIN TRAN
				                    INSERT INTO Common_Solutions VALUES (@solution_ID,'abcdefrtyopsmsmsmskmskmskmskms','kmskmskms mmskmskmskmsks mskmskmskms');
									COMMIT				        
				        END TRY
				        BEGIN CATCH
				           ROLLBACK
				          PRINT ERROR_MESSAGE();
				          END CATCH 
				       END /*fin del IF*/
				      ELSE
				          BEGIN
				           BEGIN TRY
									BEGIN TRAN
				                    INSERT INTO Common_Solutions VALUES (@solution_ID,'MMMMMMMZZZZZZXXXXXXXXXXXXXX','SSSDDDDDDFFFFFGGGGGG');
									COMMIT				        
				        END TRY
				        BEGIN CATCH
				           ROLLBACK
				          PRINT ERROR_MESSAGE();
				          END CATCH 
				          
				          END  
				       
				  END	
END
GO
/****** Object:  StoredProcedure [dbo].[insert_callCenter]    Script Date: 01/03/2012 12:06:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[insert_callCenter] @n_generator int
AS
	BEGIN
				DECLARE @call_center_id int;
				SET @call_center_id=0;
				
				WHILE(@call_center_id<@n_generator)
				  BEGIN 
				  SET	@call_center_id=@call_center_id+1;
				        BEGIN TRY
									BEGIN TRAN
				                    INSERT INTO Call_Centers VALUES (@call_center_id,'410 Pellentesque Avs.','sucursales de call center n°:'+cast( @call_center_id AS varchar));
									COMMIT
				        
				        END TRY
				        BEGIN CATCH
				           ROLLBACK
				          PRINT ERROR_MESSAGE();
				          END CATCH 
				  
				  END
				
	
END
GO
/****** Object:  StoredProcedure [dbo].[insert_customers]    Script Date: 01/03/2012 12:06:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_customers] @n_generator int
AS
	BEGIN
				DECLARE @customer_id int;
				SET @customer_id=0;
				
				WHILE(@customer_id<@n_generator)
				  BEGIN 
				  SET	@customer_id=@customer_id+1;
				        BEGIN TRY
									BEGIN TRAN
				                    INSERT INTO Customers VALUES (@customer_id,'410 Pellentesque Av.','485-2752 Et Street','P.O. Box 752','Saukville','California','Ut@elementum.edu','5182-2409','Quisque imperdiet, erat nonummy ultricies');
									COMMIT
				        
				        END TRY
				        BEGIN CATCH
				           ROLLBACK
				          PRINT ERROR_MESSAGE();
				          END CATCH 
				  
				  END
				
	
	
END
GO
/****** Object:  StoredProcedure [dbo].[insert_Ref_Call_Status_Codes]    Script Date: 01/03/2012 12:06:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[insert_Ref_Call_Status_Codes] @n_generator int
AS
	BEGIN
				DECLARE @call_Status_Code int;
				SET @call_Status_Code=0;
				
				WHILE(@call_Status_Code<@n_generator)
				  BEGIN 
				  SET	@call_Status_Code=@call_Status_Code+1;
				    IF(@call_Status_Code%2=0)
				          BEGIN
				           BEGIN TRY
									BEGIN TRAN
				                    INSERT INTO Ref_Call_Status_Codes VALUES (@call_Status_Code,'Con exito.','zxcvbnmasdfghjklñq');
									COMMIT				        
				        END TRY
				        BEGIN CATCH
				           ROLLBACK
				          PRINT ERROR_MESSAGE();
				          END CATCH 
				     END /*FIN DEL IF*/
				     ELSE
				       BEGIN
				            BEGIN TRY
									BEGIN TRAN
				                    INSERT INTO Ref_Call_Status_Codes VALUES (@call_Status_Code,'Sin exito.','zxcertuiosp,smdlddddddd');
									COMMIT				        
				        END TRY
				        BEGIN CATCH
				           ROLLBACK
				          PRINT ERROR_MESSAGE();
				          END CATCH  				      
				        END  
				  END	
END
GO
/****** Object:  StoredProcedure [dbo].[insert_Ref_Call_Outcomes]    Script Date: 01/03/2012 12:06:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[insert_Ref_Call_Outcomes] @n_generator int
AS
	BEGIN
				DECLARE @call_Outcome_Code int;
				SET @call_Outcome_Code=0;
				
				WHILE(@call_Outcome_Code<@n_generator)
				  BEGIN 
				  SET	@call_Outcome_Code=@call_Outcome_Code+1;
				    IF(@call_Outcome_Code%2=0)
				          BEGIN
				           BEGIN TRY
									BEGIN TRAN
				                    INSERT INTO Ref_Call_Outcomes VALUES (@call_Outcome_Code,'llamada contestada por el cliente con exito.','El cliente expuso sus problemas');
									COMMIT				        
				        END TRY
				        BEGIN CATCH
				           ROLLBACK
				          PRINT ERROR_MESSAGE();
				          END CATCH 
				     END /*FIN DEL IF*/
				     ELSE
				       BEGIN
				            BEGIN TRY
									BEGIN TRAN
				                    INSERT INTO Ref_Call_Outcomes VALUES (@call_Outcome_Code,'llamada no contestada.','El cliente no expuso sus problemas');
									COMMIT				        
				        END TRY
				        BEGIN CATCH
				           ROLLBACK
				          PRINT ERROR_MESSAGE();
				          END CATCH  				      
				        END  
				  END	
END
GO
/****** Object:  StoredProcedure [dbo].[insert_Staff]    Script Date: 01/03/2012 12:06:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[insert_Staff] @n_generator int
AS
	BEGIN
				DECLARE @staff_ID int;
				DECLARE @telefono varchar(10);
				SET @staff_ID=0;
				
				WHILE(@staff_ID<@n_generator)
				  BEGIN 
				  SET	@staff_ID=@staff_ID+1;
				     set @telefono=cast( ROUND(((9999)*RAND()+1),0) AS varchar)+'-'+cast( ROUND(((99)*RAND()+1),0) AS varchar)+'-'+cast( ROUND(((99)*RAND()+1),0) AS varchar)
				          
				           BEGIN TRY
									BEGIN TRAN
				                    INSERT INTO Staff VALUES (@staff_ID,'abcdef@gmail.com',@telefono,'njsnjsnjnsjnsjnsjnsjnjsnjsnjsnjsnjsnjsn');
									COMMIT				        
				        END TRY
				        BEGIN CATCH
				           ROLLBACK
				          PRINT ERROR_MESSAGE();
				          END CATCH 
				    
				       
				  END	
END
GO
/****** Object:  StoredProcedure [dbo].[Total_Registros]    Script Date: 01/03/2012 12:06:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Total_Registros]
AS
BEGIN
declare @tabla1 int, @tabla2 int, @tabla3 int,@tabla4 int, @tabla5 int, @tabla6 int,@tabla7 int,@tabla8 int,@tabla9 int,@tabla10 int,@suma int
set @tabla1=0;
set @tabla2=0;
set @tabla3=0;
set @tabla4=0;
set @tabla5=0;
set @tabla6=0;
set @tabla7=0;
set @tabla8=0;
set @tabla9=0;
set @tabla10=0;
set @suma=0;
  begin 
set @tabla1= (select COUNT(*) from Call_Centers)
set @tabla2= (select COUNT(*) from Common_Problems)
set @tabla3= (select COUNT(*) from Common_Solutions)
set @tabla4= (select COUNT(*) from Contracts)
set @tabla5= (select COUNT(*) from Customer_Calls)
set @tabla6= (select COUNT(*) from Customers)
set @tabla7= (select COUNT(*) from Ref_Call_Outcomes)
set @tabla8= (select COUNT(*) from Ref_Call_Status_Codes);
set @tabla9= (select COUNT(*) from Solutions_For_Common_Problems)
set @tabla10= (select COUNT(*) from Staff)

set @suma=@tabla1+@tabla2+@tabla3+@tabla4+@tabla5+@tabla6+@tabla7+@tabla8+@tabla9+@tabla10

print 'Total de registro en la base de datos = '+cast( @suma AS varchar )

end
END
GO
/****** Object:  StoredProcedure [dbo].[insert2_contracts]    Script Date: 01/03/2012 12:06:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert2_contracts] @customer_id int
AS
	BEGIN
				DECLARE @contract_id int;
				DECLARE @contratosXcustomer int,@contador int;
				SET @contratosXcustomer=3 ;
				
				SET @contador=1;
	WHILE(@contador<=@contratosXcustomer)
	BEGIN 
	 SET	@contador=@contador+1;
     DECLARE @flag INT,@codigo INT;
	  SET @flag=0;
	 SET @codigo=1;
		WHILE (@flag=0)
			BEGIN
					
  
							IF  EXISTS(SELECT * FROM Contracts where contract_ID=@codigo)
								BEGIN
									SET  @codigo=@codigo+1;
								END 
							ELSE
	
								BEGIN
								     /*es un codigo valido no repetido*/
								     BEGIN TRY
													BEGIN TRAN
													INSERT INTO Contracts VALUES(@codigo,@customer_id,GETDATE(),GETDATE(),'observaciones del contrato');
													COMMIT
								     
								     
								     END TRY
								     BEGIN CATCH
								         ROLLBACK
								     END CATCH
								     							     
							         SET @flag=1; 
								END

		END  /*Fin del while controlado por @flag*/
		
		END /*fin del while controlado por @contador*/
		
		
		END
GO
/****** Object:  StoredProcedure [dbo].[insert_Solutions_For_Common_Problems]    Script Date: 01/03/2012 12:06:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_Solutions_For_Common_Problems]
as
BEGIN
DECLARE @solution_ID int

DECLARE cursor_solutionProblem CURSOR FOR
	SELECT solution_ID FROM Common_Solutions

	OPEN  cursor_solutionProblem

	FETCH  cursor_solutionProblem INTO @solution_ID

	WHILE (@@FETCH_STATUS=0)
		BEGIN
                   		BEGIN TRY
													BEGIN TRAN
						INSERT INTO Solutions_For_Common_Problems VALUES(1,@solution_ID);
						INSERT INTO Solutions_For_Common_Problems VALUES(2,@solution_ID);
						INSERT INTO Solutions_For_Common_Problems VALUES(3,@solution_ID);
						INSERT INTO Solutions_For_Common_Problems VALUES(4,@solution_ID);
													COMMIT						     
								     
								     END TRY
								     BEGIN CATCH
								         ROLLBACK
								     END CATCH		   
  
				FETCH  cursor_solutionProblem INTO @solution_ID
   
		END

CLOSE  cursor_solutionProblem
DEALLOCATE cursor_solutionProblem

end
GO
/****** Object:  StoredProcedure [dbo].[insert_Customers_Calls]    Script Date: 01/03/2012 12:06:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[insert_Customers_Calls]
AS
	BEGIN
				DECLARE @call_ID int,@customer_ID int,@call_center_id int,@call_outcome_code int,@call_status_codes int, @recommended_solution_id int,@staff_id int;
				SET @call_ID=0;
				SET @call_center_id=0;
				SET @call_outcome_code=0;
			    SET @call_status_codes=0;
			    SET @customer_ID=0;
			    SET @recommended_solution_id=0;
			    SET @staff_id=0;
				
				WHILE(@call_ID<1000000)
				  BEGIN 
				  SET	@call_ID=@call_ID+1;
				     
				         SET @call_center_id= ROUND(((9999)*RAND()+1),0)
				         SET @call_outcome_code= ROUND(((999999)*RAND()+1),0)   
				         SET @call_status_codes= ROUND(((99999)*RAND()+1),0)   
				         SET @customer_ID= ROUND(((999999)*RAND()+1),0)   
				         SET @recommended_solution_id= ROUND(((999999)*RAND()+1),0)   
				         SET @staff_id= ROUND(((99999)*RAND()+1),0)   
				         
				         
				           BEGIN TRY
									BEGIN TRAN
				                    INSERT INTO Customer_Calls VALUES (@call_ID,@customer_ID,@call_center_id,@call_outcome_code,@call_status_codes,@recommended_solution_id,@staff_id,GETDATE(),'llamada realizada','mskmsksmksmsmkdm sls,ls,slslsslssdedddd','dmdkmdkmdkdmdeooeoeoeoeoorp')
									COMMIT				        
				        END TRY
				        BEGIN CATCH
				           ROLLBACK
				          PRINT ERROR_MESSAGE();
				          END CATCH 
				    
				       
				  END	
END
GO
/****** Object:  StoredProcedure [dbo].[insert_contracts]    Script Date: 01/03/2012 12:06:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_contracts] 
as
BEGIN
DECLARE @customer_ID int

DECLARE cursor_customer CURSOR FOR
	SELECT customer_ID FROM Customers

	OPEN cursor_customer

	FETCH cursor_customer INTO @customer_ID

	WHILE (@@FETCH_STATUS=0)
		BEGIN
				EXEC insert2_contracts @customer_ID
  
				FETCH cursor_customer INTO @customer_ID
   
		END

CLOSE  cursor_customer
DEALLOCATE cursor_customer

END
GO

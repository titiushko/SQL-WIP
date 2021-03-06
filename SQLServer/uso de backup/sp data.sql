USE [exa]
GO
/****** Object:  StoredProcedure [dbo].[spEXA]    Script Date: 01/19/2012 17:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[spEXA] @n_generator int
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
				                    INSERT INTO EXA VALUES ('11/11/11','Atencion','as','asdfreqtg',1,'asde','s','sa','edrfrtghtu','zxcvfdgtr','11/11/11',1,'asqwdefrtghyujkiolñpolkihytgr',12.3,1,'11/11/11','sdfsdfsd');
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
				                    INSERT INTO EXA VALUES ('11/11/11','Atencion','as','asdfreqtg',1,'asde','s','sa','edrfrtghtu','zxcvfdgtr','11/11/11',1,'asqwdefrtghyujkiolñpolkihytgr',12.3,1,'11/11/11','sdfsdfsd');
									COMMIT				        
				        END TRY
				        BEGIN CATCH
				           ROLLBACK
				          PRINT ERROR_MESSAGE();
				          END CATCH 
				          
				          END  
				       
				  END	
END

restore database nombrebase 
FROM DISK = ' C:\base.bak'
WITH REPLACE


CREATE TABLE exa
(
    PERIODO  DATE NULL,
    NUMDOC   VARCHAR(10) NULL,
    CODBOD   CHAR(2) NULL,
    CORREL   VARCHAR(10) NULL,
    CODSAL   CHAR(1) NULL,
    depnum   VARCHAR(4) NULL,
    codvta   CHAR(1) NULL,
    codban   CHAR(2) NULL,
    cheque   VARCHAR(10) NULL,
    acuerdo  VARCHAR(10) NULL,
    fecent   DATE NULL,
    anulado  BIT NULL,
    recibido VARCHAR(30) NULL,
    totaldoc NUMERIC(12,2) NULL,
    impreso  BIT NULL,
    fecing   DATETIME NULL,
    coduser  VARCHAR(8) NULL
)

CREATE TRIGGER exa
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
exec spEXA 1000
END
GO


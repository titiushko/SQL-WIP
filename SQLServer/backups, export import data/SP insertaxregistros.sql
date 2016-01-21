USE [PARCIAL3]
GO

/****** Object:  StoredProcedure [dbo].[GENERAXREGISTROS]    Script Date: 01/20/2012 14:28:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GENERAXREGISTROS] 
	-- Add the parameters for the stored procedure here

AS
	DECLARE @i int
	DECLARE @FECHA date
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET @i = 0;
	SET @FECHA = '2012-01-20';
	

    -- Insert statements for procedure here
	WHILE (@i < 20000)
		BEGIN
			INSERT INTO MiExamenGC06016 VALUES
			(@FECHA, 'PRUEBA', 'SI', 'PRUEBA', '1', 'SI', '1', 'SI', 'PRUEBA', 'PRUEBA', @FECHA, 'T', 'PRUEBA', 12345, 'T', '2012-01-20 4:50:35.000', 'PRUEBA')
		SET @i = @i + 1;	
		END
END

GO

